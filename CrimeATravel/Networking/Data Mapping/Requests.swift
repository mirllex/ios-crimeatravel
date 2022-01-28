//
//  Requests.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.11.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import Foundation
import SwiftUI

//MARK: -Authorization

struct SignInRequest: Encodable {
    let phone: String
    
    enum CodingKeys: String, CodingKey {
        case phone = "tel"
    }
}

struct CodeConfirmationRequest: Encodable {
    let phone: String
    let smsCode: String
    
    enum CodingKeys: String, CodingKey {
        case phone = "tel"
        case smsCode = "vercode"
    }
}
