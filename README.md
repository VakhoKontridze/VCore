# VCore

## Table of Contents

- [Intro](#intro)
- [Structure](#structure)
- [Showcase](#showcase)
- [Installation](#installation)
- [Compatibility](#compatibility)
- [Contact](#contact)

## Intro

VCore is a Swift collection containing objects, functions, and extensions that I use in my projects.

## Structure

Package files are grouped as:

- ***Views***. `View`s, `UIView`s, and `UIViewController`s. For instance, `SwiftUIBaseButton`.

- ***Models***. Models. For instance, `GenericState`s and `GenericStateModel`s.

- ***Services and Managers***. Services, managers, and controllers. For instance, `MultiPartFormDataBuilder`.

- ***Helpers***. Helper objects and methods. For instance, architectural pattern helpers.

- ***Extensions***. Extensions.

- ***Global Functions***. Global functions. For instance, `FIXME(_:)` and `TODO(_:)`.

- ***Macros***. Macros. For instance, `CodingKeysGeneration`.

- ***API***. Objects used for interfacing from you app/package with `VCore`. For instance, `VCoreLocalizationManager`.

Package incudes folder `Extra`, which contains:

- ***XCode Templates***. Templates that can be used for accelerating workflow.

Project includes folder `Documentation`, which contains:

- Various documentation

## Showcase

#### Modal Presenter

Manager that allows for creating and presentation of custom modals.

For additional info, refer to "Modal Presenter" documentation.

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

let url: URL = #url("https://somewebsite.com/api/some_endpoint")

var request: URLRequest = .init(url: url)
request.httpMethod = "POST"
try request.addHTTPHeaderFields(
    object: MultipartFormDataAuthorizedRequestHeaderFields(
        boundary: boundary,
        token: "token"
    )
)
request.httpBody = httpData.nonEmpty

let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)

...
```

#### Keychain Service

`KeychainService` that supports custom queries, and has a dedicated property wrapper:

```swift
KeychainService.default.getData(key: "SomeKey")
KeychainService.default.setData(key: "SomeKey", value: data)
KeychainService.default.deleteData(key: "SomeKey")
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
    AlignedGridLayout(alignment: .center, spacing: 5) {
        ForEach(strings, id: \.self) { string in
            Text(string)
                .background(Color.accentColor.opacity(0.5))
        }
    }
    .padding()
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

let value: SomeEnum? = .init(key: \.someProperty, value: 2)
```

#### Various Extensions

Retrieving `CGSize` form `View`:

```swift
@State private var size: CGSize = .zero

var body: some View {
    VStack {
        Color.accentColor
            .getSize { size = $0 }
    }
}
```

#### Various Global Functions

Function that calls `fatalError` because feature is not implemented: 

```swift
func didTapContinueButton() {
    FIXME()
}
```

#### Various Macros

Macro that adds `CodingKeys` to a declaration:

```swift
@CodingKeysGeneration
struct GetPostGatewayOutput: Decodable {
    @CKGProperty("id") let id: Int
    @CKGProperty("userId") let userID: Int
    @CKGProperty("title") let title: String
    @CKGProperty("body") let body: String
    
    var attributes: [String: Any?] = [:]
}

// Generates
internal enum CodingKeys: String, CodingKey {
    case id = "id"
    case userID = "userId"
    case title = "title"
    case body = "body"
}
```

## Installation

#### Swift Package Manager

Add `https://github.com/VakhoKontridze/VCore` as a Swift Package in Xcode and follow the instructions.

## Compatibility

#### Platform and Version Support

Package provides limited `macOS`, `tvOS`, `watchOS`, and `visionOS` support.

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
    <td>8.0</td>
    <td>2025 XX XX</td>
    <td>6.2</td>
    <td>
        iOS 17.0<br>
        macOS 14.0<br>
        tvOS 17.0<br>
        watchOS 10.0<br>
        visionOS 1.0
    </td>
    <td>
        New SDK.<br>
        API changes.
    </td>
  </tr>
  
  <tr>
    <td>7.0</td>
    <td>2024 09 20</td>
    <td>
        6.1<br><i><sup>(7.5.2 – 7.x.x)</sup></i>
        6.0<br><i><sup>(7.0.1 - 7.5.1)</sup></i><br>
    </td>
    <td>
        iOS 16.0<br>
        macOS 13.0<br>
        tvOS 16.0<br>
        watchOS 9.0<br>
        visionOS 1.0
    </td>
    <td>
        New SDK.<br>
        API changes.
    </td>
  </tr>
  
  <tr>
    <td>6.0</td>
    <td>2024 02 18</td>
    <td>
        5.10<br><i><sup>(6.0.1 - 6.x.x)</sup></i><br>
        5.9<br><i><sup>(6.0.0)</sup></i>
    </td>
    <td>
        iOS 15.0<br>
        macOS 12.0<br>
        tvOS 15.0<br>
        watchOS 8.0<br>
        visionOS 1.0
    </td>
    <td>
        visionOS support.<br>
        API changes.
    </td>
  </tr>
  
  <tr>
    <td>5.0</td>
    <td>2023 10 08</td>
    <td>5.9</td>
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
    <td>4.0</td>
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
    <td>3.0</td>
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
    <td>2.0</td>
    <td>2021 12 28</td>
    <td>5.3</td>
    <td>iOS 13.0</td>
    <td>iOS 13.0 support.</td>
  </tr>
  
  <tr>
    <td>1.0</td>
    <td>2021 10 07</td>
    <td>5.3</td>
    <td>iOS 14.0</td>
    <td>-</td>
  </tr>

</table>

For additional info, refer to the [CHANGELOG](https://github.com/VakhoKontridze/VCore/blob/main/CHANGELOG.md).

## Contact

e-mail: vakhtang.kontridze@gmail.com
