//
//  RegistrationViewController.swift
//  Minestagram_Andra
//
//  Created by Andra Metrina on 30/05/2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    struct Constants {
        static let cornerRadius:CGFloat = 8.0
        static let bcgColor:UIColor = .white
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.bcgColor
        registerBtn.addTarget(self, action: #selector(registerBtnPressed), for: .touchUpInside)
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerBtn)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        usernameField.frame = CGRect(x:20, y: view.safeAreaInsets.top + 90, width: view.width - 40, height:52.0)
        emailField.frame = CGRect(x:20, y: usernameField.bottom + 10, width: view.width - 40, height:52.0)
        passwordField.frame = CGRect(x:20, y: emailField.bottom + 10, width: view.width - 40, height:52.0)
        registerBtn.frame = CGRect(x:20, y: passwordField.bottom + 10, width: view.width - 40, height:52.0)
    }
    
    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.backgroundColor = Constants.bcgColor
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0,y:0,width: 10,height: 10))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.backgroundColor = Constants.bcgColor
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0,y:0,width: 10,height: 10))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        //aizklāt psw ar simboliem
        field.isSecureTextEntry = true
        field.backgroundColor = Constants.bcgColor
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x:0,y:0,width: 10,height: 10))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        return field
    }()
    
    private let registerBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Create an account", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemOrange
        return button
    }()
    
    @objc private func registerBtnPressed(){
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8,
        let username = usernameField.text, !username.isEmpty else {
            return
        }
        
        AuthorisationManager.auth.registerNewUser(username: username, email: email, password: password) {
            registered in
            DispatchQueue.main.async {
                if registered{
                    //all set
                }else {
                    //error
                }
            }
        }
    }
    
}

extension RegistrationViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else {
            registerBtnPressed()
        }
        return true
        }
    
}
