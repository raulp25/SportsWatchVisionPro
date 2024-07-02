# SportsWatch - VisionOS
This is a prototype to watch sports media live streaming with additional features.
### Youtube Video
[Watch on Youtube ▷](https://www.youtube.com/watch?v=dIUEGK46N2o&t=246s&ab_channel=RaulP)

[![VISION-PRO-3.png](https://i.postimg.cc/0Q55fYH6/VISION-PRO-3.png)](https://www.youtube.com/watch?v=dIUEGK46N2o&t=246s&ab_channel=RaulP)

## Installation
To run the app, you need to have the following requirements:

- Xcode 15.2

Please follow the steps below to install and run the app:

1. Clone this repository to your local machine:
   
   ```
   git clone https://github.com/raulp25/SportsWatchVisionPro
   ```
   
3. Run the app

## Known Issues
Please note the following known issues and compatibility considerations:

 - If the window is full-sized, the segmented Picker that represents Score|Timeline|Line-Up|Stats tabs in ContentView won't recognize clicks
   made to tabs that are on the right side. You need to resize the window to a smaller size so it recognizes clicks in the right direction. Clicks in the left direction in
   the Picker are always recognized whether the window is fully sized or not.
   
 - When switching Immersive spaces on the InteractiveMatchOptionView component, sometimes it won't refresh and call the code inside the current card, and it won't update the
   close button text in cards that display that button.

It's important to provide this information to users so they are aware of any potential issues they may encounter while using the app with Xcode 15.2 and VisionOS simulator.

## About the project
### Features
- Watch Videos
- Immersive spaces
- Ornament tabs
- Get information about the current sport League
- Get information about the team players
- Subscription plan
- RealityKit
- AVKit
- Combine
