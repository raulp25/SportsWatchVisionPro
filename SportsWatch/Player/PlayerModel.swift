//
//  PlayerModel.swift
//  SportsWatch
//
//  Created by Raul Pena on 29/01/24.
//

import SwiftUI
import AVKit
import Combine

/// Enum representing the state triggered by the InlineControlsView Slider
enum PlayerScrubState: Equatable {
    case reset
    case scrubStarted
    case scrubContinues(TimeInterval)
    case scrubEnded(TimeInterval)
}

/// The presentation modes the player supports.
enum Presentation {
    /// Indicates to present the player as a child of a parent user interface.
    case inline
}

@Observable final class PlayerModel: NSObject {
    
    let timeScale = CMTimeScale(1000)
    let time: CMTime
    
    // A Boolean value that indicates whether playback is currently active.
    private(set) var isPlaying = false
    
    // A Boolean value that indicates whether playback of the current item is complete.
    private(set) var isPlaybackComplete = false
    
    /// A Boolean value indicating if a video is being loaded.
    var isLoadingVideo = false
    /// A Boolean value indicating if the replay button is visible
    ///
    /// Indicates if the custom InlineControlsView's replay button is showing or not
    var isReplayBtnVisible = false
    /// A Boolean value indicating if we are in the initial state after loading a video or when replaying a video
    ///
    /// This allows the displayTime property to start at exactly 0 seconds when the addPeriodicTimeObserver gets called
    /// the first time after loading or replaying a video
    var isInitialState = true
    /// The presentation in which to display the current media.
    private(set) var presentation: Presentation = .inline 
    
    // The currently loaded video.
    private(set) var currentItem: Video? = nil
    
    /// An object that manages the playback of a video's media.
    var player = AVPlayer()
    
    /// The currently presented player view controller.
    ///
    /// The life cycle of an `AVPlayerViewController` object is different than a typical view controller. In addition
    /// to displaying the player UI within your app, the view controller also manages the presentation of the media
    /// outside your app UI such as when using AirPlay, Picture in Picture, or docked full window. To ensure the view
    /// controller instance is preserved in these cases, the app stores a reference to it here (which
    /// is an environment-scoped object).
    ///
    /// This value is set by a call to the `makePlayerViewController()` method.
    private var playerViewController: AVPlayerViewController? = nil
    private var playerViewControllerDelegate: AVPlayerViewControllerDelegate? = nil
    
    private(set) var shouldAutoPlay = true
    
    /// A token for periodic observation of the player's time.
    private var timeObserver: Any? = nil
    private var subscriptions = Set<AnyCancellable>()
    
    /// Display time that will be bound to the scrub slider.
    var displayTime: TimeInterval = 0
    /// A Boolean value indicating wether the player was in playing or pause state
    ///
    /// Use this property to control the automatic show / hide state of the custom InlineControlsView buttons
    var wasPlaying: Bool = true
    
    /// The observed time, which may not be needed by the UI.
    var observedTime: TimeInterval = 0
    /// The current video duration
    var itemDuration: TimeInterval = 0

    /// Publish timeControlStatus
    var timeControlStatus: AVPlayer.TimeControlStatus = .paused
    
    /// Time observer.
    private var periodicTimeObserver: Any?
    /// A Boolean value indicating whether the user is playing an alternative media video like a goal scored during a match.
    ///
    /// This property is set to true under the following conditions:
    /// - The user starts playing an alternative video, such as a scored goal.
    ///
    /// When this property is true, an alternative button will be displayed inside the player bounds
    /// that allows the user to return to the current game livestream.
    var isPlayingAlternativeMediaOnMatch = false
    
    /// The current scrub state
    var scrubState: PlayerScrubState = .reset {
        didSet {
            switch scrubState {
            case .reset:
                return
            case .scrubStarted:
                return
            // This state gets triggered when the user is dragging the Slider
            case .scrubContinues(let seekTime):
                // Floor the current seek time provided by the slider and the item duration,
                // if they are the same end the video to avoid bad synchronization by comparing
                // miliseconds.
                let floorDisplayTime = floor(seekTime)
                let floorItemDuration = floor(itemDuration)
                
                if !isPlaying && 
                   floorDisplayTime == floorItemDuration {
                    player.seek(to: CMTime(seconds: itemDuration,
                                                       preferredTimescale: timeScale),
                                            toleranceBefore: .zero,
                                            toleranceAfter: .zero)
                    showReplayBtn()
                } else {
                    hideReplayBtn()
                }
            case .scrubEnded:
                return
            }
        }
    }

    
    override init() {
        self.time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        super.init()
        addPeriodicTimeObserver()
        observePlayback()
        addItemDurationPublisher()
        
        Task {
            await configureAudioSession()
        }
    }
    
    deinit {
        removePeriodicTimeObserver()
        reset()
    }
    
