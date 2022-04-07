//
//  PhotoPickerView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 3/8/2022.
//

import UIKit
import SwiftUI
import Photos
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {

    @Binding var selectedImage: UIImage
    @Binding var isImageSelected: Bool

    var itemProviders: [NSItemProvider] = []

    @Environment(\.presentationMode) private var presentationMode

    let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())

    //    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    func makeUIViewController(context: Context) -> PHPickerViewController {

        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController,
                                context: Context) { }

    func makeCoordinator() -> Coordinator {
        return ImagePicker.Coordinator(parent: self)
    }

    class Coordinator: PHPickerViewControllerDelegate {

        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            if !results.isEmpty {
                parent.itemProviders = []
            }

            parent.itemProviders = results.map(\.itemProvider)
            loadImage()

        }

        private func loadImage() {
            for itemProvider in parent.itemProviders {
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let image = image as? UIImage {
                            self.parent.selectedImage = image
                            self.parent.isImageSelected = true
                        } else {
                            print("Could not load image", error?.localizedDescription ?? "")
                        }
                    }
                }
            }
        }
    }

}
