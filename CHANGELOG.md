## Change Log

#### [2.0.0(9)]

- Framework is no longer compatible with version `1.3.0`
- Framework now supports `iOS 13`
- `NetworkService` now supports async/await
- `EdgeInsets` objects now support insetting and addition/subtraction
- `requestTimeOut` has been added to `NetworkError`
- `VCoreErrorInfo` has been removed
- `NetworkServicePostProcessor` has been renamed to `NetworkServiceProcessor`
- `NetworkError.incompleteEntity` has been renamed to `NetworkError.incompleteData`
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
- `NetworkSessionManager` has been renamed to `SessionManager`
- `NetworkService.shared` has been deprecated
- `NetworkService`, `JSONEncoderService`, and `JSONDecoderService` now return `Error` instead of subsequent error types

#### [1.0.3(4)](https://github.com/VakhoKontridze/VCore/releases/download/1.0.3/VCore.xcframework.zip) — *2021 10 25*

- `uiAlertController` in `ViewModel` can now be accessed to create an `UIAlertController`

#### [1.0.2(3)](https://github.com/VakhoKontridze/VCore/releases/download/1.0.2/VCore.xcframework.zip) — *2021 10 08*

- `UICollectionViewDataSourceable` and `UITableViewDataSourceable` API has been updated

#### [1.0.1(2)](https://github.com/VakhoKontridze/VCore/releases/download/1.0.1/VCore.xcframework.zip) — *2021 10 07*

- Result enums are now marked as `@frozen`

#### [1.0.0(1)](https://github.com/VakhoKontridze/VCore/releases/download/1.0.0/VCore.xcframework.zip) — *2021 10 07*

- Initial release
