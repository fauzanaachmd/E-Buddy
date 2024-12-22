//
//  ProfileRepository.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 22/12/2024.
//

import Combine

protocol ProfileRepository {
    func getUsers() -> AnyPublisher<[User], Error>
}
