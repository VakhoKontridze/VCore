# VCore

## Table of Contents

- [Description](#description)
- [Structure](#structure)
- [Showcase](#showcase)
- [Installation](#installation)
- [Compatibility](#compatibility)
- [Contact](#contact)

## Description

VCore is a Swift collection containing objects, functions, and extensions that I use for my projects.

## Structure

Package files are grouped as:

- ***Services and Managers***. Services, managers, controllers, and formatters. For instance, `MultiPartFormDataBuilder`.

- ***Views***. Reusable non-scene `View`s, `UIView`s, and `UIViewController`s. For instance `BaseButton`s.

- ***Models***. Reusable models. For instance, `GenericState`s and `GenericStateModel`s.

- ***Helpers***. Non-service, non-extension objects and methods. For instance, architectural pattern helpers.

- ***Extensions***. Global extensions.

- ***Global Functions***. Global functions. For instance, `FIXME` and `TODO`.

- ***Macros***. Macros. For instance, `URL(_:)`.

- ***API***. Objects used for interfacing from you app/package to `VCore`. For instance, `VCoreLocalizationManager`.

Package incudes folder `Extra`, which contains:

- ***XCode Templates***. Templates that can be used for accelerating workflow. Currently, templates cover scenes and gateways. For additional info, refer to documentation folder.

Project includes folder `Documentation`, which contains:

- Swift style guide

- Documentation and example apps of various SwiftUI/UIKit architectures

- Documentation of CLEAN networking

## Showcase

#### Multipart/Form-Data Builder

`MultipartFormDataBuilder` with a `Dictionary`-based file API:

```swift
let json: [String: Any?] = [
    "key": "value"
]

let files: [String: (some AnyMultipartFormDataFile)?] = [
    "profile": MultipartFormDataFile(
        mimeType: "image/jpeg",
        data: profileImage?.jpegData(compressionQuality: 0.25)
    ),

    "gallery": galleryImages?.enumerated().compactMap { (index, image) in
        MultipartFormDataFile(
            filename: "IMG_\(index).jpg",
            mimeType: "image/jpeg",
            data: image?.jpegData(compressionQuality: 0.25)
        )
    }
]

let (boundary, httpData): (String, Data) = try MultipartFormDataBuilder().build(
    json: json,
    files: files
)

let url: URL = #URL("https://somewebsite.com/api/some_endpoint")

var request: URLRequest = .init(url: url)
request.httpMethod = "POST"
try request.addHTTPHeaderFields(object: MultipartFormDataAuthorizedRequestHeaderFields(
    boundary: boundary,
    token: "token"
))
request.httpBody = httpData.nonEmpty

let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)

...
```

#### Localization Manager

`LocalizationManager` that manages localizations without interacting with raw `String`s:

```swift
extension Locale {
    static var english: Self { .init(identifier: "en") }
    static var english_uk: Self { .init(identifier: "en-GB") }
    static var spanish: Self { .init(identifier: "es") }
}

LocalizationManager.shared.addLocales([.english, .english_uk, .spanish])
LocalizationManager.shared.setDefaultLocale(to: .english)
```

```swift
LocalizationManager.shared.setCurrentLocale(to: .english)
```

```swift
let lhs: Locale = .init(identifier: "en")
let rhs: Locale = .init(identifier: "en-US")

lhs == rhs // false

lhs.isEquivalent(to: rhs) // true, if `Locale.current.regionCode` is "US"
```

#### Keychain Service

`KeychainService` that supports custom queries, and has a dedicated property wrapper:

```swift
KeychainService.default.get(key: "SomeKey")
KeychainService.default.set(key: "SomeKey", data: data)
KeychainService.default.delete(key: "SomeKey")
```

```swift
@KeychainStorage("AccessToken") var accessToken: String?
```

#### Various Services and Managers

`DigitalTimeFormatter` with various configurations:

```swift
let formatter: DigitalTimeFormatter = .init()
formatter.string(from: 905048) // "10:11:24:08"
```

#### Various SwiftUI Views

`AlignedGridLayout` that justifies collection of views with an alignment:

```swift
private let strings: [String] = [
    "Monday", "Tuesday", "Wednesday",
    "Thursday", "Friday", "Saturday",
    "Sunday"
]

var body: some View {
    AlignedGridLayout(alignment: .center, spacing: 5).callAsFunction({
        ForEach(strings, id: \.self, content: { string in
            Text(string)
                .background(content: { Color.accentColor.opacity(0.5) })
        })
    })
    .padding()
}
```

#### Various UIKit Views/ViewControllers

`KeyboardResponsiveUIViewController` that handles keyboard notifications:

```swift
final class ViewController: KeyboardResponsiveUIViewController {
    private let textField: UITextField = { ... }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addsupview(textField)

        NSLayoutConstraint.activate([
            ...
        ])
    }

    override func keyboardWillShow(_ systemKeyboardInfo: SystemKeyboardInfo) {
        super.keyboardWillShow(systemKeyboardInfo)

        UIView.animateKeyboardResponsiveness(
            systemKeyboardInfo: systemKeyboardInfo,
            animations: { [weak self] in
                guard let self else { return }
                
                guard let systemKeyboardHeight: CGFloat = systemKeyboardInfo.frame?.size.height else { return }

                view.bounds.origin.y = systemKeyboardHeight
                view.superview?.layoutIfNeeded()
            }
        )
    }

    override func keyboardWillHide(_ systemKeyboardInfo: SystemKeyboardInfo) {
        super.keyboardWillHide(systemKeyboardInfo)

        UIView.animateKeyboardResponsiveness(
            systemKeyboardInfo: systemKeyboardInfo,
            animations: { [weak self] in
                guard let self else { return }

                view.bounds.origin.y = 0
                view.superview?.layoutIfNeeded()
            }
        )
    }
}
```

#### Various Declarations

`KeyPathInitializableEnumeration` that allows for initialization of an `enum` with a `KeyPath`:

```swift
enum SomeEnum: KeyPathInitializableEnumeration {
    case first
    case second

    var someProperty: Int {
        switch self {
        case .first: 1
        case .second: 2
        }
    }
}

let value: SomeEnum? = .aCase(key: \.someProperty, value: 2)
```

#### Various Extensions and Global Functions

`Optional` comparison:

```swift
let a: Int? = 10
let b: Int? = nil

a.isOptionalLess(than: b, order: .nilIsLess) // false
a.isOptionalLess(than: b, order: .nilIsGreater) // true
```

Detecting changes in `View` size:

```swift
@State private var size: CGSize = .zero

var body: some View {
    VStack(content: {
        Color.accentColor
            .onSizeChange(perform: { size = $0 })
    })
}
```

#### Various Macros

```swift
let url: URL = #URL("https://example.com")
```

## Installation

#### Swift Package Manager

Add `https://github.com/VakhoKontridze/VCore` as a Swift Package in Xcode and follow the instructions.

## Compatibility

#### Platform and Version Support

Package provides limited `macOS`, `tvOS`, and `watchOS` support.

Versions with different majors are not directly compatible. When a new major is released, deprecated symbols are removed.

#### Versioning

***Major***. Major changes, such as big overhauls

***Minor***. Minor changes, such as new objects, functions, and extensions

***Patch***. Bug fixes and improvements

#### History

<table>

  <tr>
    <th align="left">Version</th>
    <th align="left">Release Date</th> 
    <th align="left">Swift</th>
    <th align="left">SDK</th>
    <th align="left">Comment</th>
  </tr>
  
  <tr>
    <td>
        5.0<br><i><sup>(5.0.0 - 5.x.x)</sup></i>
    </td>
    <td>2023 10 08</td>
    <td>
        5.9
    </td>
    <td>
        iOS 15.0<br>
        macOS 12.0<br>
        tvOS 15.0<br>
        watchOS 8.0
    </td>
    <td>
        New SDK.<br>
        API changes.
    </td>
  </tr>
  
  <tr>
    <td>
        4.0<br><i><sup>(4.0.0 - 4.11.0)</sup></i>
    </td>
    <td>2022 09 14</td>
    <td>
        5.8<br><i><sup>(4.7.0 - 4.x.x)</sup></i><br>
        5.7<br><i><sup>(4.0.0 - 4.6.1)</sup></i>
    </td>
    <td>
        iOS 13.0<br>
        macOS 10.15<br>
        tvOS 13.0<br>
        watchOS 6.0
    </td>
    <td>API changes.</td>
  </tr>
  
  <tr>
    <td>
        3.0<br><i><sup>(3.0.0 - 3.20.2)</sup></i>
    </td>
    <td>2022 05 17</td>
    <td>5.6</td>
    <td>
        iOS 13.0<br>
        macOS 10.15<br>
        tvOS 13.0<br>
        watchOS 6.0
    </td>
    <td>
        Multiplatform support.<br>
        SPM support.
    </td>
  </tr>
  
  <tr>
    <td>
        2.0<br><i><sup>(2.0.0 - 2.3.0)</sup></i>
    </td>
    <td>2021 12 28</td>
    <td>5.3</td>
    <td>iOS 13.0</td>
    <td>iOS 13.0 support</td>
  </tr>
  
  <tr>
    <td>
        1.0<br><i><sup>(1.0.0 - 1.4.0)</sup></i>
    </td>
    <td>2021 10 07</td>
    <td>5.3</td>
    <td>iOS 14.0</td>
    <td>-</td>
  </tr>

</table>

For additional info, refer to the [CHANGELOG](https://github.com/VakhoKontridze/VCore/blob/main/CHANGELOG.md).

## Contact

e-mail: vakhtang.kontridze@gmail.com
