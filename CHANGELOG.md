# Change Log

### 3.12.2(42)

Views and ViewControllers

- Several members in `SwiftUIBaseButtonState` and `UIKitBaseButtonState` are now marked as `public`

Extensions

- Issue with `UIStackView.addArrangedSubviews(_:)` is fixed
- `UIStackView.addArrangedSubviews(_:)` method is added that takes variadic `UIView`s

### [3.12.1(41)](https://github.com/VakhoKontridze/VCore/releases/tag/3.12.1) — *2022 07 07*

Extensions

- Issue with `minimumScaleFactor` in `UILabel.configure(alignment:lineBreakMode:numberOfLines:minimumScaleFactor:color:font:)` is fixed

### [3.12.0(40)](https://github.com/VakhoKontridze/VCore/releases/tag/3.12.0) — *2022 07 07*

Helpers

- `UIView` helper `NSLayoutConstraint` methods are added

### [3.11.0(39)](https://github.com/VakhoKontridze/VCore/releases/tag/3.11.0) — *2022 07 06*

Extensions

- `AppKit` extensions are added, but only for supporting underlying `SwiftUI` types
- Several `UIKit` extension are expanded to `macOS`, and are move to `Core Frameworks` directory
- `Color.blend(_:ratio1:with:ratio2)` method is added
- `Color.lighten(by:)` and `NSColor.darken(by:)` methods are added
- `Color.rgbaValues` and `NSColor.rgbaComponents` properties are added
- `Color.isRGBAEqual(to:)` method is added
- `NSColor.blend(_:ratio1:with:ratio2)` method is added
- `NSColor.lighten(by:)` and `NSColor.darken(by:)` methods are added
- `NSColor.rgbaValues` and `NSColor.rgbaComponents` properties are added
- `NSColor.isRGBAEqual(to:)` method is added
- `NSFont.withBoldStyling` and `NSColor.withItalicStyling` properties are added

### [3.10.3(38)](https://github.com/VakhoKontridze/VCore/releases/tag/3.10.3) — *2022 07 04*

General

- Bug fixes and improvements

### [3.10.2(37)](https://github.com/VakhoKontridze/VCore/releases/tag/3.10.2) — *2022 07 04*

Models

- `EdgeInsets`s are renamed to full names
- `GenericState`s and `GenericStateModel`s are renamed to full names

### [3.10.1(36)](https://github.com/VakhoKontridze/VCore/releases/tag/3.10.1) — *2022 07 04*

Extensions

- Missing deprecated name for `UIViewController.dismissKeyboardOnOutsideTap()` is added

### [3.10.0(35)](https://github.com/VakhoKontridze/VCore/releases/tag/3.10.0) — *2022 07 04*

Services and Managers

- `isConnectedToNetwork` `NetworkReachabilityService` on `watchOS` is no longer optional. Property will be set to `false` on app launch.

Views and ViewControllers

- `LeftAlignedCollectionViewFlowLayout` is added
- `CenterAlignedCollectionViewFlowLayout` is added
- `RightAlignedCollectionViewFlowLayout` is added

Models

- `HashableEnumeration` and `StringRepresentableHashableEnumeration` are added
- `BasicAnimation` is added
- State models are now added for `GenericStateModel`s
- Various `GenericState`s' and `GenericStateModel`s are added
- `zero`, `clearColors`, `clearUIColors`, and `clearNSColors` factory properties are added to  `GenericStateModel`s

Other

- Platform-specific compilation errors are fixed

### [3.9.2(34)](https://github.com/VakhoKontridze/VCore/releases/tag/3.9.2) — *2022 06 29*

XCode Templates

- Missing package import is added to `async` Gateway XCode template

### [3.9.1(33)](https://github.com/VakhoKontridze/VCore/releases/tag/3.9.1) — *2022 06 29*

Localization Service

- `LocalizationService` now reads locales directly from the `Bundle`
- `LocalizationService` no longer causes issues with default localization outside of non-English regions

### [3.9.0(32)](https://github.com/VakhoKontridze/VCore/releases/tag/3.9.0) — *2022 06 27*

Extensions

- `View.safeAreaMarginInsets(edges:)` method is added

### [3.8.1(31)](https://github.com/VakhoKontridze/VCore/releases/tag/3.8.1) — *2022 06 25*

Documentations

- Remove duplicate CLEAN Gateway documentation

### [3.8.0(30)](https://github.com/VakhoKontridze/VCore/releases/tag/3.8.0) — *2022 06 25*

Views and ViewControllers

