//
//  CameraPhotoPicker.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 22/12/2024.
//

import SwiftUI
import UIKit

struct CameraPhotoPicker: UIViewControllerRepresentable {
    @Binding var image: UIImage? // Binding to hold the captured image
    @Environment(\.presentationMode) var presentationMode // Environment to dismiss the picker

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // No updates needed for this case
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraPhotoPicker

        init(_ parent: CameraPhotoPicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.image = selectedImage // Set the captured image
            }
            parent.presentationMode.wrappedValue.dismiss() // Dismiss the picker
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss() // Dismiss the picker
        }
    }
}
