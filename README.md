# CKeyboard

[![CI Status](https://img.shields.io/travis/srqa3h.com@gmail.com/CKeyboard.svg?style=flat)](https://travis-ci.org/srqa3h.com@gmail.com/CKeyboard)
[![Version](https://img.shields.io/cocoapods/v/CKeyboard.svg?style=flat)](https://cocoapods.org/pods/CKeyboard)
[![License](https://img.shields.io/cocoapods/l/CKeyboard.svg?style=flat)](https://cocoapods.org/pods/CKeyboard)
[![Platform](https://img.shields.io/cocoapods/p/CKeyboard.svg?style=flat)](https://cocoapods.org/pods/CKeyboard)

## Example

//        default keyboard
CKeyboard.create(textFileds: [textField], characters: CKeyboard.defulteAlphabet)

//        Custom keyboard
//        default height = 200
//        default alphabetInLine = 6
//        default isHeaderHidden = false
//        default doneButton = (title = Done)

//        if you want to set any default value for parameter pass nil

CKeyboard.create(textFileds: [textField], characters: ["A","B","C"] , height: 210, alphabetInLine: 7, backgroundColor: nil, isHeaderHidden: false, headerBackroundColor: nil, doneButton: nil)


To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

CKeyboard is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CKeyboard'
```

## Author

fadel sultan
Email: fadel.sultan@gmail.com
 mohammad qurain 
 Email: mohammad15294@gmail.com

## License

CKeyboard is available under the MIT license. See the LICENSE file for more info.
