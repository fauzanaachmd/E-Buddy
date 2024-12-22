//
//  ContentView.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 19/12/2024.
//

import SwiftUI

struct HomeView: View {
    private let navigator: ProfileNavigator
    @StateObject var viewModel: ProfileViewModel

    init(navigator: ProfileNavigator, viewModel: ProfileViewModel) {
        self.navigator = navigator
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            VStack {
                if let users = viewModel.users.value {
                    ScrollView {
                        VStack {
                            ForEach(users.indices, id: \.self) { index in
                                let user = users[safe: index]
                                VStack {
                                    Text("Email: \(user?.email ?? "")")
                                    Text("Gender: \(user?.genderDescription ?? "")")
                                    Text("Phone Number: \(user?.phoneNumber ?? "")")
                                }
                                Divider()
                            }
                        }
                    }
                }

                NavigationLink(destination: navigator.navigateToProfile) {
                    Text("Go To Profile")
                }
            }
            .padding()
        }
        .onAppear {
            if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
                print("Firebase Config: \(path)")
            }
            viewModel.requestUsers()
        }
        .onChange(dataState: viewModel.$users)
        .showLoading(isShowing: .constant(viewModel.isLoading))
    }
}

#Preview {
    let assembler = AppAssembler()
    return HomeView(navigator: assembler.navigator(), viewModel: assembler.viewModel())
}
