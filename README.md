# VCore

## Table of Contents

- [Description](#description)
- [Compatibility](#compatibility)
- [Package Structure](#package-structure)
- [Demo](#demo)
- [Installation](#installation)
- [Versioning](#versioning)
- [Contact](#contact)

## Description

VCore is a Swift collection containing objects, functions, and extensions that I use for all my projects

## Compatibility

| VCore | Release    | iOS  | macOS\* | tvOS\* | watchOS\* |
| ---   | ---        | ---  | ---     | ---    | ---       |
| 3.0.0 | 2022 05 17 | 13.0 | 10.15   | 13.0   | 6.0       |
| 2.0.0 | 2021 12 28 | 13.0 | -       | -      | -         |
| 1.0.0 | 2021 10 07 | 14.0 | -       | -      | -         |

**Limited support*

## Package Structure

Project files are grouped as:

- ***Services and Managers***. Services, managers, controllers, and formatters. For instance, `NetworkClient`.

- ***Views and ViewContollers***. Reusable non-scene `UIView`'s and `UIViewController`'s.

- ***Helpers***. Non-service, non-extension objects and methods. For instance, helper methods for creating `GenericStateModel`'s and `StandardNavigable`.

- ***Global Functions***. Global functions. For instance, `TODO` and operators.

- ***Extensions***. Global extensions. Methods and properties are grouped by frameworks of origin—`Foundation`, `UIKit`, and `SwiftUI`.

- ***API***. Objects used for interfacing from you app/package to `VCore`. For instances, `VCoreLocalizationService`.

Project incudes folder `Extra`, which contains:

- ***XCode Templates***. Templates that can be used for accelerating workflow. Currently, templates cover scenes and gateways. For more info, refer to documnetation folder.

- Objects and methods that cannot be included in the package as they require additional customization or access to `AppDelegate`/`SceneDelegate`.

## Demo

Project contains demo app, that can be used to test functionality of the package.

## Installation

#### Swift Package Manager

Add `https://github.com/VakhoKontridze/VCore` as a Swift Package in Xcode and follow the instructions.

## Versioning

***Major***. Major changes, such as big overhauls

***Minor***. Minor changes, such as new objects, function, and extensions

***Patch***. Bug fixes and improvements

## Contact

e-mail: vakho.kontridze@gmail.com
