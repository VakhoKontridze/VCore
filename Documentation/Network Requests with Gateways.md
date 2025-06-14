# Network Requests with Gateways

## Table of Contents

- [Intro](#intro)
- [Simple Request](#simple-request)
- [Request with Data and Response Processing](#request-with-data-and-response-processing)
- [Request with Progress Observation](#request-with-progress-observation)

## Intro

This document provides examples of network requests made with gateways.

## Simple Request

Following gateway initiates a straightforward request to retrieve a `GetPostGatewayOutput` object with an identifier specified by `GetPostGatewayInput.id`:

```swift
protocol GetPostGatewayProtocol {
    func fetch(with input: GetPostGatewayInput) async throws -> GetPostGatewayOutput
}

struct GetPostGatewayInput {
    let id: Int
}

@CodingKeysGeneration
struct GetPostGatewayOutput: Decodable {
    @CKGProperty("id") let id: Int
    @CKGProperty("userId") let userID: Int
    @CKGProperty("title") let title: String
    @CKGProperty("body") let body: String
}

struct GetPostGateway: GetPostGatewayProtocol {
    func fetch(with input: GetPostGatewayInput) async throws -> GetPostGatewayOutput {
        let urlString: String = "https://jsonplaceholder.typicode.com/posts/\(input.id)"
        guard let url: URL = .init(string: urlString) else { throw URLError(.badURL) }

        var request: URLRequest = .init(url: url)
        request.httpMethod = "GET"
        try request.addHTTPHeaderFields(object: JSONRequestHeaderFields())

        let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)

        guard response.isSuccessHTTPStatusCode else { throw URLError(.badServerResponse) }

        let output: GetPostGatewayOutput = try JSONDecoder().decode(GetPostGatewayOutput.self, from: data)

        return output
    }
}
```

Request is initiated to retrieve a post with an ID of `1`:

```swift
Task {
    do {
        let input: GetPostGatewayInput = .init(id: 1)

        let output: GetPostGatewayOutput = try await GetPostGateway().fetch(with: input)

        dump(output)

    } catch {
        print(error.localizedDescription)
    }
}
```

## Request with Data and Response Processing

#### Problem

Frequently, databases return their data or response objects in the form of nested JSON representations:

```swift
{
    "message": "Something went wrong",
    "data": {
        ...
    }
}
```

#### Solution

To reduce redundancy in code, still utilize Swift's built-in `JSONDecoder` without overcomplicating output objects with excessive nesting, we can implement two methods:

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
    if response.isSuccessHTTPStatusCode { 
        return response 
    }

    guard
        let code: Int = (response as? HTTPURLResponse)?.statusCode
    else {
        throw URLError(.badServerResponse)
    }

    guard
        let json: [String: Any?] = try? JSONDecoder.decodeJSONFromData(data),
        let message: String = json["message"]?.toString
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
        let dataObject: Any = json["data"] ?? nil,
        let dataData: Data = try? JSONEncoder.encodeAnyToData(dataObject)
    else {
        throw URLError(.cannotDecodeContentData)
    }

    return dataData
}
```

#### Gateway

Following gateway initiates a request to echo a `String`, specified by `EchoGatewayInput.value`. Within the `EchoGateway`, both `Data` and `URLResponse` are processed with methods defined above.

```swift
protocol EchoGatewayProtocol {
    func fetch(with input: EchoGatewayInput) async throws -> EchoGatewayOutput
}

@CodingKeysGeneration
struct EchoGatewayInput: Encodable {
    @CKGProperty("value") let value: String
}

@CodingKeysGeneration
struct EchoGatewayOutput: Decodable {
    @CKGProperty("value") let value: String
}

struct EchoGateway: EchoGatewayProtocol {
    func fetch(with input: EchoGatewayInput) async throws -> EchoGatewayOutput {
        let url: URL = #url("https://httpbin.org/post")

        var request: URLRequest = .init(url: url)
        request.httpMethod = "POST"
        try request.addHTTPHeaderFields(object: JSONRequestHeaderFields())
        request.httpBody = try JSONEncoder().encode(input).nonEmpty

        let (data, response): (Data, URLResponse) = try await URLSession.shared.data(for: request)

        _ = try processURLSessionResponse(data, response)

        let processedData: Data = try processURLSessionData(data, response)
        let output: EchoGatewayOutput = try JSONDecoder().decode(EchoGatewayOutput.self, from: processedData)

        return output
    }
}
```

#### Usage Example

Request is initiated to echo a `String` "test":

```swift
Task {
    do {
        let input: EchoGatewayInput = .init(value: "test")

        let output: EchoGatewayOutput = try await EchoGateway().fetch(with: input)

        print(output.value) // "test"

    } catch {
        print(error.localizedDescription)
    }
}
```

## Request with Progress Observation

Following gateway initiates a request to retrieve a `UIImage` with from an url, and communicate the download progress:

```swift
protocol FetchImageGatewayProtocol {
    func fetch(
        with input: FetchImageGatewayInput,
        onProgressChange progressHandler: (Double) -> Void
    ) async throws -> FetchImageGatewayOutput
}

struct FetchImageGatewayInput {
    let url: String
}

struct FetchImageGatewayOutput {
    let image: UIImage?
}

struct FetchImageGateway: FetchImageGatewayProtocol {
    func fetch(
        with input: FetchImageGatewayInput,
        onProgressChange progressHandler: (Double) -> Void
    ) async throws -> FetchImageGatewayOutput {
        guard let url: URL = .init(string: input.url) else { throw URLError(.badURL) }

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
            let progress: Double = Double(current) / Double(totalBytes)

            if
                progress - progressPrevious > 0.01 ||
                progress == 1
            {
                progressHandler(progress)
                progressPrevious = progress
            }
        }

        guard let image: UIImage = .init(data: data) else { throw URLError(.cannotDecodeContentData) }
        let output: FetchImageGatewayOutput = .init(image: image)

        return output
    }
}
```

Request is initiated to retrieve a `UIImage` and print the download progress:

```swift
Task {
    do {
        let url: String = "https://www.nasa.gov/sites/default/files/thumbnails/image/main_image_star-forming_region_carina_nircam_final-5mb.jpg"
        let input: FetchImageGatewayInput = .init(url: url)
        
        let output: FetchImageGatewayOutput = try await FetchImageGateway().fetch(
            with: input, 
            onProgressChange: { print($0) }
        )

        print(output.image)

    } catch {
        print(error.localizedDescription)
    }
}
```