    /// Creates a new player view controller object.
    /// - Returns: a configured player view controller.
    func makePlayerViewController() -> AVPlayerViewController {
        let delegate = PlayerViewControllerDelegate(player: self)
        let controller = AVPlayerViewController()
        controller.player = player
        controller.delegate = delegate

        // Set the model state
        playerViewController = controller
        playerViewControllerDelegate = delegate
        
        return controller
    }
    
    private func observePlayback() {
        // Return early if the model calls this more than once.
        guard subscriptions.isEmpty else { return }
        
        // Observe the time control status to determine whether playback is active.
        player.publisher(for: \.timeControlStatus)
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] status in
                guard let self = self else { return }
                self.isPlaying  = status == .playing
            }
            .store(in: &subscriptions)
        
        // Observe this notification to know when a video plays to its end.
        NotificationCenter.default
            .publisher(for: AVPlayerItem.didPlayToEndTimeNotification)
            .receive(on: DispatchQueue.main)
            .map { _ in true }
            .sink { [weak self] isPlaybackComplete in
                self?.isPlaybackComplete = isPlaybackComplete
                self?.wasPlaying = false
                self?.showReplayBtn()
            }
            .store(in: &subscriptions)
        
        // Observe audio session interruptions.
        NotificationCenter.default
            .publisher(for: AVAudioSession.interruptionNotification)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] notification in
                
                // Wrap the notification in helper type that extracts the interruption type and options.
                guard let result = InterruptionResult(notification) else { return }
                
                // Resume playback, if appropriate.
                if result.type == .ended && result.options == .shouldResume {
                    self?.player.play()
                }
            }.store(in: &subscriptions)
    }
    
    
    private func addPeriodicTimeObserver() {
        self.periodicTimeObserver = player.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] (time) in
            guard let self = self else { return }
            // Always update observed time.
            self.observedTime = time.seconds

            switch self.scrubState {
            case .reset:
                if isInitialState {
                    self.displayTime = 0
                    isInitialState.toggle()
                } else {
                    self.displayTime = time.seconds
                }
            case .scrubStarted, .scrubContinues(_):
                // When scrubbing, the displayTime is bound to the Slider view, so
                // do not update it here.
                break
            case .scrubEnded(let seekTime):
                // When user slides the Slider to the end of the video duration this
                // floors the current item duration and updates the UI ignoring miliseconds
                let floorDisplayTime = floor(seekTime)
                let floorItemDuration = floor(itemDuration)
                
                if floorDisplayTime == floorItemDuration {
                    self.displayTime = floorItemDuration
                    wasPlaying = false
                } else {
                    self.scrubState = .reset
                    self.displayTime = seekTime
                }
                
                
            }
        }
    }
    
    private func addItemDurationPublisher() {
        player
            .publisher(for: \.currentItem?.duration)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] (newStatus) in
                guard let newStatus = newStatus,
                      let self = self
                else { return }
                self.itemDuration = newStatus.seconds
                isLoadingVideo = false
            }
            ).store(in: &subscriptions)
    }
    
    private func removePeriodicTimeObserver() {
        guard let periodicTimeObserver = self.periodicTimeObserver else { return }
        player.removeTimeObserver(periodicTimeObserver)
        self.periodicTimeObserver = nil
    }
    
    /// Configures the audio session for video playback.
    private func configureAudioSession() async {
        let session = AVAudioSession.sharedInstance()
        do {
            // Configure the audio session for playback. Set the `moviePlayback` mode
            // to reduce the audio's dynamic range to help normalize audio levels.
            try session.setCategory(.playback, mode: .moviePlayback)
        } catch {
            print("Unable to configure audio session: => \(error.localizedDescription)")
        }
    }


    
    /// Loads a video for playback in the requested presentation.
    /// - Parameters:
    ///   - video: The video to load for playback.
    ///   - presentation: The style in which to present the player.
    ///   - autoplay: A Boolean value that indicates whether to auto play that the content when presented.
    func loadVideo(_ video: Video, presentation: Presentation = .inline, autoplay: Bool = true) {
        // Update the model state for the request.
        isLoadingVideo = true
        currentItem = video
        shouldAutoPlay = autoplay
        isPlaybackComplete = false
        
        switch presentation {
        case .inline:
            replaceCurrentItem(with: video)
        }

        // In visionOS, configure the spatial experience for either .inline or .fullWindow playback.
        configureAudioExperience(for: presentation)

        // Set the presentation.
        self.presentation = presentation
   }
    
    private func replaceCurrentItem(with video: Video) {
        // Create a new player item and set it as the player's current item.
        // let playerItem = AVPlayerItem(url: video.resolvedURL)
        let playerItem = AVPlayerItem(url: video.url)
        // Set external metadata on the player item for the current video.
        playerItem.externalMetadata = createMetadataItems(for: video)
        // Set the new player item as current, and begin loading its data.
        player.replaceCurrentItem(with: playerItem)
        
        player.seek(to: .zero, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
    
    func videoChangeTime(isForward: Bool = true){
        let floorDisplayTime = floor(self.displayTime)
        var nextSeconds = isForward ? floorDisplayTime + 5 : floorDisplayTime - 5
        if nextSeconds < 0  {
            nextSeconds = 0
        }
        if nextSeconds > itemDuration {
            nextSeconds = itemDuration
            showReplayBtn()
        } else {
            hideReplayBtn()
        }
        let timeCM = CMTime(seconds: nextSeconds, preferredTimescale: self.timeScale)
        
        self.displayTime = nextSeconds
        self.player.seek(to: timeCM, toleranceBefore: .zero, toleranceAfter: .zero)
    }
    
    /// Clears any loaded media and resets the player model to its default state.
    func reset() {
        isPlayingAlternativeMediaOnMatch = false
        isInitialState = true
        hideReplayBtn()
        
        currentItem = nil
        player.replaceCurrentItem(with: nil)
        playerViewController = nil
        playerViewControllerDelegate = nil
    }
    
    /// Creates metadata items from the video items data.
    /// - Parameter video: the video to create metadata for.
    /// - Returns: An array of `AVMetadataItem` to set on a player item.
    private func createMetadataItems(for video: Video) -> [AVMetadataItem] {
        let mapping: [AVMetadataIdentifier: Any] = [
            .commonIdentifierTitle: video.title,
            .commonIdentifierArtwork: video.imageData,
//            .commonIdentifierDescription: video.description,
            .commonIdentifierDescription: "Ferrari portofino",
            .commonIdentifierCreationDate: video.info.releaseDate,
            .iTunesMetadataContentRating: video.info.contentRating,
            .quickTimeMetadataGenre: video.info.genres
        ]
        return mapping.compactMap { createMetadataItem(for: $0, value: $1) }
    }
    
    /// Creates a metadata item for a the specified identifier and value.
    /// - Parameters:
    ///   - identifier: an identifier for the item.
    ///   - value: a value to associate with the item.
    /// - Returns: a new `AVMetadataItem` object.
    private func createMetadataItem(for identifier: AVMetadataIdentifier,
                                    value: Any) -> AVMetadataItem {
        let item = AVMutableMetadataItem()
        item.identifier = identifier
        item.value = value as? NSCopying & NSObjectProtocol
        // Specify "und" to indicate an undefined language.
        item.extendedLanguageTag = "und"
        return item.copy() as! AVMetadataItem
    }
    
    /// Configures the user's intended spatial audio experience to best fit the presentation.
    /// - Parameter presentation: the requested player presentation.
    private func configureAudioExperience(for presentation: Presentation) {
        #if os(visionOS)
        do {
            let experience: AVAudioSessionSpatialExperience
            switch presentation {
            case .inline:
                // Set a large sound stage size because we are watching sports.
                experience = .headTracked(soundStageSize: .large, anchoringStrategy: .automatic)
            }
            try AVAudioSession.sharedInstance().setIntendedSpatialExperience(experience)
        } catch {
            print("Unable to set the intended spatial experience: => \(error.localizedDescription)")
        }
        #endif
    }

    // MARK: - Transport Control
    func play() {
        hideReplayBtn()
        player.play()
    }
    
    func pause() {
        player.pause()
    }
    
    func togglePlayback() {
        if player.timeControlStatus == .paused {
            wasPlaying = true
        } else {
            wasPlaying = false
        }
        
        player.timeControlStatus == .paused ? play() : pause()
    }
    
    func hideReplayBtn() {
        isReplayBtnVisible = false
    }
    
    func showReplayBtn() {
        isReplayBtnVisible = true
    }
    
    func replay() {
        hideReplayBtn()
        isPlaybackComplete = false
        player.seek(to: .zero, toleranceBefore: .zero, toleranceAfter: .zero)
        isInitialState.toggle()
        scrubState = .reset
        play()
    }
    
    private func removeTimeObserver() {
        guard let timeObserver = timeObserver else { return }
        player.removeTimeObserver(timeObserver)
        self.timeObserver = nil
    }
    
    /// A coordinator that acts as the player view controller's delegate object.
    final class PlayerViewControllerDelegate: NSObject, AVPlayerViewControllerDelegate {
        
        let player: PlayerModel
        
        init(player: PlayerModel) {
            self.player = player
        }
        
        #if os(visionOS)
        // The app adopts this method to reset the state of the player model when a user
        // taps the back button in the visionOS player UI.
        func playerViewController(_ playerViewController: AVPlayerViewController,
                                  willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
            /* this is for when user clicks back button on full screen
               player */
            Task { @MainActor in
                // Calling reset dismisses the full-window player.
                player.reset()
                print("player dismissed delegate: => ")
            }
        }
        #endif
    }
}
