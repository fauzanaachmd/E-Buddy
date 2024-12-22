//
//  DefaultProfileRepository.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 22/12/2024.
//

import Combine
import Foundation

struct DefaultProfileRepository: ProfileRepository {
    private let remoteDataSource: ProfileRemoteDataSource

    init(remoteDataSource: ProfileRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getUsers() -> AnyPublisher<[User], Error> {
        remoteDataSource.getUsers()
    }
}
