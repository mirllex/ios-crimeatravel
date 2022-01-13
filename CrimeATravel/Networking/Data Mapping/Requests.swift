//
//  Requests.swift
//  Theeye
//
//  Created by Murad Ibrohimov on 13.11.21.
//  Copyright © 2021 Theeye. All rights reserved.
//

import Foundation
import SwiftUI

//MARK: -Authorization

struct SignInRequest: Encodable {
    let email: String
    let password: String
}

struct SendDeviceIDRequest: Encodable {
    let deviceID: String
    
    enum CodingKeys: String, CodingKey {
        case deviceID = "token"
    }
}

struct CloseSessionRequest: Encodable {
    let sessionID: String
    
    enum CodingKeys: String, CodingKey {
        case sessionID = "id"
    }
}

struct UpdateZoomerProfileImageRequest: Encodable {
    let img: String
    let type: String = "jpeg"
}
