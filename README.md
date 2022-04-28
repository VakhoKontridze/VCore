# VCore

## Table of Contents

- [Description](#description)
- [Compatibility](#compatibility)
- [Library Structure](#library-structure)
- [Demo](#demo)
- [Installation](#installation)
- [Versioning](#versioning)
- [Contact](#contact)

## Description

VCore is a Swift collection containing objects, functions, and extensions that I use for all my projects

## Compatibility

| VCore | iOS    |
| ---   | ---    |
| 3.x.x | 13.x.x |
| 2.x.x | 13.x.x |
| 1.x.x | 14.x.x |

## Library Structure

Project files are grouped as:

- ***Views and ViewContollers***. Reusable non-scene views and viewcontrollers.

- ***Services and Managers***. Services, managers, controllers, and formatters. For instance, `NetworkClient`.

- ***Helpers***. Non-service, non-extension objects and methods. For instance, helper methods for creating `GenericStateModel`'s and `StandardNavigable`.

- ***Global Functions***. Global functions. For instance, `TODO` and operators.

- ***Extensions***. Global extensions. Methods and properties are grouped by frameworks of origin—`Foundation`, `UIKit`, and `SwiftUI`.

Project incudes folder `Extra`, which contains:

- ***XCode Templates***. Templates that can be used for accelerating workflow. Currently, templates cover scenes and gateways. For more info, refer to documnetation folder.

- ***Misc***. Objects and methods that cannot be included in a library as they require additional customization or access to `AppDelegate`/`SceneDelegate`.

## Demo

Project contains demo app, that can be used to test functionality of the library.

## Installation

Library doesn't support CocoaPods or Carthage.

### Swift Package Manager

Add `https://github.com/VakhoKontridze/VCore` as a Swift Package in Xcode and follow the instructions.

![SPM1](./img/SPM1.jpg)

## Versioning

***Major***. Major changes, such as big overhauls

***Minor***. Minor changes, such as new objects, function, and extensions

***Patch***. Bug fixes and improvements

## Contact

e-mail: vakho.kontridze@gmail.com
