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

- ***Services and Managers***. Services, managers, controllers, and formatters. For instance, `NetworkClient`.

- ***Views***. Reusable non-scene `View`s, `UIView`s, and `UIViewController`s. For instance `BaseButton`s.

- ***Models***. Reusable models. For instance, `EdgeInsets`s.

- ***Helpers***. Non-service, non-extension objects and methods. For instance, architectural pattern helpers.

- ***Extensions***. Global extensions. Methods and properties are grouped by frameworks of origin—`Core Frameworks`, `Foundation`, `SwiftUI`, `UIKit`, and `AppKit` (only for supporting underlying `SwiftUI` types).

- ***Global Functions***. Global functions. For instance, `TODO`.

- ***API***. Objects used for interfacing from you app/package to `VCore`. For instance, `VCoreLocalizationManager`.

Package incudes folder `Extra`, which contains:

- ***XCode Templates***. Templates that can be used for accelerating workflow. Currently, templates cover scenes and gateways. For additional info, refer to documentation folder.

Project includes folder `Documentation`, which contains:

- Swift style guide

- Documentation and an example app of UIKit VIPER architecture

- Documentation and an example app of SwiftUI VIPER architecture

- Documentation of CLEAN Interactors and Gateways

## Showcase

#### Network Client

`NetworkClient` with customizable requests, responses, and return types:

```swift
do {
    var request: NetworkRequest = .init(url: "https://httpbin.org/post")
    request.method = .POST
    try request.addHeaders(encodable: JSONRequestHeaders())
    try request.addBody(json: ["key": "value"])

    let result: [String: Any?] = try await NetworkClient.default.json(from: request)

    print(result)

} catch {
    print(error.localizedDescription)
}
```

#### Multipart/Form-Data Builder

`MultipartFormDataBuilder` with a `Dictionary`-based file API:

```swift
do {
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

    let (boundary, data): (String, Data) = try MultipartFormDataBuilder().build(
        json: json,
        files: files
    )

    var request: NetworkRequest = .init(url: "https://somewebsite.com/api/some_endpoint")
    request.method = .POST
    try request.addHeaders(encodable: MultipartFormDataAuthorizedRequestHeaders(
        boundary: boundary,
        token: "token"
    ))
    request.addBody(data: data)

    let result: [String: Any?] = try await NetworkClient.default.json(from: request)

    print(result)

} catch {
    print(error.localizedDescription)
}
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

#### Keychain Service:

`KeychainService` that supports custom queries, and has a dedicated property wrapper:

```swift
KeychainService.default.get(key: "SomeKey")
KeychainService.default.set(key: "SomeKey", data: data)
KeychainService.default.delete(key: "SomeKey")
```

```swift
@KeychainStorage("AccessToken") var accessToken: String?
```

#### Various Helpful Declarations

`KeyPathInitializableEnumeration` that allows for initialization of an `enum` with a `KeyPath`:

```swift
enum SomeEnum: KeyPathInitializableEnumeration {
    case first
    case second

    var someProperty: Int {
        switch self {
        case .first: return 1
        case .second: return 2
        }
    }
}

let value: SomeEnum? = .aCase(key: \.someProperty, value: 2)
```

`DigitalTimeFormatter` with various configurations:

```swift
let formatter: DigitalTimeFormatter = .init()
formatter.string(from: 905048) // "10:11:24:08"
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

                view.bounds.origin.y = -systemKeyboardInfo.frame.size.height
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

#### Various SwiftUI Views

`FetchDelegatingAsyncImage` that asynchronously loads and displays an `Image` with a delegated fetch handler.
You can customize request with access token and headers, implement custom caching, and more.

```swift
var body: some View {
    FetchDelegatingAsyncImage(
        from: URL(string: "https://somewebsite.com/content/image.jpg")!,
        fetch: fetchImage,
        content: { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .fitToAspect(1, contentMode: .fill)

            } else if phase.error != nil {
                ErrorView()

            } else {
                ProgressView()
            }
        }
    )
    .frame(dimension: 200)
}

...

private var cache: NSCache<NSString, UIImage> = .init()

private func fetchImage(url: URL) async throws -> Image {
    let key: NSString = .init(string: url.absoluteString)

    switch cache.object(forKey: key) {
    case nil:
        var request: NetworkRequest = .init(url: url)
        try request.addHeaders(encodable: JSONAuthorizedRequestHeaders(token: "token"))

        let data: Data = try await NetworkClient.default.data(from: request)
        guard let uiImage: UIImage = .init(data: data) else { throw NetworkClientError.invalidData }

        cache.setObject(uiImage, forKey: key)

        return Image(uiImage: uiImage)

    case let uiImage?:
        return Image(uiImage: uiImage)
    }
}
```

#### Various Extensions and Global Functions

`Optional` Comparison:

```swift
let a: Int? = 10
let b: Int? = nil

a.isOptionalLess(than: b, order: .nilIsLess) // false
a.isOptionalLess(than: b, order: .nilIsGreater) // true
```

Detecting changes in `View` Size:

```swift
@State private var size: CGSize = .zero

var body: some View {
    VStack(content: {
        Color.accentColor
            .onSizeChange(perform: { size = $0 })
    })
}
```

Conditional `ViewModifier`s:

```swift
private let isRed: Bool = true

var body: some View {
    Text("Lorem Ipsum")
        .if(isRed, transform: { $0.foregroundColor(.red) })
}
```

## Installation

#### Swift Package Manager

Add `https://github.com/VakhoKontridze/VCore` as a Swift Package in Xcode and follow the instructions.

## Compatibility

Package provides limited `macOS`, `tvOS`, and `watchOS` support.

Versions with different majors are not directly compatible. When a new major is released, deprecated symbols are removed.

#### Versioning

***Major***. Major changes, such as big overhauls

***Minor***. Minor changes, such as new objects, function, and extensions

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
        4.0<br/><i><sup>(4.0.0 - 4.x.x)</sup></i>
    </td>
    <td>2022 09 14</td>
    <td>
        5.8<br/><i><sup>(4.7.0 - 4.x.x)</sup></i><br/>
        5.7<br/><i><sup>(4.0.0 - 4.6.1)</sup></i>
    </td>
    <td>
        iOS 13.0<br/>
        macOS 10.15<br/>
        tvOS 13.0<br/>
        watchOS 6.0
    </td>
    <td>API changes.</td>
  </tr>
  
  <tr>
    <td>
        3.0<br/><i><sup>(3.0.0 - 3.20.2)</sup></i>
    </td>
    <td>2022 05 17</td>
    <td>5.6</td>
    <td>
        iOS 13.0<br/>
        macOS 10.15<br/>
        tvOS 13.0<br/>
        watchOS 6.0
    </td>
    <td>
        Multiplatform support.<br/>
        SPM support.
    </td>
  </tr>
  
  <tr>
    <td>
        2.0<br/><i><sup>(2.0.0 - 2.3.0)</sup></i>
    </td>
    <td>2021 12 28</td>
    <td>5.3</td>
    <td>iOS 13.0</td>
    <td>iOS 13.0 support</td>
  </tr>
  
  <tr>
    <td>
        1.0<br/><i><sup>(1.0.0 - 1.4.0)</sup></i>
    </td>
    <td>2021 10 07</td>
    <td>5.3</td>
    <td>iOS 14.0</td>
    <td>-</td>
  </tr>

</table>

## Contact

e-mail: vakho.kontridze@gmail.com
