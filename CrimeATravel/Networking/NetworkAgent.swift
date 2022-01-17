//
//  NetworkAgent.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.11.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case patch = "PATCH"
}

enum APIError: Error {
    case forbidden
    case invalidData
    case invalidURL
    case invalidResponse
    case notFound
    case unknown
    case unableToComplete
    case unauthorized
    case upgradeRequired
    case backend(message: String?)
}

extension APIError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .forbidden:            return "Forbidden."
        case .invalidData:          return "Invalid data format."
        case .invalidURL:           return "Invalid URL."
        case .invalidResponse:      return "Invalid server response."
        case .notFound:             return "Resource not found."
        case .unknown:              return "Unknown error."
        case .unableToComplete:     return "The internet connection is probably interrupted. Please, try again later."
        case .unauthorized:         return "Unautorized access."
        case .upgradeRequired:      return "Your app vervios is too old. Please, update the app."
        case .backend(let message): return message ?? "Server unknown error."
        }
    }
}

protocol NetworkAgent {
    var session: URLSession { get }
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder, completion: @escaping (Result<T, APIError>) -> Void)
    func createRequest<T: Encodable>(_ url: URL, method: HTTPMethod, body: T, headers: [String: String?]?) -> URLRequest
    func createRequest(_ url: URL, method: HTTPMethod, headers: [String: String?]?) -> URLRequest
}

extension NetworkAgent {
    func createRequest<T: Encodable>(_ url: URL, method: HTTPMethod = .post,
                                     body: T, headers: [String: String?]? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = try! JSONEncoder().encode(body)
        if let headers = headers {
            for (k, v) in headers where v != nil {
                request.addValue(v!, forHTTPHeaderField: k)
            }
        }
        return request
    }
    
    func createRequest(_ url: URL, method: HTTPMethod = .get, headers: [String: String?]? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        if let headers = headers {
            for (k, v) in headers where v != nil {
                request.addValue(v!, forHTTPHeaderField: k)
            }
        }
        return request
    }
    
    func run<T: Decodable>(_ request: URLRequest,
                           _ decoder: JSONDecoder = JSONDecoder(),
                           completion: @escaping (Result<T, APIError>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                do {
                    let value = try decoder.decode(T.self, from: data)
                    completion(.success(value))
                } catch {
                    print("Error occured while decoding data: \(error)")
                    completion(.failure(.invalidResponse))
                }
            case 401:
                Defaults.isAuthorized = false
                completion(.failure(.unauthorized))
            case 403:
                completion(.failure(.forbidden))
            case 404:
                completion(.failure(.notFound))
            case 426:
                completion(.failure(.upgradeRequired))
            default:
                if let data = data,
                   let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    completion(.failure(.backend(message: dict["msg"] as? String)))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
    
    /// Метод для составления текстовой части для `multipart/form-data`.
    func convertFormField(named name: String,
                          value: String,
                          using boundary: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"
        
        return fieldString
    }
    
    /// Метод для составления части с файлом для `multipart/form-data`.
    func  convertFileData(fieldName: String,
                          fileName: String,
                          mimeType: String,
                          fileData: Data,
                          using boundary: String) -> Data {
        let data = NSMutableData()
        
        data.append(string: "--\(boundary)\r\n")
        data.append(string: "Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.append(string: "Content-Type: \(mimeType)\r\n\r\n")
        
        data.append(fileData)
        data.append(string: "\r\n")
        
        return data as Data
    }
}

extension NSMutableData {
    func append(string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
