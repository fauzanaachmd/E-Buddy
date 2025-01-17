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
    @State private var image: UIImage?
    @State private var isShowingCamera = false

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
                                if let user {
                                    UserList(isShowingCamera: $isShowingCamera, user: user)
                                        .environmentObject(viewModel)
                                }
                            }
                        }
                    }
                }

                NavigationLink(destination: navigator.navigateToProfile) {
                    Text("Go To Profile")
                }

                NavigationLink(destination: navigator.navigateToProfile) {
                    Text("Go To Login feature")
                
            }
            .padding()
        }
        .onAppear {
            viewModel.requestUsers()
        }
        .onChange(dataState: viewModel.$users)
        .showLoading(isShowing: .constant(viewModel.isLoading))
        .sheet(isPresented: $isShowingCamera) {
            CameraPhotoPicker(image: $image)
        }
        .onChange(of: image) { oldValue, newValue in
            if let theImage = newValue {
                viewModel.requestUploadAvatar(image: theImage)
            }
        }
    }
}

struct UserList: View {
    @EnvironmentObject var viewModel: ProfileViewModel
    @Binding var isShowingCamera: Bool
    let user: User
    var body: some View {
        VStack {
            Text("UID: \(user.uid)")
            Text("Email: \(user.email)")
            Text("Gender: \(user.genderDescription)")
            Text("Phone Number: \(user.phoneNumber)")

            if !user.avatar.isEmpty {
                AsyncImage(url: URL(string: user.avatar)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 128, height: 128)
                .clipShape(.rect(cornerRadius: 25))
            }

            Button(action: {
                viewModel.selectedUserId = user.uid
                isShowingCamera = true
            }, label: {
                Text("Upload Avatar")
            })
        }
        Divider()
    }
}

#Preview {
    let assembler = AppAssembler()
    return HomeView(navigator: assembler.navigator(), viewModel: assembler.viewModel())
}
