## Change Log

#### [2.X.X(14)]

- `minimumScaleFactor` parameter has been added to `UILabel` configuration methods
- `UIView` (Dynamic Model) XCode Templates now has a default parameter value for model in init 

#### [2.1.1(13)](https://github.com/VakhoKontridze/VCore/releases/download/2.1.1/VCore.xcframework.zip) — *2021 01 04*

- `isEnabled` has been added to `UIKitBaseButton` to replace `isUserInteractionEnabled`

#### [2.1.0(12)](https://github.com/VakhoKontridze/VCore/releases/download/2.1.0/VCore.xcframework.zip) — *2021 01 01*

- `KeyPath` sort method has been added to `Array`
- `UIViewController` `Factory` in XCode Templates has been fixed
- `Sequence` conditional grouping methods have been added
- `NetworkProcessor` has been renamed to `NetworkResponseProcessor`
- `with` parameter name has been removed from configuration methods
- `tableViewCellDequeueID` method in `UITableViewDataSourceable` has been deprecated
- `collectionViewCellDequeueID` method in `UICollectionViewDataSourceable` has been deprecated
- `dequeueID` parameter in `dequeueAndConfigureReusableCell` methods have been deprecated

#### [2.0.2(11)](https://github.com/VakhoKontridze/VCore/releases/download/2.0.2/VCore.xcframework.zip) — *2021 12 29*

- `UITableViewCellDataSourceable` method in XCode Templates has been fixed

#### [2.0.1(10)](https://github.com/VakhoKontridze/VCore/releases/download/2.0.1/VCore.xcframework.zip) — *2021 12 29*

- `UITableViewCell` initializer in XCode Templates has been fixed

#### [2.0.0(9)](https://github.com/VakhoKontridze/VCore/releases/download/2.0.0/VCore.xcframework.zip) — *2021 12 28*

- Framework is no longer compatible with version `1.X.X`
- Framework now supports `iOS 13`
- `NetworkClient` now supports async/await
- `MultiPartFormDataBuilder` has been added
- `UIKitBaseButton` and `SwiftUIBaseButton` have been added
- `KeyboardResponsiveViewController` has been added
- `InfiniteScrollingCollectionView` has been added
- `EdgeInsets` objects now support insetting and addition/subtraction
- Several cases have been added to `NetworkError`
- `UITableView` and `UICollectionView` dequeue and configure methods would no crash if a cell identifier is not registered
- `VCoreErrorInfo` has been removed
- `NetworkService` has been renamed to `NetworkClient`
- `NetworkServicePostProcessor` has been renamed to `NetworkProcessor`
- `NetworkError.incompleteEntity` has been renamed to `NetworkError.invalidData`
- Default parameter values have been added to `UIStackView` configuration methods
- Various extensions have been added

#### [1.4.0(8)](https://github.com/VakhoKontridze/VCore/releases/download/1.4.0/VCore.xcframework.zip) — *2021 11 09*

- `CALayerCornerCurve` can now be passed to `roundCorners` method in `UIView`
- `displayCornerRadius` property has been added to `UIScreen`

#### [1.3.0(7)](https://github.com/VakhoKontridze/VCore/releases/download/1.3.0/VCore.xcframework.zip) — *2021 11 09*

- `withTabBarItem` method has been added to `UIViewController`

#### [1.2.0(6)](https://github.com/VakhoKontridze/VCore/releases/download/1.2.0/VCore.xcframework.zip) — *2021 11 08*

- Framework now contains additional files under `Extra`
- `LocalizationService` has been added to `Extra`
- XCode Templates have been added to `Extra`
- Custom `EdgeInset` objects have been added
- Generic `GenericStateModel` objects have been added
- `UILabel`'s `singleLineNaturalHeightConstant` has been renamed to `singleLineHeight`
- `UITableView`'s `removeExtraSeparators` and `removeExtraAndLastSeparators` have been deprecated, as they have no effect
- `UIScreen.rootView` has been deprecated in favor of `UIApplication.AppRootWindow` file under `Extra`
- `UIScreen.safeAreaInsets` has been deprecated
- `StandardNavigatable` has been renamed to `StandardNavigable`
- Various extensions have been added

#### [1.1.0(5)](https://github.com/VakhoKontridze/VCore/releases/download/1.1.0/VCore.xcframework.zip) — *2021 10 30*

- `NetworkService` now supports initialization and post-processing delegation
- `NetworkService.shared` has been deprecated
- `NetworkService`, `JSONEncoderService`, and `JSONDecoderService` now return `Error` instead of subsequent error types
- `NetworkSessionManager` has been renamed to `SessionManager`

#### [1.0.3(4)](https://github.com/VakhoKontridze/VCore/releases/download/1.0.3/VCore.xcframework.zip) — *2021 10 25*

- `uiAlertController` in `ViewModel` can now be accessed to create an `UIAlertController`

#### [1.0.2(3)](https://github.com/VakhoKontridze/VCore/releases/download/1.0.2/VCore.xcframework.zip) — *2021 10 08*

- `UICollectionViewDataSourceable` and `UITableViewDataSourceable` API has been updated

#### [1.0.1(2)](https://github.com/VakhoKontridze/VCore/releases/download/1.0.1/VCore.xcframework.zip) — *2021 10 07*

- Result enums are now marked as `@frozen`

#### [1.0.0(1)](https://github.com/VakhoKontridze/VCore/releases/download/1.0.0/VCore.xcframework.zip) — *2021 10 07*

- Initial release
