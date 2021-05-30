//
//  ViewController.swift
//  Minestagram_Andra
//
//  Created by Andra Metrina on 30/05/2021.
//
import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
    }
    
    //Autentifikācijas statusa pārbaude
    private func handleNotAuthenticated(){
        if Auth.auth().currentUser == nil {
            //Login
            let login = LoginViewController()
            login.modalPresentationStyle = .fullScreen
            present(login, animated: false)
        }
    
}

}
