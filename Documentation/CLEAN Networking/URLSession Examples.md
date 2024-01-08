# URLSession Examples

## Table of Contents

- [Intro](#intro)
- [Simple Request](#simple-request)
- [Request with Data and Response Processing](#request-with-data-and-response-processing)
- [Request with Progress Observation](#request-with-progress-observation)

## Intro

This document provides examples of network requests made using `URLSession` following the principles of "CLEAN Gateways," as discussed elsewhere.

## Simple Request

Following gateway initiates a straightforward request to retrieve a `GetPostEntity` object with an identifier specified by `GetPostGatewayParameters.id`:

```swift
protocol GetPostGateway {
    func fetch(with parameters: GetPostGatewayParameters) async throws -> GetPostEntity
}

struct GetPostGatewayParameters {
    let id: Int
}

@MemberwiseCodable
struct GetPostEntity: Decodable {
    @MWCKey("id") let id: Int
    @MWCKey("userId") let userID: Int
    @MWCKey("title") let title: String
    @MWCKey("body") let body: String
}

struct GetPostNetworkGateway: GetPostGateway {
    func fetch(with parameters: GetPostGatewayParameters) async throws -> GetPostEntity {
        let urlString: String = "https://jsonplaceholder.typicode.com/posts/\(parameters.id)"
        guard let url: URL = .init(string: urlString) else { throw URLError(.badURL) }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        try request.addHTTPHeaderFields(object: JSONRequestHeaderFields())

        let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)

        guard response.isSuccessHTTPStatusCode else { throw URLError(.badServerResponse) }

        let entity: GetPostEntity = try JSONDecoder().decode(GetPostEntity.self, from: data)

        return entity
    }
}
```

Request is initiated to retrieve a post with an ID of `1`:

```
Task(operation: {
    do {
        let parameters: GetPostGatewayParameters = .init(id: 1)

        let entity: GetPostEntity = try await GetPostNetworkGateway().fetch(with: parameters)

        dump(entity)

    } catch {
        print(error.localizedDescription)
    }
})
```

## Request with Data and Response Processing

#### Problem

Frequently, databases return their data or response objects in the form of nested JSON representations:

```swift
{
    "success": false,
    "message": "You are encountered ... error",
    "data": {
        ...
    }
}
```

#### Solution

To reduce redundancy in code, still utilize Swift's built-in `JSONDecoder` without overcomplicating entity objects with excessive nesting, we can implement two methods:

- One method for handling the response object and mapping it to a throwable `Error` type
- Another method for processing the data object and extracting the nested data component

For the illustration, `httpbin` API is used.

#### Custom Error

Custom error can be introduced to perform mapping:

```swift
struct SomeInternalError: LocalizedError {
    let code: Int
    let message: String
}
```

#### Response Processing

The following method attempts to extract an internal error and convert it into a throwable `Error` type, if it's present. 

If the `URLResponse` falls within the range of `200` to `299` status codes, the processing is skipped.

However, if it doesn't, corresponding status code and message are retrieved and thrown as an error:

```swift
func processURLSessionResponse(
    _ data: Data,
    _ response: URLResponse
) throws -> URLResponse {
    if response.isSuccessHTTPStatusCode { return response }

    guard
        let code: Int = (response as? HTTPURLResponse)?.statusCode
    else {
        throw URLError(.badServerResponse)
    }

    guard
        let json: [String: Any?] = try? JSONDecoder.decodeJSONFromData(data),
        let message: String = json["error"]?.toString
    else {
        throw URLError(.cannotDecodeContentData)
    }

    throw SomeInternalError(code: code, message: message)
}
```

#### Data Processing

The following method aims to extract a nested JSON representation and map it back to `Data` as if no nesting ever took place:

```swift
func processURLSessionData(
    _ data: Data,
    _ response: URLResponse
) throws -> Data {
    guard
        let json: [String: Any?] = try? JSONDecoder.decodeJSONFromData(data),
        let dataObjectOpt: Any? = json["json"],
        let dataObject: Any = dataObjectOpt,
        let dataData: Data = try? JSONEncoder.encodeAnyToData(dataObject)
    else {
        throw URLError(.cannotDecodeContentData)
    }

    return dataData
}
```

#### Gateway

Following gateway initiates a request to echo a `String`, specified by `EchoGatewayParameters.value`. Within the `EchoNetworkGateway`, both `Data` and `URLResponse` are processed with methods defined above.

```swift
protocol EchoGateway {
    func fetch(with parameters: EchoGatewayParameters) async throws -> EchoEntity
}

@MemberwiseCodable
struct EchoGatewayParameters: Encodable {
    @MWCKey("value") let value: String
}

@MemberwiseCodable
struct EchoEntity: Decodable {
    @MWCKey("value") let value: String
}

struct EchoNetworkGateway: EchoGateway {
    func fetch(with parameters: EchoGatewayParameters) async throws -> EchoEntity {
        let url: URL = #URL("https://httpbin.org/post")

        var request: URLRequest = .init(url: url)
        request.httpMethod = "POST"
        try request.addHTTPHeaderFields(object: JSONRequestHeaderFields())
        request.httpBody = try JSONEncoder().encode(parameters).nonEmpty

        let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)

        _ = try processURLSessionResponse(data, response)

        let processedData: Data = try processURLSessionData(data, response)
        let entity: EchoEntity = try JSONDecoder().decode(EchoEntity.self, from: processedData)

        return entity
    }
}
```

#### Usage Example

Request is initiated to echo a `String` "test":

```swift
Task(operation: {
    do {
        let parameters: EchoGatewayParameters = .init(value: "test")

        let entity: EchoEntity = try await EchoNetworkGateway().fetch(with: parameters)

        print(entity.value) // "test"

    } catch {
        print(error.localizedDescription)
    }
})
```

## Request with Progress Observation

Following gateway initiates a request to retrieve an `UIImage` with from an url, and communicate the download progress:

```swift
protocol FetchImageGateway {
    func fetch(
        with parameters: FetchImageGatewayParameters,
        onProgressChange progressHandler: (Double) -> Void
    ) async throws -> FetchImageEntity
}

struct FetchImageGatewayParameters {
    let url: String
}

struct FetchImageEntity {
    let image: UIImage?
}

struct FetchImageNetworkGateway: FetchImageGateway {
    func fetch(
        with parameters: FetchImageGatewayParameters,
        onProgressChange progressHandler: (Double) -> Void
    ) async throws -> FetchImageEntity {
        guard let url: URL = .init(string: parameters.url) else { throw URLError(.badURL) }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        try request.addHTTPHeaderFields(object: JSONRequestHeaderFields())

        let (asyncBytes, response) = try await URLSession.shared.bytes(for: request)

        let totalBytes: Int = .init(response.expectedContentLength)
        var progressPrevious: Double = 0

        var data: Data = .init()

        for try await byte in asyncBytes {
            data.append(byte)

            let current: Int = data.count
            let progress: Double = .init(current) / .init(totalBytes)

            if
                progress - progressPrevious > 0.01 ||
                progress == 1
            {
                progressHandler(progress)
                progressPrevious = progress
            }
        }

        guard let image: UIImage = .init(data: data) else { throw URLError(.cannotDecodeContentData) }
        let entity: FetchImageEntity = .init(image: image)

        return entity
    }
}
```swift

Request is initiated to retrieve an `UIImage` and print the download progress:

```swift
Task(operation: {
    do {
        let url: String = "https://www.nasa.gov/sites/default/files/thumbnails/image/main_image_star-forming_region_carina_nircam_final-5mb.jpg"
        let parameters: FetchImageGatewayParameters = .init(url: url)
        
        let entity: FetchImageEntity = try await FetchImageNetworkGateway().fetch(
            with: parameters, 
            onProgressChange: { print($0) }
        )

        print(entity.image)

    } catch {
        print(error.localizedDescription)
    }
})
```
