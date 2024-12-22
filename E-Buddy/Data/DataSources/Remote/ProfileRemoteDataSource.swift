//
//  ProfileRemoteDataSource.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 22/12/2024.
//

import Combine
import FirebaseFirestore
import FirebaseStorage
import Foundation

protocol ProfileRemoteDataSource {
    func getUsers() -> AnyPublisher<[User], Error>
    func uploadAvatar(image: UIImage) -> AnyPublisher<Bool, Error>
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

    func uploadAvatar(image: UIImage) -> AnyPublisher<Bool, any Error> {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            print("Failed to convert image to data.")
            return Just(false).setFailureType(to: Error.self).eraseToAnyPublisher()
        }

        // Start a background task
        var backgroundTask: UIBackgroundTaskIdentifier = .invalid
        backgroundTask = UIApplication.shared.beginBackgroundTask {
            // End the background task if the system requires it
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }

        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("images/\(UUID().uuidString).jpg") // Unique filename
        var successUpload = false

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        imageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                print("Log Error: \(error)")
                UIApplication.shared.endBackgroundTask(backgroundTask) // End the task
                return
            }

            // Get the download URL
            imageRef.downloadURL { url, error in
                if let error = error {
                    successUpload = false
                    print("Log Error: \(error)")
                } else if let url = url {
                    //                        completion(.success(url.absoluteString)) // Pass the URL back
                    print("Log Info: \(url)")
                    successUpload = true
                }
                UIApplication.shared.endBackgroundTask(backgroundTask) // End the task
            }
        }

        return Just(successUpload).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
