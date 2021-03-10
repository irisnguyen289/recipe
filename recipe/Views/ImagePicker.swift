//
//  ImagePicker.swift
//  recipe
//
//  Created by mac on 2/24/21.
//

import Foundation
import SwiftUI


//-------------- imagePicker - UIViewControllerRepresentable ------
struct imagePicker: UIViewControllerRepresentable{
    @Binding var images: [Identifiable_UIImage]
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = imagePickerCoordinator
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<imagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func makeCoordinator() -> imagePickerCoordinator {
        return imagePickerCoordinator(images: $images)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<imagePicker>) {
        
    }
}

//-------------- imagePicker - Coordinator ---------------
class imagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @Binding var images: [Identifiable_UIImage]
    
    init(images: Binding<[Identifiable_UIImage]>){
        _images = images
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            images.append(Identifiable_UIImage(image: uiImage))
        }
    }
}
