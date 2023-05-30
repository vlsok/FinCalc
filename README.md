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
Do not try to download .zip archive - it won't work. 
This git repository use git large file storage (`git lfs`) and without some files from there application will not launch :(

Instead of downloading .zip archive, do some steps below:
1. Open Terminal.app (or any other app you use to access terminal on macOS).
2. Open directory where you wish to have this project located.
3. Execute this line:  `git lfs clone https://github.com/vlsok/FinCalc`
4. Wait a little bit :)

If you haven't used git large file storage yet, then read [this article](https://git-lfs.com) and install `git lfs` first.












