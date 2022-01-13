//
//  TheeyeAPI.swift
//  Theeye
//
//  Created by Murad Ibrohimov on 13.11.21.
//  Copyright © 2021 Theeye. All rights reserved.
//

import UIKit

class TheeyeAPI: NetworkAgent {
    
    static let shared = TheeyeAPI()
    
    let session: URLSession
    
    #if DEBUG
    private let baseURL = URL(string: "http://dev.theeye.live:8000/server/api/v1")!
    #else
    private let baseURL = URL(string: "http://theeye.live:8000/server/api/v1/")!
    #endif

    var defaultHeaders: [String: String?] {[
        HeaderKeys.contentType: "application/json",
        HeaderKeys.token: Keychain.token
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
                completion: @escaping (Result<SignInResponse, APIError>) -> Void) {
        let url = baseURL.appendingPathComponent("signin_zoomer")
        let request = createRequest(url, method: .post, body: request, headers: defaultHeaders)
        run(request, completion: completion)
    }
    
    /**
     Send user device id to the server.
     */
    func sendDeviceID(_ request: SendDeviceIDRequest,
                completion: @escaping (Result<GlobalAPIResponse, APIError>) -> Void) {
        let url = baseURL.appendingPathComponent("deviceToken")
        let request = createRequest(url, method: .post, body: request, headers: defaultHeaders)
        run(request, completion: completion)
    }
    
    /**
     Get real property for streaming.
     */
    func getRealProperty(completion: @escaping (Result<GetRealPropertyResponse, APIError>) -> Void) {
        let url = baseURL.appendingPathComponent("stream_property")
        let request = createRequest(url, method: .get, headers: defaultHeaders)
        run(request, completion: completion)
    }
    
    /**
     Close stream/broadcast session.
     */
    func closeSession(_ request: CloseSessionRequest,
                completion: @escaping (Result<GlobalAPIResponse, APIError>) -> Void) {
        let url = baseURL.appendingPathComponent("openvidu/close")
        let request = createRequest(url, method: .post, body: request, headers: defaultHeaders)
        run(request, completion: completion)
    }
    
    /**
     Get zoomer profile.
     */
    func getZoomer(completion: @escaping (Result<GetZoomerResponse, APIError>) -> Void) {
        let url = baseURL.appendingPathComponent("zoomer/get_user")
        let request = createRequest(url, method: .get, headers: defaultHeaders)
        run(request, completion: completion)
    }
    
    /**
     Delete zoomer profile image.
     */
    func deleteZoomerProfileImage(completion: @escaping (Result<GlobalAPIResponse, APIError>) -> Void) {
        let url = baseURL.appendingPathComponent("zoomer/delete_avatar")
        let request = createRequest(url, method: .patch, headers: defaultHeaders)
        run(request, completion: completion)
    }
    
    /**
     Close stream/broadcast session.
     */
    func updateZoomerProfileImage(_ request: UpdateZoomerProfileImageRequest,
                completion: @escaping (Result<GlobalAPIResponse, APIError>) -> Void) {
        let url = baseURL.appendingPathComponent("zoomer/avatar")
        let request = createRequest(url, method: .patch, body: request, headers: defaultHeaders)
        run(request, completion: completion)
    }
    
}
