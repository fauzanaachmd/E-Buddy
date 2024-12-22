//
//  ProfileViewModel.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 21/12/2024.
//

import Combine
import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var users: DataState<[User]> = .initiate {
        didSet {
            isLoading = users == .loading
        }
    }
    @Published var isLoading: Bool = false
    internal var cancelables: Set<AnyCancellable> = []

    private let getUsersUseCase: GetUsersUseCase

    init(getUsersUseCase: GetUsersUseCase) {
        self.getUsersUseCase = getUsersUseCase
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
}
