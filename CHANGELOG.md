## Change Log

#### [1.2.0(6)]

- Framework now contains additional files under `Extra`
- `LocalizationService` has been added to `Extra`
- XCode Templates have been added to `Extra`
- `UILabel`'s `singleLineNaturalHeightConstant` has been renamed to `singleLineHeight`
- `UITableView`'s `removeExtraSeparators` and `removeExtraAndLastSeparators` have been deprecated, as they have no effect
- `UIScreen.rootView` has been deprecated in favor of `UIApplication.AppRootWindow` file under `Extra`
- `UIScreen.safeAreaInsets` has been deprecated

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
