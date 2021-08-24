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
    private var queue: DispatchQueue { NetworkService.shared.queue }
}

// MARK:- GET
extension NetworkRequestService {
    func get<Parameters, Entity>(
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
            let requestResult: Result<URLRequest, NetworkError> = NetworkRequestFactory.get(
                endpoint: endpoint,
                headers: headers,
                parameters: encodedParameters
            )
            
            switch requestResult {
            case .success(let request):
                let task: URLSessionDataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
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
            queue.async(completion(.failure(.incompleteParameters(
                code: encodingError.nsErrorCode,
                description: encodingError.localizedDescription
            ))))
        }
    }
}

// MARK:- POST
extension NetworkRequestService {
    func post<Parameters, Entity>(
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
            let request: URLRequest = NetworkRequestFactory.post(
                url: url,
                headers: headers,
                body: encodedParameters
            )
            
            let task: URLSessionDataTask = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
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
            queue.async(completion(.failure(.incompleteParameters(
                code: encodingError.nsErrorCode,
                description: encodingError.localizedDescription
            ))))
            return
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
            queue.async(completion(.failure(.returnedWithError(
                code: error.nsErrorCode,
                description: error.localizedDescription
            ))))
        
        } else if let response = response, !response.isValid {
            queue.async(completion(.failure(.invalidResponse(
                code: response.httpURLCode,
                description: response.description
            ))))
        
        } else if let data = data {
            switch decode(data) {
            case .success(let decodedData):
                queue.async(completion(.success(decodedData)))
            
            case .failure(let decodingError):
                queue.async(completion(.failure(.incompleteEntity(
                    code: error?.nsErrorCode,
                    description: decodingError.localizedDescription
                ))))
            }
        
        } else {
            queue.async(completion(.failure(.incompleteEntity(
                code: nil,
                description: nil
            ))))
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

// MARK:- Error Code
extension Error {
    fileprivate var nsErrorCode: Int? {
        (self as NSError).code
    }
}

extension URLResponse {
    fileprivate var httpURLCode: Int? {
        (self as? HTTPURLResponse)?.statusCode
    }
}

