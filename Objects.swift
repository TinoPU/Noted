//
//  Objects.swift
//  Noted
//
//  Created by Tino Purmann on 07.06.22.
//

import Foundation


@MainActor class UserObject: ObservableObject {
    
    @Published var active_UUID  = UUID()
    @Published var active_user_email = String()
    
    let encoder = JSONEncoder()
    
    func login_attempt (user_email: String, password: String) async -> Bool {
        var hasher = Hasher()
        hasher.combine(password)
        let password_hash = Hasher().finalize()
        let packeage = loginObject(password_hash: password_hash, user_email: user_email)
        let data_send = try! encoder.encode(packeage)
        let loginurl = URL(string: "someurlforlogin")!
        var request = URLRequest(url: loginurl)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: data_send)
            let decodedData = try JSONDecoder().decode(userObject.self, from: data)
            self.active_UUID = decodedData.user_id
            self.active_user_email = decodedData.user_email
            return true
            
        }
        catch {
            print("login attempt failed")
        }
        return false
    }
    
    func password_reset (user_email: String) async -> Bool {
        
        let package = passwordresetobject(user_email: user_email)
        let data_send = try! encoder.encode(package)
        let reseturl = URL(string: "someresetlink")!
        var request = URLRequest(url: reseturl)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        do {
            
            let (data, _) = try await URLSession.shared.upload(for: request, from: data_send)
            let decodedData = try JSONDecoder().decode(userObject.self, from: data)
            return true
        }
        catch {
            print("failed")
            return false
        }
        
        
    }
    
}

struct userObject: Codable {
    var user_email : String
    var user_id : UUID
    var password_hash : String
}

struct noteObject: Codable {
    var associated_UUID : UUID
    var notetitle : String
    var note_categories : [String]
    var note_tags : [String]
    var note_text : String
    
}

struct loginObject: Codable {
    var password_hash : Int
    var user_email: String
}

struct passwordresetobject : Codable {
    var user_email: String
}


class savednotes: ObservableObject {
    
    @Published var savednotes = [savednote]()
}


struct savednote: Codable {
    var saved_title : String
    var saved_categories : [String]
    var saved_tags : [String]
    var saved_value : Int
    var saved_date : Date
    var saved_text : String
}
