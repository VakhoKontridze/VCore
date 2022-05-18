# Change Log

#### [3.0.2(19)](https://github.com/VakhoKontridze/VCore/releases/tag/3.0.2) — *2022 05 17*

Views and ViewControllers

- Public initializers are added to `SystemKeyboardInfo`

#### [3.0.1(18)](https://github.com/VakhoKontridze/VCore/releases/tag/3.0.1) — *2022 05 17*

General

- Missing `public` access modifiers are added

#### [3.0.0(17)](https://github.com/VakhoKontridze/VCore/releases/tag/3.0.0) — *2022 05 17*

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

- `width` parameter can now be passed to `UILabel`'s `multiLineHeight` method
- `FloatingPoint` method `bound` is renamed to `clamp`
- `NSObject` method `nsObjectName` is deprecated in favor of `String(describing:)` method
- Various extensions are added

API

- `VCoreLocalizationService` is added, that supports localization within the package

Localization Service

- `LocalizationService` now supports langauge switching from app settings

#### [2.3.0(16)](https://github.com/VakhoKontridze/VCore/releases/tag/2.3.0) — *2022 02 25*

Views and ViewControllers

- `ScrollableView` is added

VIPER Helpers

- `animated` and `completion` parameters are added to methods in `StandardNavigable`

Extensions

- `Optional` method `let` is deprecated in favor of native `map` and `flatMap`

#### [2.2.1(15)](https://github.com/VakhoKontridze/VCore/releases/tag/2.2.1) — *2022 02 14*

Views and ViewControllers

- State logic in `UIKitBaseButton` documentation is updated

VIPER Helpers

- Typo in `UIActivityIndicatorViewable` methods are fixed

XCode Templates

- `UITableViewCell` and `UICollectionViewCell` background colors are now set directly to cell, and not to `contentView`
- `with` parameter label is added to `Gateway`

#### [2.2.0(14)](https://github.com/VakhoKontridze/VCore/releases/tag/2.2.0) — *2022 01 07*

Extensions

- Issues with `fixedInRange` extenion with steps is fixed
- Issues with conditional `View` function `if` is fixed
- `minimumScaleFactor` parameter is added to `UILabel` configuration methods
- `fixedInRange` function is renamed to `bound` 

XCode Templates

- `UIView` (Dynamic Model) templates now have a default parameter value for model in `init`

#### [2.1.1(13)](https://github.com/VakhoKontridze/VCore/releases/tag/2.1.1) — *2022 01 04*

Views and ViewControllers

- `isEnabled` is added to `UIKitBaseButton` to replace `isUserInteractionEnabled`

#### [2.1.0(12)](https://github.com/VakhoKontridze/VCore/releases/tag/2.1.0) — *2022 01 01*

Network Client

- `NetworkProcessor` is renamed to `NetworkResponseProcessor`

VIPER Helpers

- `tableViewCellDequeueID` method in `UITableViewDataSourceable` is deprecated
- `collectionViewCellDequeueID` method in `UICollectionViewDataSourceable` is deprecated
- `dequeueID` parameter in `dequeueAndConfigureReusableCell` methods are deprecated

Extensions

- `KeyPath` sort method is added to `Array`
- `Sequence` conditional grouping methods are added

XCode Templates

- `UIViewController` `Factory` is fixed
- `with` parameter name are removed from configuration methods

#### [2.0.2(11)](https://github.com/VakhoKontridze/VCore/releases/tag/2.0.2) — *2021 12 29*

XCode Templates

- `UITableViewCellDataSourceable` methods in are fixed

#### [2.0.1(10)](https://github.com/VakhoKontridze/VCore/releases/tag/2.0.1) — *2021 12 29*

XCode Templates

- `UITableViewCell` initializer is fixed

#### [2.0.0(9)](https://github.com/VakhoKontridze/VCore/releases/tag/2.0.0) — *2021 12 28*

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

Views and ViewContollers

- `UIKitBaseButton` and `SwiftUIBaseButton` are added
- `KeyboardResponsiveViewController` are added
- `InfiniteScrollingCollectionView` are added

Helpers

- `EdgeInsets` objects now support insetting and addition/subtraction
- `VCoreErrorInfo` is removed

VIPER Helpers

- `UITableView` and `UICollectionView` dequeue and configure methods no longer crash if a cell identifier is not registered

Extensions

- Default parameter values are added to `UIStackView` configuration methods
- Various extensions are added

#### [1.4.0(8)](https://github.com/VakhoKontridze/VCore/releases/tag/1.4.0) — *2021 11 09*

Extensions

- `CALayerCornerCurve` can now be passed to `roundCorners` method in `UIView`
- `displayCornerRadius` property is added to `UIScreen`

#### [1.3.0(7)](https://github.com/VakhoKontridze/VCore/releases/tag/1.3.0) — *2021 11 09*

Extensions

- `withTabBarItem` method is added to `UIViewController`

#### [1.2.0(6)](https://github.com/VakhoKontridze/VCore/releases/tag/1.2.0) — *2021 11 08*

Helpers

- Custom `EdgeInset` objects are added
- Generic `GenericStateModel` objects are added

VIPER Helpers

- `StandardNavigatable` is renamed to `StandardNavigable`

Extensions

- `UILabel`'s `singleLineNaturalHeightConstant` is renamed to `singleLineHeight`
- `UITableView`'s `removeExtraSeparators` and `removeExtraAndLastSeparators` are deprecated, as have no effect
- `UIScreen.rootView` are deprecated in favor of `UIApplication.AppRootWindow` file under `Extra`
- `UIScreen.safeAreaInsets` are deprecated
- Various extensions are added

Extra

- Framework now contains additional files under `Extra`
- `LocalizationService` is added to `Extra`
- XCode Templates are added to `Extra`

#### [1.1.0(5)](https://github.com/VakhoKontridze/VCore/releases/tag/1.1.0) — *2021 10 30*

Network Service

- `NetworkService` now supports initialization and post-processing delegation
- `NetworkService.shared` is deprecated
- `NetworkService`, `JSONEncoderService`, and `JSONDecoderService` now return `Error` instead of subsequent error types
- `NetworkSessionManager` is renamed to `SessionManager`

#### [1.0.3(4)](https://github.com/VakhoKontridze/VCore/releases/tag/1.0.3) — *2021 10 25*

VIPER Helpers

- `uiAlertController` in `ViewModel` can now be accessed to create an `UIAlertController`

#### [1.0.2(3)](https://github.com/VakhoKontridze/VCore/releases/tag/1.0.2) — *2021 10 08*

VIPER Helpers

- `UICollectionViewDataSourceable` and `UITableViewDataSourceable` APIs are updated

#### [1.0.1(2)](https://github.com/VakhoKontridze/VCore/releases/tag/1.0.1) — *2021 10 07*

Custom Results

- Result enums are now marked as `@frozen`

#### [1.0.0(1)](https://github.com/VakhoKontridze/VCore/releases/tag/1.0.0) — *2021 10 07*

Initial release
