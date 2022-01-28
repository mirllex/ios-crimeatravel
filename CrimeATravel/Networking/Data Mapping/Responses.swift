//
//  Responses.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.11.22.
//  Copyright © 2022 CrimeATravel. All rights reserved.
//

import UIKit
import Kingfisher

//MARK: -Authorization

struct GeneralAPIResponse: Decodable {
    let result: Int
    let msg: String
}


struct CodeConfirmationResponse: Decodable {
    let result: Int
    let msg: String
    let data: CodeConfirmationData
    
    struct CodeConfirmationData: Decodable {
        let accessToken: String
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
        }
    }
}
