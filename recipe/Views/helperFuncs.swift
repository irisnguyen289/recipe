//
//  helperFuncs.swift
//  recipe
//
//  Created by mac on 2/23/21.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseStorage

extension GlobalEnvironment{
    func save_UserDefaults(){
        let dataDict: [String: Any?] = [
            "last_login_user": currentUser
        ]
        print("\(self.currentUser)")
        
        let save_UserDefaults = UserDefaults.standard
        
        do{
            let sessionData = try NSKeyedArchiver.archivedData(withRootObject: dataDict, requiringSecureCoding: false)
            save_UserDefaults.set(sessionData,forKey: "lastLogin_User")
            print("Saved successfully")
        }
        catch{
            print("Coudn't read file")
        }
    }
    
    func initializeListener_currentUser(){
        Firestore.firestore().document("users/\(self.currentUser.establishedID)").addSnapshotListener { querySnapshot, error in
            guard let document = querySnapshot else {
                print("Error fetching documents: \(error!)")
                return
            }
            
            print("new info found with listener")
            if let data = document.data() { // Set user
                print("\(document.documentID) => \(data)")
                
                self.currentUser = User.init(
                    username: data["username"] as? String ?? "",
                    password: data["password"] as? String ?? "",
                    name: data["name"] as? String ?? "",
                    email: data["email"] as? String ?? "",
                    publishedRecipes: data["publishedRecipes"] as? [String] ?? [],
                    document.documentID
                )
                
               self.save_UserDefaults()
            }
        }
    }
}

extension UIApplication{
    func endEditting(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Double{
    var stringWithoutZeroFraction: String{
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
}

func fraction_progress(lowerLimit: Double = 0, upperLimit: Double, current: Double, inverted: Bool = false) -> Double {
    var val: Double = 0
    
    if current >= upperLimit {
        val = 1
    }
    else if current <= lowerLimit {
        val = 0
    }
    else {
        val = (current - lowerLimit) / (upperLimit - lowerLimit)
    }
    
    if inverted {
        return (1 - val)
    }
    else {
        return val
    }
}

func convertStringToDouble(_ string: String) -> Double? {
    let val: Double? = Double(string) ?? nil
    
    if let val = val{
        return val
    }
    else {
        return nil
    }
}

enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case  .dragging:
            return true
        }
    }
}

func firebaseSubmit(docRef_string: String, data: [String: Any], completion: @escaping (Any) -> Void, showDetails: Bool = false) {
    let docRef = Firestore.firestore().document(docRef_string)
    
    print("setting data")
    docRef.setData(data) { (error) in
        if let error =  error {
            print("Error: \(error)")
            completion(error)
        }
        else{
            print("successfully uploaded data")
            if showDetails {
                print("data uploaded = \(data)")
            }
            completion(true)
        }
    }
}

func firebaseUpdate(docRef_string: String, dataToUpdate: [String: Any], completion: @escaping (Any) -> Void, showDetails: Bool = false) {
    let docRef = Firestore.firestore().document(docRef_string)
    
    print("updating data")
    docRef.setData(dataToUpdate, merge: true) { (error) in
        if let error =  error {
            print("Error: \(error)")
            completion(error)
        }
        else{
            print("successfully updated data")
            if showDetails {
                print("data uploaded = \(dataToUpdate)")
            }
            completion(true)
        }
    }
}

func firebaseGet(docRef_string: String, completion: @escaping (Any) -> Void, showDetails: Bool = false) {
    let docRef = Firestore.firestore().document(docRef_string)
    
    print("getting data")
    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
            print("Document data: \(dataDescription)")
            completion(true)
        }
            
        if let error = error {
            print("Error: \(error)")
            completion(error)
        }
    }
}

func uploadImage(_ ref: String, image: UIImage, completion: @escaping (Any) -> Void, showDetails: Bool = false) {
    if let imageData = image.jpegData(compressionQuality: 1) {
        let storage = Storage.storage()
        storage.reference().child(ref).putData(imageData, metadata: nil) { (storageMetadata, error) in
            if let error = error {
                print("an error has occur - \(error.localizedDescription)")
                completion(error)
            }
            else {
                print("image uploaded successfully")
                completion(true)
            }
        }
    }
    else {
        print("could not unwrap image as data")
    }
}

func downloadImage(_ ref: String, completion: @escaping (Any) -> Void, showDetails: Bool = false) -> UIImage {
    var image: UIImage
    let storage = Storage.storage()
    storage.reference().child(ref).getData(maxSize: 1 * 1024 * 1024) { (data, error) in
        if let error = error {
            print("an error has occur - \(error.localizedDescription)")
            completion(error)
        }
        else {
            print("image downloaded successfully")
            // Data for image is returned
            image = UIImage(data: data!)!
            completion(true)
        }
    }
    return image
}

extension Array where Element == Step {
    func formatForFirebase() -> [[String: Any]] {
        var listOfSteps: [[String: Any]] = []
        
        for element in self {
            listOfSteps.append(element.dict)
        }
        
        return listOfSteps
    }
}

extension Array where Element == Ingredient {
    func formatForFirebase() -> [[String: Any]] {
        var listOfSteps: [[String: Any]] = []
        
        for element in self {
            listOfSteps.append(element.dict)
        }
        
        return listOfSteps
    }
}