- `SecurableTextField` is added
- `PlainDisclosureGroup` is added

Extensions

- `Task.sleep(seconds:)` method is added
- `Sequence.grouped(by:)` method now takes a throwing closure

Global Functions

- `KeyPath` equality and comparison functions are extended to support up to `10` members

### [3.7.0(29)](https://github.com/VakhoKontridze/VCore/releases/tag/3.7.0) — *2022 06 20*

Extensions

- `View.onFirstAppear(perform:)` method is added
- `View.navigationLink(isActive:destination:)` method is added that embeds invisible `NavigationLink` in the view hierarchy

Global Functions

- `KeyPath` equality and comparison functions are added, that equate and compare objects by up to six properties

XCode Templates

- `async` Gateway now contains a mock object for previews in `SwiftUI`

### [3.6.0(28)](https://github.com/VakhoKontridze/VCore/releases/tag/3.6.0) — *2022 06 17*

Views and ViewControllers

- Background colors of `contentView` in `ScrollableView` is now set to `UIColor.systemBackground`

Models

- `Models` folder is added
- `ModuleVersion` is added, that contains semantic version of major-minor-patch

Extensions

- `String.contains(_:)` method is added
- `String.contains(only:)` method is added

API

- `VCoreHumanReadableLocalizationProvider` is added, that automatically localized errors, and only exposes human-readable strings
- `DefaultVCoreLocalizationProvider` can now be initialized

XCode Templates

- Background colors of `UIKit` views are now set to `UIColor.systemBackground`
- Issue with method signature in completion-based Gateway is fixed

Other

- Missing demo app `.xcodeproj` file is now tracked

### [3.5.1(27)](https://github.com/VakhoKontridze/VCore/releases/tag/3.5.1) — *2022 06 15*

Architectural Pattern Helpers

- Issue with generic constraint in `StandardNavigable` is fixed

### [3.5.0(26)](https://github.com/VakhoKontridze/VCore/releases/tag/3.5.0) — *2022 06 15*

Services and Managers

- `NetworkReachabilityService` now supports `watchOS`
- `NetworkReachabilityService` calling connection notification twice is fixed

Helpers

- `EdgeInsets`s now conform to `Hashable`
- `GenericStateModel` now conform to `Hashable`, `Equatable`, and `Comparable`

Extensions

- `UIApplication.rootViewController` and `UIApplication.rootView` properties are added to complement `UIApplication.rootWindow`
- `UIRectCorner` has been extended to support additional corners

XCode Templates

- Templates now implement existential `any`

### [3.4.0(25)](https://github.com/VakhoKontridze/VCore/releases/tag/3.4.0) — *2022 06 11*

General

- Several `let` declarations are now mutable

Helpers

- `KVInitializableEnumeration` is renamed to `KeyPathInitializableEnumeration`

Architectural Pattern Helpers

- `UIAlertViewModel` has a new API that supports many buttons with state and style
- `UIActivityIndicatorViewable` now has a default implementation for `UIView`

Extensions

- `String.removing(_:)` methods now support `CharacterSet` `Array`s
- `String.keeping(only:)` methods now support `CharacterSet` `Array`s
- `Set.toggling(_:)` method is added to complement `Set.toggle(_:)`
- `Array.compactMapNonEmpty(_:)` is renamed to `compactMapNonNilNonEmpty`
- `CharacterSet.unified` property is added
- `Calendar.numberOfDaysInMonth(year:month:)` method is added
- `SizeConfiguration` is renamed to `MinIdealMaxSizes`
- App info properties are moved from `UIApplication` to `Bundle`, and support is added for all platforms
- `UIView.withTranslatesAutoresizingMaskIntoConstraints(_:)` method is added

### [3.3.1(24)](https://github.com/VakhoKontridze/VCore/releases/tag/3.3.1) — *2022 06 08*

Helpers

- Description of error thrown by `get` method in `ResultNoFailure` is fixed

### [3.3.0(23)](https://github.com/VakhoKontridze/VCore/releases/tag/3.3.0) — *2022 06 08*

Helpers

- Custom `Result` types now contain `map`/`mapError`, `flatMap`/`flatMapError`, and `get` methods
- Custom `Result` types now conform to `Equatable`

### [3.2.0(22)](https://github.com/VakhoKontridze/VCore/releases/tag/3.2.0) — *2022 05 26*

Views and ViewControllers

- `SwiftUIBaseButton` API is updated and old `init`s are deprecated

Extensions

- `Sequence.count(where:)` method is added

