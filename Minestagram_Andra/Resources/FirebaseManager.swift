//
//  DatabaseManager.swift
//  Minestagram_Andra
//
//  Created by Andra Metrina on 30/05/2021.
//

import FirebaseDatabase
import FirebaseAuth


public class AuthorisationManager{
    static let auth = AuthorisationManager()
    //Public
    
    public func registerNewUser(username:String, email: String, password: String, completion: @escaping (Bool) -> Void){
        //check username is avaliable
        //check email is avaliable
        //create acc
        //add acc to db
        DatabaseManager.shared.canCreateNewUser(with: email, username: username){
            canCreate in
            if canCreate{
                Auth.auth().createUser(withEmail: email, password: password){
                    result, error in
                    guard error == nil, result != nil
                    else{
                        // FB auth couldnt create acc
                        completion(false)
                        return
                    }
                    DatabaseManager.shared.insertNewUser(with: email, username: username){
                        inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        else{
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                // usrn or email does not exist
                completion(false)
            }
        }
    }
    
    public func loginUser(username:String?, email:String?, password:String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password){
                authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                return
            }
            completion(true)
        }
        }
    else if let username = username {
        //username login
        print(username)
        Auth.auth().signIn(withEmail: username, password: password){
            authResult, error in
            guard authResult != nil, error == nil else {
                completion(false)
            return
        }
        completion(true)
    }
    }}
    
    public func logOut(completion:(Bool) -> Void){
            do {
                try Auth.auth().signOut()
                completion(true)
                return
            } catch {
                print(error)
                completion(false)
                return
            }
        }
}


public class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    //check if usrn and email are avaliable
    public func canCreateNewUser(with email:String, username:String, completion: (Bool) -> Void){
        completion(true)
    }
    //insert
    public func insertNewUser(with email:String, username:String, completion: @escaping (Bool) -> Void){
        database.child(email.safeDatabaseEmail()).setValue(["username": username]){
            error, _ in
            if error == nil {
                completion(true)
                return
            }
            else {
                completion(false)
                return
            }
        }
    }
    
}


