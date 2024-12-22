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
    @Published var uploadAvatar: DataState<Bool> = .initiate {
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
            } receiveValue: { [weak self] uploadAvatarResponse in
                guard let self else { return }
                requestUsers()
                self.uploadAvatar = .success(data: uploadAvatarResponse)
            }
            .store(in: &cancelables)
    }
}
