//
//  LoginViewController.swift
//  Minestagram_Andra
//
//  Created by Andra Metrina on 30/05/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius:CGFloat = 8.0
        static let bcgColor:UIColor = .white
        
    }
    private let usernameEmailField: UITextField = {
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
    
    private let loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .red
        return button
    }()
    
    private let createAccBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Create an account", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .red
        return button
       
    }()
    
    private let headerView:UIView = {
        let header =  UIView()
        header.clipsToBounds = true
        let backgroundImage = UIImageView(image: UIImage(named:"Gradient"))
        header.addSubview(backgroundImage)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        createAccBtn.addTarget(self, action: #selector(createAccPressed), for: .touchUpInside)
        usernameEmailField.delegate = self
        passwordField.delegate = self
        addSubViews()
        view.backgroundColor = .systemOrange
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //Fix design
        headerView.frame = CGRect(x:0,y: view.safeAreaInsets.top, width:view.width, height:view.height/3.0)
        usernameEmailField.frame = CGRect(x:25,y: headerView.bottom + 60, width:view.width - 50, height:52.0)
        passwordField.frame = CGRect(x:25,y: usernameEmailField.bottom + 10, width:view.width - 50, height:52.0)
        loginBtn.frame = CGRect(x:25,y: passwordField.bottom + 10, width:view.width - 50, height:52.0)
        createAccBtn.frame = CGRect(x:25,y: loginBtn.bottom + 10, width:view.width - 50, height:52.0)
        configureHeaderView()
    }
    
    private func configureHeaderView(){
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        //add logo
        
        let imageView = UIImageView(image: UIImage(named: "logo"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/5.5, y:headerView.height/4.0, width:headerView.width/1.5, height: headerView.height/1.5 - view.safeAreaInsets.top)
    }
    
    private func addSubViews(){
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginBtn)
        view.addSubview(createAccBtn)
        view.addSubview(headerView)
    }
    
    @objc private func loginPressed(){
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty, let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        var username: String?
        var email: String?
        
        if usernameEmail.contains("@"), usernameEmail.contains("."){
            email  = usernameEmail
        }
        else {
            username = usernameEmail
        }
        //login func
        
        AuthorisationManager.auth.loginUser(username: username, email: email, password: password)
            { success in
            DispatchQueue.main.async {
                if success{
                    //logged in
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    //error
                    let alert = UIAlertController(title: "Log in error", message: "Something went wrong", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
           
            
        }
        
    }
    @objc private func createAccPressed(){
        let view = RegistrationViewController()
        view.title = "Create an Account"
        present(UINavigationController(rootViewController: view), animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField{
            loginPressed()
        }
        return true
    }
}
