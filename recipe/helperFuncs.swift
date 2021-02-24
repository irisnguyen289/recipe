//
//  helperFuncs.swift
//  recipe
//
//  Created by mac on 2/23/21.
//

import Foundation
import SwiftUI

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
