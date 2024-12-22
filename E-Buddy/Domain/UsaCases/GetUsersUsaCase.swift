//
//  GetUsersUsacase.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 22/12/2024.
//

import Combine
import Foundation

protocol GetUsersUseCase {
    func execute() -> AnyPublisher<[User], Error>
}

struct DefaultGetUserUseCase: GetUsersUseCase {
    private let repository: ProfileRepository

    init(repository: ProfileRepository) {
        self.repository = repository
    }

    func execute() -> AnyPublisher<[User], Error> {
        repository.getUsers()
    }
}
