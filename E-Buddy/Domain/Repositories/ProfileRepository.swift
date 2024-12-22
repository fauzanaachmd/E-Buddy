//
//  ProfileRepository.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 22/12/2024.
//

import Combine
import UIKit

protocol ProfileRepository {
    func getUsers() -> AnyPublisher<[User], Error>
    func uploadAvatar(image: UIImage) -> AnyPublisher<Bool, Error>
}
