//
//  AuthService.swift
//  smack
//
//  Created by Juliam Costa on 29/03/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
    
        let lowerCaseEmail = email.lowercased()
        
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        AF.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            
            switch response.result {
            case let .success(value):
                print(value)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
    
        let lowerCaseEmail = email.lowercased()
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        AF.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
        
            switch response.result {
                  case .success(let result):
                    if let json = result as? Dictionary<String, Any> {
                        if let email = json["user"] as? String {
                            self.userEmail = email
                        }
                        if let token = json["token"] as? String {
                            self.authToken = token
                        }
                    }
                    self.isLoggedIn = true
                    completion(true)
                  case .failure(let error):
                    completion(false)
                    debugPrint(error)
                     
                    }
            
            switch response.result {
            case let .success(value):
                print(value)
            case let .failure(error):
                print(error)
            }
        }
    }

    func createUser(name: String, email: String, avatarName: String, avatarcolor: String, completion: @escaping CompletionHandler) {
            
            let lowerCaseEmail = email.lowercased()
            
            let body: [String: Any] = [
                "name": name,
                "email": lowerCaseEmail,
                "avatarName": avatarName,
                "avatarColor": avatarcolor
        ]
        let header: HTTPHeaders = [
            "Authorization": "Bearer\(AuthService.instance.authToken)",
            "Content-Type": "application/json; charset=utf-8"
        ]
            
        AF.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            switch response.result {
                    case .success(let result):
                        if result is Data {
                          guard let data = response.data else { return }
                          do {
                              let json = try JSON(data: data)
                              let id = json["_id"].stringValue
                              let name = json["name"].stringValue
                              let avatarName = json["avatarName"].stringValue
                              let email = json["email"].stringValue
                              let color = json["avatarColor"].stringValue
                            
                            UserDataService.instance.setUserData(id: id, avatarName: avatarName, email: email, name: name, color: color)
                              completion(true)
                              print("name")
                          } catch {
                              print(error)
                              completion(false)
                          }
                      }

            case .failure( _):
                          completion(false)
                          debugPrint(response.result as Any)
                         }
            }
    }
}
    
//AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarcolor: self.avatarColor) { (success) in