### [3.1.1(21)](https://github.com/VakhoKontridze/VCore/releases/tag/3.1.1) — *2022 05 21*

Services and Managers

- Issue with `AnyMultiPartFormDataFile` rename warning is fixed

### [3.1.0(20)](https://github.com/VakhoKontridze/VCore/releases/tag/3.1.0) — *2022 05 20*

Services and Managers

- `AnyMultiPartFormFile` is renamed to `AnyMultiPartFormDataFile`

Views and ViewControllers

- Issue with accessing `SwiftUIBaseButton` in `SwiftUI` is fixed

Extensions

- `View.bindToModalContext(_:)` method is added
- `OptionSet.elements` property is added
- Issue with accessing `cornerRadius` method in `SwiftUI` is fixed

### [3.0.2(19)](https://github.com/VakhoKontridze/VCore/releases/tag/3.0.2) — *2022 05 17*

Views and ViewControllers

- Public initializers are added to `SystemKeyboardInfo`

### [3.0.1(18)](https://github.com/VakhoKontridze/VCore/releases/tag/3.0.1) — *2022 05 17*

General

- Missing `public` access modifiers are added

### [3.0.0(17)](https://github.com/VakhoKontridze/VCore/releases/tag/3.0.0) — *2022 05 17*

General

- Project is migrated from `XCFramework` to `Swift Package`
- Project now partially supports `macOS`, `tvOS`, and `watchOS`
- Project is now covered under unit tests

Services and Managers

- `MultiPartFormDataBuilder` no longer throws errors

Network Client

- Requests methods with completion and result types are added
- JSON request headers are added

Helpers

- `EdgeInsets` objects now support `SwiftUI`'s `.padding()` modifiers
- `JSONTypeCasts` now support `Character`
- Issue when casting `Float` to `Double` in `JSONTypeCasts` is fixed
 
Extensions

- `width` parameter can now be passed to `UILabel.multiLineHeight()` method
- `FloatingPoint.bound(in:step:)` is renamed to `clamp`
- `NSObject.nsObjectName` is deprecated in favor of native `String(describing:)` method
- Various extensions are added

API

- `VCoreLocalizationService` is added, that supports localization within the package

Localization Service

- `LocalizationService` now supports language switching from app settings

### [2.3.0(16)](https://github.com/VakhoKontridze/VCore/releases/tag/2.3.0) — *2022 02 25*

Views and ViewControllers

- `ScrollableView` is added

VIPER Helpers

- `animated` and `completion` parameters are added to methods in `StandardNavigable`

Extensions

- `Optional.let(_:)` method is deprecated in favor of native `Optional.map(_:)` and `Optional.flatMap(_:)`

### [2.2.1(15)](https://github.com/VakhoKontridze/VCore/releases/tag/2.2.1) — *2022 02 14*

Views and ViewControllers

- State logic in `UIKitBaseButton` documentation is updated

VIPER Helpers

- Typo in `UIActivityIndicatorViewable` methods are fixed

XCode Templates

- `UITableViewCell` and `UICollectionViewCell` background colors are now set directly to cell, and not to `contentView`
- `with` argument label is added to `Gateway.fetch(_:completion:)`

### [2.2.0(14)](https://github.com/VakhoKontridze/VCore/releases/tag/2.2.0) — *2022 01 07*

Extensions

- Issues with `FloatingPoint.fixedInRange(_:step:)` methods are fixed
- Issues with conditional `View` function `if` are fixed
- `minimumScaleFactor` parameter is added to `UILabel` configuration method and initializer
- `FloatingPoint.fixedInRange(_:step:)` function is renamed to `bound` 

XCode Templates

- `UIView` (Dynamic Model) templates now have a default parameter value for model in initializers

### [2.1.1(13)](https://github.com/VakhoKontridze/VCore/releases/tag/2.1.1) — *2022 01 04*

Views and ViewControllers

- `isEnabled` is added to `UIKitBaseButton` to replace `isUserInteractionEnabled`

### [2.1.0(12)](https://github.com/VakhoKontridze/VCore/releases/tag/2.1.0) — *2022 01 01*

Network Client

- `NetworkProcessor` is renamed to `NetworkResponseProcessor`

VIPER Helpers

- `UITableViewDataSourceable.tableViewCellDequeueID(section:row:)` method is deprecated
- `UICollectionViewDataSourceable.collectionViewCellDequeueID(section:row:)` method is deprecated
- `dequeueID` parameter in `dequeueAndConfigureReusableCell(parameter:)` and `dequeueAndConfigureReusableCell(indexPath:parameter:)` methods are deprecated

