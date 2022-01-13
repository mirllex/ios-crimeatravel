//
//  Responses.swift
//  Theeye
//
//  Created by Murad Ibrohimov on 13.11.21.
//  Copyright © 2021 Theeye. All rights reserved.
//

import UIKit
import Kingfisher

//MARK: -Authorization

struct GlobalAPIResponse: Decodable {
    let result: Int
    let msg: String
}

struct SignInResponse: Decodable {
    let sessionToken: String
    let role: String
    
    enum CodingKeys: String, CodingKey {
        case sessionToken = "session_token"
        case role
    }
}

struct GetRealPropertyResponse: Decodable {
    let result: Int
    let msg: String
    let property: RealProperty?
    
    struct RealProperty: Decodable {
        let id: String
        let locationName: String
        let buildingName: String
        let price: String
        let date: String
        let information: String
        let sessionID: String
        let streamName: String
        let steamCreatedAt: Int
        let iconURL: String
        let images: [ImageURL]
        
        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case locationName = "location"
            case buildingName = "building"
            case price = "price"
            case date = "date"
            case information = "description"
            case sessionID = "sessionId"
            case streamName = "streamName"
            case steamCreatedAt = "createTime"
            case iconURL = "icons"
            case images = "listImages"
        }
    }
    
    struct ImageURL: Decodable {
        let url: String

        enum CodingKeys: String, CodingKey {
            case url = "img"
        }
    }
}

struct GetZoomerResponse: Codable {
    let result: Int
    let msg: String
    let info: ZoomerInfo?
    
    struct ZoomerInfo: Codable {
        let profileImageURL: String?
        let workHours: WorkHours?
        let firstname: String?
        let lastname: String?
        let email: String?
    
        var fullName: String {
            guard let firstname = firstname,
                  let lastname = lastname
            else { return "" }
            return firstname  + " " + lastname
        }
        
        var initials: String {
            var result = ""
            if let firstnameFirstLetter = firstname?.first?.uppercased() {
                result = String(firstnameFirstLetter)
            }
            if let lastnameFirstLetter = lastname?.first?.uppercased() {
                result += String(lastnameFirstLetter)
            }
            if result.isEmpty, let emailInitals = email?.prefix(2) {
                result = String(emailInitals)
            }
            return result
        }
        
        enum CodingKeys: String, CodingKey {
            case profileImageURL = "avatar"
            case workHours = "officehourse"
            case firstname = "firstName"
            case lastname = "lastName"
            case email = "email"
        }
        
        struct WorkHours: Codable {
            let from: String
            let to: String
        }
    }
}
