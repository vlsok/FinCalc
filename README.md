# About this project
FinCalc is a pet-project application. It allows users to get fresh exchange rates, location of exchange points nearby, calculate VAT (Value Added Tax) and PT (Property Tax) and save results of calculations just in case.

## Architecture pattern
- MVVM (without reactive programming)

## Technologies
- UIKit
- CocoaPods
- Swift Package Manager
- Design from Figma
- UserDefaults for saving data
- Generics
- Yandex.API mobile maps
- Typographic font styles
- Customized animations (Tab Bar, toggle between screens, etc.)
- UITests

## Screenshots
All screenshots was made on Simulator iPhone 14 Pro.

Exchange rates            |  Calculations          |  Settings
:-------------------------:|:-------------------------:|:-------------------------:
![](https://github.com/vlsok/FinCalc/blob/main/Screenshots/Exchange_rates.png)  |  ![](https://github.com/vlsok/FinCalc/blob/main/Screenshots/Calculations.png) |  ![](https://github.com/vlsok/FinCalc/blob/main/Screenshots/Settings.png)


# How to install

Follow these steps:
1. Download this project on your mac (.zip-archive or using `git clone https://github.com/vlsok/FinCalc`).
2. Open Terminal.app (or any other app you use to access terminal on macOS), write and execute a path to FinCalc folder, which contains `Podfile` (for example, `~/Desktop/FinCalc-main-4/FinCalc`)
3. Execute `pod install`.
4. Open `FinCalc.xcworkspace` file in order to reach full program and launch application on your iPhone or Simulator.












