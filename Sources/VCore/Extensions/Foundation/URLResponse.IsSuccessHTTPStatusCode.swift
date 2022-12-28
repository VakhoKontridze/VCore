//
//  URLResponse.IsSuccessHTTPStatusCode.swift
//  VCore
//
//  Created by Vakhtang Kontridze on 11/19/21.
//

import Foundation

// MARK: - URL Response Is Success HTTP Status Code
extension URLResponse {
    /// Checks that response `HTTP` code is successful.
    ///
    /// Compares status code against `200...299`.
    ///
    ///     URLSession.shared.dataTask(with: someUrl, completionHandler: { (data, response, url) in
    ///         let isSuccess: Bool = response?.isSuccessHTTPStatusCode ?? false
    ///     })
    ///
    public var isSuccessHTTPStatusCode: Bool {
        guard
            let httpResponse: HTTPURLResponse = self as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode)
        else {
            return false
        }

        return true
    }
}
