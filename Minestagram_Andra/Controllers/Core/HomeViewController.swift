//
//  ViewController.swift
//  Minestagram_Andra
//
//  Created by Andra Metrina on 30/05/2021.
//
import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
       
        
       
        
       
    }
    
   /* private func addPhoto(){
        let addPhoto = PhotoViewController()
        addPhoto.modalPresentationStyle = .fullScreen
        self.present(addPhoto, animated: false)
    }*/
    
    //Autentifikācijas statusa pārbaude
    private func handleNotAuthenticated(){
        if Auth.auth().currentUser == nil {
            //Login
            let login = LoginViewController()
            login.modalPresentationStyle = .fullScreen
            self.present(login, animated: false)
        }else{
            //addPhoto()
        }
    
}


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView:UITableView) -> Int
    {
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.identifier, for: indexPath) as! FeedTableViewCell
        return cell
    }
}
