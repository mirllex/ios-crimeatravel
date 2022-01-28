//
//  CrimeATravelAPI.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.11.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit

class CrimeATravelAPI: NetworkAgent {
    
    static let shared = CrimeATravelAPI()
    
    let session: URLSession
    
    #if DEBUG
    private let baseURL = URL(string: "http://87.249.44.28:8000")!
    #else
    private let baseURL = URL(string: "http://87.249.44.28:8000")!
    #endif

    var defaultHeaders: [String: String?] {[
        HeaderKeys.contentType: "application/json",
        HeaderKeys.token: Keychain.accessToken
    ]}
    
    enum HeaderKeys {
        static let contentType = "Content-Type"
        static let token = "csrf"
        static let deviceID = "Device"
        static let locale = "Locale"
    }
    
    init() {
      let configuration = URLSessionConfiguration.default
      configuration.timeoutIntervalForRequest = 60
      if #available(iOS 11.0, *) {
        configuration.waitsForConnectivity = true
      }
      self.session = URLSession(configuration: configuration)
    }
    
    /**
     User login request.
     */
    func signIn(_ request: SignInRequest,
                completion: @escaping (Result<GeneralAPIResponse, APIError>) -> Void) {
        let url = baseURL.appendingPathComponent("signIn")
        let request = createRequest(url, method: .post, body: request, headers: defaultHeaders)
        run(request, completion: completion)
    }
    
    /**
     User code cofirmation request.
     */
    func codeConfirmation(_ request: CodeConfirmationRequest,
                completion: @escaping (Result<CodeConfirmationResponse, APIError>) -> Void) {
        let url = baseURL.appendingPathComponent("signInSecond")
        let request = createRequest(url, method: .post, body: request, headers: defaultHeaders)
        run(request, completion: completion)
    }
    
    
    /**
     Get real property for streaming.
     */
//    func getRealProperty(completion: @escaping (Result<GetRealPropertyResponse, APIError>) -> Void) {
//        let url = baseURL.appendingPathComponent("stream_property")
//        let request = createRequest(url, method: .get, headers: defaultHeaders)
//        run(request, completion: completion)
//    }

}
