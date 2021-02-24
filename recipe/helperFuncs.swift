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
            "last_login_username": currentUser.username,
            "last_login_password": currentUser.password
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

