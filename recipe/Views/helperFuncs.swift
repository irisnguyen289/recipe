//
//  helperFuncs.swift
//  recipe
//
//  Created by mac on 2/23/21.
//

import Foundation
import SwiftUI
import Firebase

extension GlobalEnvironment{
    func save_UserDefaults(){
        let dataDict: [String: Any?] = [
            "last_login_user": currentUser
        ]
        
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
        }
    }
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
