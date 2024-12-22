//
//  ProfileRemoteDataSource.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 22/12/2024.
//

import Combine
import FirebaseFirestore
import Foundation

protocol ProfileRemoteDataSource {
    func getUsers() -> AnyPublisher<[User], Error>
}

struct DefaultProfileRemoteDataSource: ProfileRemoteDataSource {

    func getUsers() -> AnyPublisher<[User], Error> {
        Future { promise in
            // Initialize Firestore
            let db = Firestore.firestore()
            let usersCollectionRef = db.collection("USERS")

            // Fetch all documents in the collection
            usersCollectionRef.getDocuments { snapshot, error in
                if let error = error {
                    // Pass the error to the promise
                    promise(.failure(error))
                } else {
                    var users: [User] = []
                    
                    // Parse documents into User objects
                    if let documents = snapshot?.documents {
                        users = documents.compactMap { document in
                            let userId = document.documentID
                            let userPhone = document.get("phoneNumber") as? String ?? ""
                            let userEmail = document.get("email") as? String ?? ""
                            let userGender = document.get("gender") as? Int ?? 0
                            return User(uid: userId, email: userEmail, phoneNumber: userPhone, gender: userGender)
                        }
                    }

                    // Pass the result to the promise
                    promise(.success(users))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
