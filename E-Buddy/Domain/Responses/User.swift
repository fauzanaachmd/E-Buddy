//
//  UserResponse.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 21/12/2024.
//

import SwiftUI

struct User: Codable {
    var uid: String
    var email: String
    var phoneNumber: String
    var gender: Int
    var avatar: String

    var genderEnum: GenderEnum? {
        guard let theGender = GenderEnum(rawValue: gender) else {
            return nil
        }

        return theGender
    }

    var genderDescription: String {
        switch genderEnum {
        case .female:
            return "Female"
        case .male:
            return "Male"
        case nil:
            return ""
        }
    }
}
