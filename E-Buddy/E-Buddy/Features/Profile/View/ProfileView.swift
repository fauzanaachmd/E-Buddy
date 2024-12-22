//
//  ProfileView.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 21/12/2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ProfileBar()

                ProfileSection()

                HStack {
                    Image(.star)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("4.9")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryFont)
                    Text("(61)")
                        .font(.title2)
                        .foregroundColor(.tertiaryFont)

                    Spacer()
                }
                .padding()

                HStack {
                    Image(.mana)
                        .resizable()
                        .frame(width: 40, height: 40)
                    Text("110")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.primaryFont)
                    +
                    Text(".00/1hr")
                        .font(.title3)
                        .foregroundColor(.primaryFont)

                    Spacer()
                }
                .padding()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .toolbar(.hidden)
        .background(Color.primaryBackground)
    }
}

struct ProfileBar: View {
    var body: some View {
        HStack {
            Text("Zynx")
                .font(.system(size: 26))
                .fontWeight(.bold)
                .foregroundStyle(.primaryFont)
            Circle()
                .foregroundColor(.badgeSuccess)
                .frame(width: 8, height: 8)

            Spacer()

            Button {

            } label: {
                Image(.verified)
            }

            Button {

            } label: {
                Image(.instagram)
                    .renderingMode(.template)
                    .tint(.primaryFont)
            }
        }
        .padding()
    }
}

struct ProfileSection: View {
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                Image(.profileBg)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width - 16, height: 400)
                    .cornerRadius(16)

                HStack {
                    Image(.lighting)
                        .frame(width: 16, height: 16)
                    Text("Available today!")
                        .foregroundColor(.white)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(100)
                .padding(.top, 16)
            }

            HStack {
                HStack(spacing: -10) {
                    Image(.round1)
                        .resizable()
                        .frame(width: 80, height: 80)
                    Image(.round2)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .overlay {
                            ZStack {
                                Circle()
                                    .fill(.white)
                                    .opacity(0.6)
                                Text("+3")
                                    .font(.title)
                            }
                        }
                }
                .padding(.top, -40)

                Spacer()

                Image(.voice)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.top, -70)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    ProfileView()
}
