//
//  ProfileNavigator.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 22/12/2024.
//

import Foundation

protocol ProfileNavigator {
    func navigateToHome() -> HomeView
    func navigateToProfile() -> ProfileView
}

struct DefaultProfileNavigator: ProfileNavigator {
    private let assembler: Assembler

    init(assembler: Assembler) {
        self.assembler = assembler
    }

    func navigateToHome() -> HomeView {
        return assembler.view()
    }

    func navigateToProfile() -> ProfileView {
        return assembler.view()
    }
}
