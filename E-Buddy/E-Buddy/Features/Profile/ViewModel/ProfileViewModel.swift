//
//  ProfileViewModel.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 21/12/2024.
//

import Combine
import Foundation
import UIKit

final class ProfileViewModel: ObservableObject {
    @Published var users: DataState<[User]> = .initiate {
        didSet {
            isLoading = users == .loading
        }
    }
    @Published var uploadAvatar: DataState<String> = .initiate {
        didSet {
            isLoading = uploadAvatar == .loading
        }
    }
    @Published var isLoading: Bool = false
    var selectedUserId: String = ""
    internal var cancelables: Set<AnyCancellable> = []

    private let getUsersUseCase: GetUsersUseCase
    private let uploadAvatarUseCase: UploadAvatarUseCase

    init(
        getUsersUseCase: GetUsersUseCase,
        uploadAvatarUseCase: UploadAvatarUseCase
    ) {
        self.getUsersUseCase = getUsersUseCase
        self.uploadAvatarUseCase = uploadAvatarUseCase
    }

    func requestUsers() {
        users = .loading

        getUsersUseCase.execute()
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    self.users = .failed(reason: error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] users in
                guard let self else { return }
                self.users = .success(data: users)
            }
            .store(in: &cancelables)
    }

    func requestUploadAvatar(image: UIImage) {
        uploadAvatar = .loading

        uploadAvatarUseCase.execute(userId: selectedUserId, image: image)
            .sink { [weak self] completion in
                guard let self else { return }
                switch completion {
                case .failure(let error):
                    self.uploadAvatar = .failed(reason: error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] uploadedAvatarResponse in
                guard let self, !uploadedAvatarResponse.isEmpty else {
                    self?.uploadAvatar = .initiate
                    return
                }
                let updatedUser = self.users.value?.map({ user in
                    if user.uid == self.selectedUserId {
                        return User(uid: user.uid, email: user.email, phoneNumber: user.phoneNumber, gender: user.gender, avatar: uploadedAvatarResponse)
                    }
                    return user
                })

                if let users = updatedUser {
                    self.users = .success(data: users)
                }
                self.uploadAvatar = .success(data: uploadedAvatarResponse)
            }
            .store(in: &cancelables)
    }
}
