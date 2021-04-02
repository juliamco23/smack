//
//  UserDataService.swift
//  smack
//
//  Created by Juliam Costa on 01/04/2021.
//

import Foundation

class UserDataService {
    
    static let instance = UserDataService()
    
    public private(set) var id = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    public private(set) var avatarColor = ""
    
    func setUserData(id: String, avatarName: String, email: String, name: String, color: String) {
        self.id = id
        self.avatarName = avatarName
        self.email = email
        self.name = name
        self.avatarColor = color
    }
    
    func setAvatarname(avatarName: String) {
        self.avatarName = avatarName
    }
}