Extensions

- `KeyPath` sort method `Sequence.sort(by:)` is added
- Conditional and `KeyPath` grouping methods `Sequence.grouped(by:)` are added

XCode Templates

- `UIViewController` `Factory` is fixed
- `with` parameter labels are removed from configuration methods

### [2.0.2(11)](https://github.com/VakhoKontridze/VCore/releases/tag/2.0.2) — *2021 12 29*

XCode Templates

- Issues with `UITableViewCellDataSourceable` methods are fixed

### [2.0.1(10)](https://github.com/VakhoKontridze/VCore/releases/tag/2.0.1) — *2021 12 29*

XCode Templates

- `UITableViewCell` initializer is fixed

### [2.0.0(9)](https://github.com/VakhoKontridze/VCore/releases/tag/2.0.0) — *2021 12 28*

General

- Framework now supports `iOS 13`

Services and Managers

- `MultiPartFormDataBuilder` is added

Network Client

- `NetworkService` is renamed to `NetworkClient`
- `NetworkClient` now supports async/await
- `NetworkServicePostProcessor` is renamed to `NetworkProcessor`
- Several cases are added to `NetworkError`
- `NetworkError.incompleteEntity` is renamed to `NetworkError.invalidData`

Views and ViewControllers

- `UIKitBaseButton` and `SwiftUIBaseButton` are added
- `KeyboardResponsiveViewController` are added
- `InfiniteScrollingCollectionView` are added

Helpers

- `EdgeInsets` objects now support insetting and addition/subtraction
- `VCoreErrorInfo` is removed

VIPER Helpers

- `UITableView` and `UICollectionView` dequeue and configure methods no longer crash if a cell identifier is not registered

Extensions

- Default parameters are added to `UIStackView` configuration method and initializer
- Various extensions are added

### [1.4.0(8)](https://github.com/VakhoKontridze/VCore/releases/tag/1.4.0) — *2021 11 09*

Extensions

- `UIView.roundCorners(_:by:)` now takes `CALayerCornerCurve` as parameter
- `UIScreen.displayCornerRadius` property is added

### [1.3.0(7)](https://github.com/VakhoKontridze/VCore/releases/tag/1.3.0) — *2021 11 09*

Extensions

- `UIViewController.withTabBarItem(_:)` method is added

### [1.2.0(6)](https://github.com/VakhoKontridze/VCore/releases/tag/1.2.0) — *2021 11 08*

Helpers

- Custom `EdgeInset` objects are added
- Generic `GenericStateModel` objects are added

VIPER Helpers

- `StandardNavigatable` is renamed to `StandardNavigable`

Extensions

- `UILabel.singleLineNaturalHeightConstant` property is renamed to `singleLineHeight`
- `UITableView.removeExtraSeparators()` and `UITableView.removeExtraAndLastSeparators()` are deprecated, as they have no effect
- `UIScreen.rootView` are deprecated in favor of `UIApplication.AppRootWindow` file under `Extra`
- `UIScreen.safeAreaInsets` are deprecated
- Various extensions are added

Extra

- Framework now contains additional files under `Extra`
- `LocalizationService` is added to `Extra`
- XCode Templates are added to `Extra`

### [1.1.0(5)](https://github.com/VakhoKontridze/VCore/releases/tag/1.1.0) — *2021 10 30*

Network Service

- `NetworkService` now supports initialization and post-processing delegation
- `NetworkService.shared` is deprecated
- `NetworkService`, `JSONEncoderService`, and `JSONDecoderService` now return `Error` instead of subsequent error types
- `NetworkSessionManager` is renamed to `SessionManager`

### [1.0.3(4)](https://github.com/VakhoKontridze/VCore/releases/tag/1.0.3) — *2021 10 25*

VIPER Helpers

- `ViewModel.uiAlertController` property can now be accessed to create an `UIAlertController`

### [1.0.2(3)](https://github.com/VakhoKontridze/VCore/releases/tag/1.0.2) — *2021 10 08*

VIPER Helpers

- `UICollectionViewDataSourceable` and `UITableViewDataSourceable` APIs are updated

### [1.0.1(2)](https://github.com/VakhoKontridze/VCore/releases/tag/1.0.1) — *2021 10 07*

Custom Results

- Result enums are now marked as `@frozen`

### [1.0.0(1)](https://github.com/VakhoKontridze/VCore/releases/tag/1.0.0) — *2021 10 07*

Initial release
