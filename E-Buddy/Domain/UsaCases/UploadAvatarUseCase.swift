//
//  UploadAvatarUseCase.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 22/12/2024.
//

import Combine
import UIKit

protocol UploadAvatarUseCase {
    func execute(userId: String, image: UIImage) -> AnyPublisher<Bool, Error>
}

struct DefaultUploadAvatarUseCase: UploadAvatarUseCase {
    private let repository: ProfileRepository

    init(repository: ProfileRepository) {
        self.repository = repository
    }

    func execute(userId: String, image: UIImage) -> AnyPublisher<Bool, Error> {
        repository.uploadAvatar(userId: userId, image: image)
    }
}
