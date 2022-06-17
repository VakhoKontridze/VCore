# VCore

## Table of Contents

- [Description](#description)
- [Compatibility](#compatibility)
- [Structure](#structure)
- [Demo](#demo)
- [Installation](#installation)
- [Versioning](#versioning)
- [Contact](#contact)

## Description

VCore is a Swift collection containing objects, functions, and extensions that I use for all my projects

## Compatibility

| Release Date | VCore | iOS  | macOS\* | tvOS\* | watchOS\* |
| ---          | ---   | ---  | ---     | ---    | ---       |
| 2022 05 17   | 3.0   | 13.0 | 10.15   | 13.0   | 6.0       |
| 2021 12 28   | 2.0   | 13.0 | -       | -      | -         |
| 2021 10 07   | 1.0   | 14.0 | -       | -      | -         |

**Limited support*

## Structure

Package files are grouped as:

- ***Services and Managers***. Services, managers, controllers, and formatters. For instance, `NetworkClient`.

- ***Views and ViewControllers***. Reusable non-scene `View`'s, `UIView`'s, and `UIViewController`'s.

- ***Models***. Reusable models. For instance, `EdgeInsets`'s and `GenericStateModel`'s.

- ***Helpers***. Non-service, non-extension objects and methods. For instance `StandardNavigable`.

- ***Global Functions***. Global functions. For instance, `TODO` and operators.

- ***Extensions***. Global extensions. Methods and properties are grouped by frameworks of origin—`Foundation`, `UIKit`, and `SwiftUI`.

- ***API***. Objects used for interfacing from you app/package to `VCore`. For instances, `VCoreLocalizationService`.

Package incudes folder `Extra`, which contains:

- ***XCode Templates***. Templates that can be used for accelerating workflow. Currently, templates cover scenes and gateways. For more info, refer to documnetation folder.

- Objects and methods that cannot be included in the package as they require additional customization or access to `AppDelegate`/`SceneDelegate`.

Project includes folder `Documentations`, which contains:

- Documentations and demo apps of UIKit/SwiftUI architectures

- Documentation of CLEAN architecture

## Demo

Package contains demo app, that can be used to test functionality of the package.

## Installation

#### Swift Package Manager

Add `https://github.com/VakhoKontridze/VCore` as a Swift Package in Xcode and follow the instructions.

## Versioning

***Major***. Major changes, such as big overhauls

***Minor***. Minor changes, such as new objects, function, and extensions

***Patch***. Bug fixes and improvements

## Contact

e-mail: vakho.kontridze@gmail.com
