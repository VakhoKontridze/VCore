# Change Log

### [4.8.0(75)](https://github.com/VakhoKontridze/VCore/releases/tag/4.8.0) — *2023 04 13*

General

- Package now compiles on Mac Catalyst

Models

- `EdgeInsets_LeadingTrailingTopBottom` can now be initialized with `EdgeInsets` and `UIEdgeInsets`

Extensions

- `View.onSimultaneousTapGesture(count:perform:)` method is added

### [4.7.0(74)](https://github.com/VakhoKontridze/VCore/releases/tag/4.7.0) — *2023 04 09*

Services and managers

- `PresentationHost` is brought from [VComponents](https://github.com/VakhoKontridze/VComponents)

Views

- `SwiftUIBaseButton` is renamed to `SwiftUIGestureBaseButton`
- `SwiftUIGestureBaseButton` now supports `macOS`
- Completely new, `Button`-backed `SwiftUIBaseButton` is added
- `FetchDelegatingAsyncImage` is added that allows you to write custom fetch function
- `PlainDisclosureGroup` now supports `macOS`
- `possible` is added to `GestureBaseButtonGestureState`, and some `case`s are renamed
- `HOrVStack` is renamed to `HVStack`

Models

- `GenericStateAndModel_DeselectedSelectedPressedDisabled` and it's sub-groups are added
- `KeychainStorage` now behaves similar to native `AppStore`, in that it doesn't persist a value unless read to. Thus, reducing data corruption from key reuse in two different instances.
- `RectCorner` is added as a multi-platform alternative to `UIRectCorner`
- `KeychainStorage` property wrapper no longer requires enclosing `class` to conform to `ObservableObject`
- `projectedValue` is added to `Clamped` property wrapper
- `projectedValue` is added to `OldValueCache` property wrapper
- `reversed()` method is added to layout directions that returns reversed dimension
- `alignment` and `edge` are added to layout directions
- `axis` is added to `LayoutDirectionOmni`
- `withReversedLeftAndRightCorners(_:)` method is added to `RectCorner` that reversed left and right corners if condition is met

Extensions

- `Image.init(data:)` initializer is added
- `View.shadow(parameters:)` method is added
- `CGPoint.withReversedCoordinates(_:)` method is added
- `View.cornerRadius(_,corners:)` method is added for `RectCorner` model
- `View.modifier(_:)` method is added that applies a block modifier to a `View`
- `View.readSize(onChange:)` is renamed to `View.onSizeChange(perform:)`

Other

- Demo app is removed as it served no purpose
- `UILabel.lineBreakStrategy` is now placed under `tvOS` `14` API availability check

### [4.6.1(73)](https://github.com/VakhoKontridze/VCore/releases/tag/4.6.1) — *2023 03 09*

Other

- Platform-specific compilation errors are fixed

### [4.6.0(72)](https://github.com/VakhoKontridze/VCore/releases/tag/4.6.0) — *2023 03 09*

Views

- `HOrVstack` is added that toggles between `HStack` and `VStack`

Models

- `OldValueCache` property wrapper is added that stores value and caches old value
- `Clamped` property wrapper now conforms to `DynamicProperty`
- `stackView(alignmentHor:alignmentVer:spacing:content)` method is added to `LayoutDirectionOmni`
- `TextLineType` and `TextLineLimitType` are now exposed to APIs below `iOS` `16.0`, `macOS` `13.0`, `tvOS` `16.0`, `watchOS` `9.0`

Extensions

- `View.blocksHitTesting(_:)` method is added, that overlays `Rectangle`, blocking interactions
- `UIApplication.firstWindow(activationStates:where)` method is added that returns first `UIWindow` that satisfies the predicate
- `UIApplication.rootWindow`, `UIApplication.rootViewController`, and `UIApplication.rootView` are deprecated in favor of `UIApplication.firstWindowInSingleSceneApp`
- `UIApplication.activeWindow`, `UIApplication.activeViewController`, and `UIApplication.activeView` are deprecated in favor of `UIApplication.keyActiveWindowInSingleSceneApp`
- `UIApplication.keyWindowInSingleSceneApp` is added
- `UIApplication.topMostViewController` and `UIApplication.topMostView` are deprecated in favor of `UIApplication.topMostViewController(inWindow:)`

### [4.5.0(71)](https://github.com/VakhoKontridze/VCore/releases/tag/4.5.0) — *2023 03 03*

Views

- `AlignedGridView` is added, that horizontally justifies elements
- Another initializer it added to `ViewResettingContainer` that passes `ViewResetter` to content closure

Models

- `Clamped` property wrapper is added that clamps a number to a range
- `LayoutDirectionOmni`, `LayoutDirectionHorizontal`, and `LayoutDirectionVertical` are added

Extensions

- `Collection.allMatch(_:)` method is added that matches pairs with predicate
- `CGSize.withReversedDimensions()` and `CGSize.withReversedDimensions(if:)` methods are added
- `Array.reversed(if:)` method is added that reverses elements on a condition
- `Numeric.withOppositeSign()` and `Numeric.withOppositeSign(if:)` methods are added
- `Range.reversedArray(if:)` and `ClosedRange.reversedArray(if:)` methods are added returns `Array` with reversed elements on a condition
- `clamp` and `clamped` methods now support `BinaryInteger`
- Half-open range clamped methods have been restricted to `BinaryInteger`s

### [4.4.1(70)](https://github.com/VakhoKontridze/VCore/releases/tag/4.4.1) — *2023 02 10*

Services and Managers

- `LocalizationManager` will stop giving warnings about "Base" localization

### [4.4.0(69)](https://github.com/VakhoKontridze/VCore/releases/tag/4.4.0) — *2023 02 08*

Services and Managers

- `LocalizationService` is removed from `Extra`, and added to Package as `LocalizationManager`
- `MultiPartFormDataBuilder` is renamed to `MultipartFormDataBuilder` 

Views

- `ViewResettingContainer` is added that allows for view reset on demand

Models

- `ObservableContainer` now has an `open` access level

Extensions

- `String.localized(tableName:bundle:value:comment)` method is added
- `Locale.displayName(forKey:)` method is added
- `Locale.isEquivalent(to:)` method is added
- `Optional` comparison methods are added
- `UIImage.compressed(quality:)` is renamed to `UIImage.jpegCompressed(quality:)`
- `Array.compactMapNonEmpty(_:)` and `Array.compactMapNonNilNonEmpty(_:)` are removed due to ambiguous API

Global Functions

- `VCoreLogWarning(_:file:line:function)` method is added
- `VCoreLog(_:file:line:function)` is renamed to `VCoreLogError(_:file:line:function)`

API

- `VCoreLocalizationService` is renamed to `VCoreLocalizationManager`

Documentation

- Swift style guide is added

Other

- Platform-specific compilation errors are fixed

### [4.3.0(68)](https://github.com/VakhoKontridze/VCore/releases/tag/4.3.0) — *2022 12 28*

Services and Managers

- `MultiPartFormDataBuilder` API is updated, and boundary can be changed
- `KeychainServiceConfiguration` is added to allow modification of queries in `KeychainService`
- `class` subscripts in `KeychainService` are replaced with instance ones
- Methods in `JSONEncoderService`, `JSONDecoderService`, and `NetworkClient` now take `JSONSerialization.ReadingOptions` and `JSONSerialization.WritingOptions` as parameters

Models

- `setValue(to:)` is added to `AtomicContainer`

Extensions

- `Array.firstInstanceOfType(_:)` method is added
- `Array.lastInstanceOfType(_:)` method is added
- `Calendar` parameters is added to `Date.age`
- `Calendar` parameters is added to `Date.component(_:)`
- `Calendar` parameters is added to `Date.components(_:)`
- `View.onFirstAppear(didAppear:perform)` is renamed to `View.onFirstAppear(_:perform)`
- `View.standardNavigationTitle(_:)` is renamed to `View.inlineNavigationTitle(_:)` 

### [4.2.1(67)](https://github.com/VakhoKontridze/VCore/releases/tag/4.2.1) — *2022 12 15*

General

- `UILabel.lineBreakStrategy` is now placed under `iOS` `14` API availability check

### [4.2.0(66)](https://github.com/VakhoKontridze/VCore/releases/tag/4.2.0) — *2022 10 29*

General

- `macOS` `13.0` API is now exposed to `macOS`

### [4.1.0(65)](https://github.com/VakhoKontridze/VCore/releases/tag/4.1.0) — *2022 10 02*

Views

- `SecurableTextField` now takes `Text` as placeholder
- `ProgressViewParameters` now causes `View` to ignore interaction, instead of disabling it

Models

- Underlying type `_textLineType` in TextLineType is no longer `public`. Instead, it's being replaced by `textAlignment` and `textLineLimitType`.

Helpers - Architectural Pattern Helpers

- `isInteractionDisabled` no longer has a default value in `ProgressViewParameters`

### [4.0.1(64)](https://github.com/VakhoKontridze/VCore/releases/tag/4.0.1) — *2022 09 15*

Services and Managers

- Issue with `Data` being empty in `NetworkResponseProcessor.response(_:_:)` when calling `noData(from:)` in `NetworkClient` is fixed

### [4.0.0(63)](https://github.com/VakhoKontridze/VCore/releases/tag/4.0.0) — *2022 09 14*

General

- `Error`s are now `struct`s, backed by `ErrorCode` enumerations
- `VCoreLog(_:)` is added that logs errors throws by objects, such as `NetworkClient`, `KeychainService`, `JSONEncoderService`, and `JSONDecoderService`

Services and Managers

- `status` is added to `NetworkReachabilityService`
- `KeychainService` API is changed from `Result` types to throwing methods
- `SessionManager` is now an `actor`
- `error(_:)` is removed from `NetworkErrorProcessor`
- `JSONEncoderService` and `JSONDecoderService` now have instance-based APIs

Views

- `CapsuleUIView` and `CapsuleUIImageView` will now round corners based on width, if width is less than height

Models

- `ObservableContainer` is added
- `AtomicContainer` is added
- `AtomicInteger` is now an `actor`
- `AtomicInteger` now contains many methods for incrementation and decrementation
- `TextLineType` and `TextLineLimitType` are added
- `horizontalAverage` and `verticalAverage` are added to `EdgeInset`s
- `horizontal` is renamed to `horizontalSum` in `EdgeInsets_LeadingTrailingTopBottom`
- `vertical` is renamed to `verticalSum` in `EdgeInsets_LeadingTrailingTopBottom`

Helpers - Architectural Pattern Helpers

- `CoordinatingNavigationStack` is added for `SwiftUI`
- `AlertPresentable` is added for `SwiftUI`
- `ConfirmationDialogPresentable` is added for `SwiftUI`
- `ProgressViewPresentable` is added for `SwiftUI`
- `SwiftUI` `VIPER` documentation and demo is added
- `UITableViewDequeueable` is renamed to `ConfigurableUITableViewCell`
- `ConfigurableUITableViewCell.dequeueID` is renamed to `ConfigurableUITableViewCell.reuseID`
- `UICollectionViewDequeueable` is renamed to `ConfigurableUICollectionViewCell`
- `ConfigurableUICollectionViewCell.dequeueID` is renamed to `ConfigurableUICollectionViewCell.reuseID`

Extensions

- `NavigationPath.append(contentsOf:)` method is added
- `NavigationPath.removeAll()` method is added
- `SwiftUIFirstAppearLifecycleManager` is removed
- `CALayerCornerCurve` parameter is added to `UIView.roundCornersAndApplyShadow(cornerRadius:color:radius:offset)`
- `View.fitToAspect(_:contentMode)` method is added
- `View.shadow(color:radius:offset)` method is added

API

- `keychainServiceErrorDescription(_:)` is added to `VCoreLocalizationProvider`

Extra - XCode Templates

- Project now includes templates for `SwiftUI`

### [3.20.2(62)](https://github.com/VakhoKontridze/VCore/releases/tag/3.20.2) — *2022 09 05*

Extensions

- Issue with `UIApplication.rootWindow` returning `nil` on app launch is fixed

### [3.20.1(61)](https://github.com/VakhoKontridze/VCore/releases/tag/3.20.1) — *2022 08 24*

Services and Managers

- `NetworkReachabilityService` not detecting network changes in some cases is fixed

### [3.20.0(60)](https://github.com/VakhoKontridze/VCore/releases/tag/3.20.0) — *2022 08 18*

Views

- `CarouselCollectionViewFlowLayout` is added

### [3.19.1(59)](https://github.com/VakhoKontridze/VCore/releases/tag/3.19.1) — *2022 08 11*

Extensions

- `UIDevice.hasNotch` is renamed to `UIDevice.hasNoPhysicalHomeButton`
- `View.onFirstAppear(perform:)` is renamed to `View.onFirstAppear(didAppear:perform)`

### [3.19.0(58)](https://github.com/VakhoKontridze/VCore/releases/tag/3.19.0) — *2022 08 05*

Models

- `BasicAnimation.toCAMediaTimingFunction` is added
- `BasicAnimation.toUIViewAnimationOptions` is added

Helpers - Architectural Pattern Helpers

- `UIActionSheetViewable` is added

Extensions

- `Array.firstIndexAndElement(where:)` is expanded to `Collection`
- `UIView.removeSubviews()` is renamed to `UIView.removeSubviewsFromSuperview()`

### [3.18.4(57)](https://github.com/VakhoKontridze/VCore/releases/tag/3.18.4) — *2022 07 25*

Views

- Retain cycle caused by `KeyboardResponsiveViewController` is fixed

Models

- Issues with `KeychainStorage` are fixed

### [3.18.3(56)](https://github.com/VakhoKontridze/VCore/releases/tag/3.18.3) — *2022 07 26*

Models

- Issue with `clearUIColors` and `clearNSColors` initializers in `GenericStateModel_EnabledPressedDisabled` is fixed

### [3.18.2(55)](https://github.com/VakhoKontridze/VCore/releases/tag/3.18.2) — *2022 07 26*

Architectural Pattern Helpers

- Missing `public` modifier is added to extension method of `pop(count: Int, animated: Bool)` in `StandardNavigable`

### [3.18.1(54)](https://github.com/VakhoKontridze/VCore/releases/tag/3.18.1) — *2022 07 26*

Views

- `CapsuleImageView` is renamed to `CapsuleUIImageView`

Architectural Pattern Helpers

- Missing `public` modifier is added to default implementation of `pop(count: Int, animated: Bool)` method in `StandardNavigable`

### [3.18.0(53)](https://github.com/VakhoKontridze/VCore/releases/tag/3.18.0) — *2022 07 26*

Views

- `CapsuleUIView` is added
- `CapsuleUIImageView` is added

Services and Managers - Network Client

- `NetworkError` is renamed to `NetworkClientError`

Helpers - Architectural Pattern Helpers

- `func pop(count: Int, animated: Bool)` is added to `StandardNavigable`

Extensions

- `UIStackView.removeArrangedSubviewsFromSuperview()` is added

### [3.17.0(52)](https://github.com/VakhoKontridze/VCore/releases/tag/3.17.0) — *2022 07 23*

Services and Managers

- `KeychainService` is added

Models

- `KeychainStorage` `PropertyWrapper` is added

Architectural Pattern Helpers

- `UIAlertParameters` now builds actions using `resultBuilder`

### [3.16.2(51)](https://github.com/VakhoKontridze/VCore/releases/tag/3.16.2) — *2022 07 21*

Views

- `keyboardResponsivenessContainerView` property is added in `KeyboardResponsiveUIViewControllerOffsettingContainerByObscuredSubviewHeight`
- Issue with `KeyboardResponsiveUIViewController` offset-based animation, not considering pre-offsetted container is fixed

### [3.16.1(50)](https://github.com/VakhoKontridze/VCore/releases/tag/3.16.1) — *2022 07 19*

Views

- Issues with `KeyboardResponsiveUIViewController` animations are fixed

Models

- `Double.convertDecimalBytes(to:)` is renamed to `Double.decimalBytesConverted(to:)`
- `Double.convertBinaryBytes(to:)` is renamed to `Double.binaryBytesConverted(to:)`

### [3.16.0(49)](https://github.com/VakhoKontridze/VCore/releases/tag/3.16.0) — *2022 07 15*

Views

- `KeyboardResponsiveUIViewControllerOffsettingContainerByObscuredSubviewHeight` is added that handles keyboard notifications and calls `UIView.animateKeyboardResponsivenessByOffsettingContainerByObscuredSubviewHeight`

Models

- `DataUnit` `protocol` is added, alongside with `DecimalDataUnit` and `BinaryDataUnit`

Helpers

- `KeyPath`-based `UILayoutGuideType` `case` is replaced with closure-based one

Extensions

- `UIImage.sizeInKilobytes`, `UIImage.sizeInMegabytes`, `UIImage.sizeInKibibytes`, and `UIImage.sizeInMebibytes` properties are added

Other

- Platform-specific compilation errors are fixed

### [3.15.2(48)](https://github.com/VakhoKontridze/VCore/releases/tag/3.15.2) — *2022 07 14*

Helpers

- Missing methods are added to `UIView` helper `NSLayoutConstraint` methods

### [3.15.1(47)](https://github.com/VakhoKontridze/VCore/releases/tag/3.15.1) — *2022 07 13*

Other

- Compilation errors are fixed

### [3.15.0(46)](https://github.com/VakhoKontridze/VCore/releases/tag/3.15.0) — *2022 07 13*

Views

- `InnerShadowUIView` is added
- `InteractivePoppingUINavigationController` is added
- `nonZeroAnimationDuration` is added to `SystemKeyboardInfo`
- `UIView.childFirstResponder` and `UIView.childFirstResponderView` properties are added
- Default `static` properties are exposed to public in `SystemKeyboardInfo`
- `LeftAlignedCollectionViewFlowLayout` is renamed to `LeftAlignedUICollectionViewFlowLayout`
- `CenterAlignedCollectionViewFlowLayout` is renamed to `CenterAlignedUICollectionViewFlowLayout`
- `RightAlignedCollectionViewFlowLayout` is renamed to `RightAlignedUICollectionViewFlowLayout`
- `KeyboardResponsiveViewController` is renamed to `KeyboardResponsiveUIViewController`
- `InfiniteScrollingTableView` is renamed to `InfiniteScrollingUITableView`
- `InfiniteScrollingCollectionView` is renamed to `InfiniteScrollingUICollectionView`
- `ScrollableView` is renamed to `ScrollableUIView`

Helpers

- `UIView` helper `NSLayoutConstraint` API has been updated

Extensions

- `Double.rounded(fractions:)` and `Double.round(fractions:)` methods are added
- `String.diacriticInsensitiveString(locale:)` method is added
- `UIViewController.isRootViewController` and `UIViewController.isNonRootViewController` properties are added
- `NSLayoutConstraint.init(item:attribute:relatedBy:toItem:attribute:multiplier:constant:priority)` initializer is added

### [3.14.0(45)](https://github.com/VakhoKontridze/VCore/releases/tag/3.14.0) — *2022 07 12*

Views

- `UIView` animation methods are added that support `KeyboardResponsiveViewController`
- `KeyboardResponsiveViewController.notifiesWhenKeyboardIsAlreadyShownOrHidden` is added
- `KeyboardResponsiveViewController.notifiesWhenViewControllerIsNotVisible` is added
- `KeyboardResponsiveViewController.keyboardIsShown` is exposed to public

Extensions

- `NSAttributedString.init(attributedStrings:)` initializer is added

### [3.13.2(44)](https://github.com/VakhoKontridze/VCore/releases/tag/3.13.2) — *2022 07 12*

Extra - XCode Templates

- `UIColor`s in `UIKit` XCode templates are no longer optional

### [3.13.1(43)](https://github.com/VakhoKontridze/VCore/releases/tag/3.13.1) — *2022 07 11*

Extra - XCode Templates

- Routers in `UIKit` XCode templates are fixed

### [3.13.0(42)](https://github.com/VakhoKontridze/VCore/releases/tag/3.13.0) — *2022 07 09*

Views

- Several members in `SwiftUIBaseButtonState` and `UIKitBaseButtonState` are now marked as `public`

Extensions

- `UIView.addSubviews(:_)` and `UIView.removeSubviews()` methods are added
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

Views

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

Extra - XCode Templates

- Missing Package import is added to `async` Gateway XCode template

### [3.9.1(33)](https://github.com/VakhoKontridze/VCore/releases/tag/3.9.1) — *2022 06 29*

Extra - Localization Service

- `LocalizationService` now reads locales directly from the `Bundle`
- `LocalizationService` no longer causes issues with default localization outside of non-English regions

### [3.9.0(32)](https://github.com/VakhoKontridze/VCore/releases/tag/3.9.0) — *2022 06 27*

Extensions

- `View.safeAreaMarginInsets(edges:)` method is added

### [3.8.1(31)](https://github.com/VakhoKontridze/VCore/releases/tag/3.8.1) — *2022 06 25*

Documentation

- Remove duplicate CLEAN Gateway documentation

### [3.8.0(30)](https://github.com/VakhoKontridze/VCore/releases/tag/3.8.0) — *2022 06 25*

Views

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

Extra - XCode Templates

- `async` Gateway now contains a mock object for previews in `SwiftUI`

### [3.6.0(28)](https://github.com/VakhoKontridze/VCore/releases/tag/3.6.0) — *2022 06 17*

Views

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

Extra - XCode Templates

- Background colors of `UIKit` views are now set to `UIColor.systemBackground`
- Issue with method signature in completion-based Gateway is fixed

Other

- Missing demo app `.xcodeproj` file is now tracked

### [3.5.1(27)](https://github.com/VakhoKontridze/VCore/releases/tag/3.5.1) — *2022 06 15*

Helpers - Architectural Pattern Helpers

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

Extra - XCode Templates

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

Views

- `SwiftUIBaseButton` API is updated and old `init`s are deprecated

Extensions

- `Sequence.count(where:)` method is added

### [3.1.1(21)](https://github.com/VakhoKontridze/VCore/releases/tag/3.1.1) — *2022 05 21*

Services and Managers

- Issue with `AnyMultiPartFormDataFile` rename warning is fixed

### [3.1.0(20)](https://github.com/VakhoKontridze/VCore/releases/tag/3.1.0) — *2022 05 20*

Services and Managers

- `AnyMultiPartFormFile` is renamed to `AnyMultiPartFormDataFile`

Views

- Issue with accessing `SwiftUIBaseButton` in `SwiftUI` is fixed

Extensions

- `View.bindToModalContext(_:)` method is added
- `OptionSet.elements` property is added
- Issue with accessing `cornerRadius` method in `SwiftUI` is fixed

### [3.0.2(19)](https://github.com/VakhoKontridze/VCore/releases/tag/3.0.2) — *2022 05 17*

Views

- Public initializers are added to `SystemKeyboardInfo`

### [3.0.1(18)](https://github.com/VakhoKontridze/VCore/releases/tag/3.0.1) — *2022 05 17*

General

- Missing `public` access modifiers are added

### [3.0.0(17)](https://github.com/VakhoKontridze/VCore/releases/tag/3.0.0) — *2022 05 17*

General

- Project is migrated from `XCFramework` to `Swift` Package
- Project now partially supports `macOS`, `tvOS`, and `watchOS`
- Project is now covered under unit tests

Services and Managers

- `MultiPartFormDataBuilder` no longer throws errors

Services and Managers - Network Client

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

- `VCoreLocalizationService` is added, that supports localization within the Package

Extra - Localization Service

- `LocalizationService` now supports language switching from the system settings

### [2.3.0(16)](https://github.com/VakhoKontridze/VCore/releases/tag/2.3.0) — *2022 02 25*

Views

- `ScrollableView` is added

Helpers - Architectural Pattern Helpers

- `animated` and `completion` parameters are added to methods in `StandardNavigable`

Extensions

- `Optional.let(_:)` method is deprecated in favor of native `Optional.map(_:)` and `Optional.flatMap(_:)`

### [2.2.1(15)](https://github.com/VakhoKontridze/VCore/releases/tag/2.2.1) — *2022 02 14*

Views

- State logic in `UIKitBaseButton` documentation is updated

Helpers - Architectural Pattern Helpers

- Typo in `UIActivityIndicatorViewable` methods are fixed

Extra - XCode Templates

- `UITableViewCell` and `UICollectionViewCell` background colors are now set directly to cell, and not to `contentView`
- `with` argument label is added to `Gateway.fetch(_:completion:)`

### [2.2.0(14)](https://github.com/VakhoKontridze/VCore/releases/tag/2.2.0) — *2022 01 07*

Extensions

- Issues with `FloatingPoint.fixedInRange(_:step:)` methods are fixed
- Issues with conditional `View` function `if` are fixed
- `minimumScaleFactor` parameter is added to `UILabel` configuration method and initializer
- `FloatingPoint.fixedInRange(_:step:)` function is renamed to `bound` 

Extra - XCode Templates

- `UIView` (Dynamic Model) templates now have a default parameter value for model in initializers

### [2.1.1(13)](https://github.com/VakhoKontridze/VCore/releases/tag/2.1.1) — *2022 01 04*

Views

- `isEnabled` is added to `UIKitBaseButton` to replace `isUserInteractionEnabled`

### [2.1.0(12)](https://github.com/VakhoKontridze/VCore/releases/tag/2.1.0) — *2022 01 01*

Services and Managers - Network Client

- `NetworkProcessor` is renamed to `NetworkResponseProcessor`

Helpers - Architectural Pattern Helpers

- `UITableViewDataSourceable.tableViewCellDequeueID(section:row:)` method is deprecated
- `UICollectionViewDataSourceable.collectionViewCellDequeueID(section:row:)` method is deprecated
- `dequeueID` parameter in `dequeueAndConfigureReusableCell(parameter:)` and `dequeueAndConfigureReusableCell(indexPath:parameter:)` methods are deprecated

Extensions

- `KeyPath` sort method `Sequence.sort(by:)` is added
- Conditional and `KeyPath` grouping methods `Sequence.grouped(by:)` are added

Extra - XCode Templates

- `UIViewController` `Factory` is fixed
- `with` parameter labels are removed from configuration methods

### [2.0.2(11)](https://github.com/VakhoKontridze/VCore/releases/tag/2.0.2) — *2021 12 29*

Extra - XCode Templates

- Issues with `UITableViewCellDataSourceable` methods are fixed

### [2.0.1(10)](https://github.com/VakhoKontridze/VCore/releases/tag/2.0.1) — *2021 12 29*

Extra - XCode Templates

- `UITableViewCell` initializer is fixed

### [2.0.0(9)](https://github.com/VakhoKontridze/VCore/releases/tag/2.0.0) — *2021 12 28*

General

- Framework now supports `iOS` `13.0`

Services and Managers

- `MultiPartFormDataBuilder` is added

Services and Managers - Network Client

- `NetworkService` is renamed to `NetworkClient`
- `NetworkClient` now supports async/await
- `NetworkServicePostProcessor` is renamed to `NetworkProcessor`
- Several cases are added to `NetworkError`
- `NetworkError.incompleteEntity` is renamed to `NetworkError.invalidData`

Views

- `UIKitBaseButton` and `SwiftUIBaseButton` are added
- `KeyboardResponsiveViewController` are added
- `InfiniteScrollingCollectionView` are added

Helpers

- `EdgeInsets` objects now support insetting and addition/subtraction
- `VCoreErrorInfo` is removed

Helpers - Architectural Pattern Helpers

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

Helpers - Architectural Pattern Helpers

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

Services and Managers - Network Service

- `NetworkService` now supports initialization and post-processing delegation
- `NetworkService.shared` is deprecated
- `NetworkService`, `JSONEncoderService`, and `JSONDecoderService` now return `Error` instead of subsequent error types
- `NetworkSessionManager` is renamed to `SessionManager`

### [1.0.3(4)](https://github.com/VakhoKontridze/VCore/releases/tag/1.0.3) — *2021 10 25*

Helpers - Architectural Pattern Helpers

- `ViewModel.uiAlertController` property can now be accessed to create an `UIAlertController`

### [1.0.2(3)](https://github.com/VakhoKontridze/VCore/releases/tag/1.0.2) — *2021 10 08*

Helpers - Architectural Pattern Helpers

- `UICollectionViewDataSourceable` and `UITableViewDataSourceable` APIs are updated

### [1.0.1(2)](https://github.com/VakhoKontridze/VCore/releases/tag/1.0.1) — *2021 10 07*

Models - Custom Results

- `Result` enums are now marked as `@frozen`

### [1.0.0(1)](https://github.com/VakhoKontridze/VCore/releases/tag/1.0.0) — *2021 10 07*

Initial release
