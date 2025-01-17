//
//  ProfileAssembler.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 22/12/2024.
//

import Foundation

protocol ProfileAssembler {
    func view() -> HomeView
    func view() -> ProfileView

    func navigator() -> ProfileNavigator

    func viewModel() -> ProfileViewModel

    func repository() -> ProfileRepository

    func remoteDataSource() -> ProfileRemoteDataSource

    func useCase() -> GetUsersUseCase
    func useCase() -> UploadAvatarUseCase
}

extension ProfileAssembler where Self: Assembler {
    func view() -> HomeView {
        HomeView(navigator: navigator(), viewModel: viewModel())
    }

    func view() -> ProfileView {
        ProfileView()
    }

    func navigator() -> ProfileNavigator {
        DefaultProfileNavigator(assembler: self)
    }

    func viewModel() -> ProfileViewModel {
        ProfileViewModel(getUsersUseCase: useCase(), uploadAvatarUseCase: useCase())
    }

    func repository() -> ProfileRepository {
        DefaultProfileRepository(remoteDataSource: remoteDataSource())
    }

    func remoteDataSource() -> ProfileRemoteDataSource {
        DefaultProfileRemoteDataSource()
    }

    func useCase() -> GetUsersUseCase {
        DefaultGetUserUseCase(repository: repository())
    }

    func useCase() -> UploadAvatarUseCase {
        DefaultUploadAvatarUseCase(repository: repository())
    }
}
