//
//  DefaultProfileRepository.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 22/12/2024.
//

import Combine
import UIKit

struct DefaultProfileRepository: ProfileRepository {
    private let remoteDataSource: ProfileRemoteDataSource

    init(remoteDataSource: ProfileRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getUsers() -> AnyPublisher<[User], Error> {
        remoteDataSource.getUsers()
    }

    func uploadAvatar(userId: String, image: UIImage) -> AnyPublisher<String, Error> {
        remoteDataSource.uploadAvatar(userId: userId, image: image)
    }
}
