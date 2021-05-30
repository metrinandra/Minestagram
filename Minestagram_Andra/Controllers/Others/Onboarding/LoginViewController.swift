//
//  LoginViewController.swift
//  Minestagram_Andra
//
//  Created by Andra Metrina on 30/05/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let usernameEmailField: UITextField = {
        return UITextField()
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        //aizklāt psw ar simboliem
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginBtn: UIButton = {
        return UIButton()
    }()
    
    private let createAccBtn: UIButton = {
        return UIButton()
    }()
    
    private let headerView:UIView = {
        return UIView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        view.backgroundColor = .systemOrange
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Fix design
    }
    
    private func addSubViews(){
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginBtn)
        view.addSubview(createAccBtn)
        view.addSubview(headerView)
    }
    
    @objc private func loginPressed(){}
    @objc private func createAccPressed(){}

}
