//
//  NetworkRequestService.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 8/24/21.
//

import Foundation

// MARK:- Network Request Service
struct NetworkRequestService {
    // MARK: Properties
    private var urlSessionConfiguration: URLSessionConfiguration = {
        let configuration: URLSessionConfiguration = .default
        configuration.timeoutIntervalForRequest = NetworkService.shared.timeoutIntervalForRequest
        configuration.timeoutIntervalForResource = NetworkService.shared.timeoutIntervalForResource
        return configuration
    }()
    
    private var urlSession: URLSession { .init(configuration: urlSessionConfiguration) }
    
    private var queue: DispatchQueue { NetworkService.shared.queue }
}

// MARK:- GET
extension NetworkRequestService {
    func GET<Parameters, Entity>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<Entity, NetworkError>) -> Void,
        encode: @escaping (Parameters) -> Result<[String: Any], NetworkError>,
        decode: @escaping (Data) -> Result<Entity, NetworkError>
    ) {
        guard NetworkConnectionService.isConnectedToNetwork else {
            queue.async(completion(.failure(.notConnectedToNetwork)))
            return
        }

        switch encode(parameters) {
        case .success(let encodedParameters):
            let requestResult: Result<URLRequest, NetworkError> = NetworkRequestFactory.GET(
                endpoint: endpoint,
                headers: headers,
                parameters: encodedParameters
            )
            
            switch requestResult {
            case .success(let request):
                let task: URLSessionDataTask = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
                    process(
                        data: data,
                        response: response,
                        error: error,
                        completion: completion,
                        decode: decode
                    )
                })
                
                task.resume()
                
            case .failure(let error):
                completion(.failure(error))
            }
            
        case .failure(let encodingError):
            queue.async(completion(.failure(.incompleteParameters(.init(
                domain: encodingError.domain,
                code: encodingError.code,
                description: encodingError.secondaryDescription
            )))))
        }
    }
}

// MARK:- POST
extension NetworkRequestService {
    func POST<Parameters, Entity>(
        endpoint: String,
        headers: [String: Any],
        parameters: Parameters,
        completion: @escaping (Result<Entity, NetworkError>) -> Void,
        encode: @escaping (Parameters) -> Result<Data, NetworkError>,
        decode: @escaping (Data) -> Result<Entity, NetworkError>
    ) {
        guard NetworkConnectionService.isConnectedToNetwork else {
            queue.async(completion(.failure(.notConnectedToNetwork)))
            return
        }
        
        guard let url = URL(string: endpoint) else {
            queue.async(completion(.failure(.invalidEndpoint)))
            return
        }
        
        switch encode(parameters) {
        case .success(let encodedParameters):
            let request: URLRequest = NetworkRequestFactory.POST(
                url: url,
                headers: headers,
                body: encodedParameters
            )
            
            let task: URLSessionDataTask = urlSession.dataTask(with: request, completionHandler: { (data, response, error) in
                process(
                    data: data,
                    response: response,
                    error: error,
                    completion: completion,
                    decode: decode
                )
            })
            
            task.resume()
            
        case .failure(let encodingError):
            queue.async(completion(.failure(.incompleteParameters(.init(
                domain: encodingError.domain,
                code: encodingError.code,
                description: encodingError.secondaryDescription
            )))))
        }
    }
}

// MARK:- Process
extension NetworkRequestService {
    func process<Entity>(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        completion: @escaping (Result<Entity, NetworkError>) -> Void,
        decode: @escaping (Data) -> Result<Entity, NetworkError>
    ) {
        if let error = error {
            queue.async(completion(.failure(.returnedWithError(.init(
                domain: (error as NSError).domain,
                code: (error as NSError).code,
                description: error.localizedDescription
            )))))
        
        } else if let response = response, !response.isValid {
            queue.async(completion(.failure(.invalidResponse(.init(
                domain: nil,
                code: (response as? HTTPURLResponse)?.statusCode,
                description: response.description
            )))))
        
        } else if let data = data {
            switch decode(data) {
            case .success(let decodedData):
                queue.async(completion(.success(decodedData)))
            
            case .failure(let decodingError):
                queue.async(completion(.failure(.incompleteEntity(.init(
                    domain: decodingError.domain,
                    code: decodingError.code,
                    description: decodingError.secondaryDescription
                )))))
            }
        
        } else {
            queue.async(completion(.failure(.incompleteEntity(.init(
                domain: nil,
                code: nil,
                description: nil
            )))))
        }
    }
}

// MARK:- Async
extension DispatchQueue {
    fileprivate func async(_ block: @autoclosure @escaping () -> Void) {
        async(execute: block)
    }
}

// MARK:- Validation
extension URLResponse {
    fileprivate var isValid: Bool {
        guard
            let httpResponse = self as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            return false
        }

        return true
    }
}
