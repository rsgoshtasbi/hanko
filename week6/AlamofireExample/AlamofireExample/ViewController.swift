//
//  ViewController.swift
//  AlamofireExample
//
//  Created by Rashid Goshtasbi on 6/12/21.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    let fetchUserLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .blue
        label.numberOfLines = 0
        label.text = "Tap On Fetch User Button"
        return label
    }()
    
    let fetchUserButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Fetch User", for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(fetchUserButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setUpUI()
    }
    
    private func setUpUI() {
        stackView.addArrangedSubview(fetchUserLabel)
        stackView.addArrangedSubview(fetchUserButton)

        NSLayoutConstraint.activate([
            fetchUserButton.widthAnchor.constraint(equalToConstant: 150),
            fetchUserButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
    }

    @objc func fetchUserButtonPressed() {
        print("fetch user button pressed")
        
        fetchUser { user, error in
            if let error = error {
                print("ERROR!: \(error)")
            }
            
            DispatchQueue.main.async {
                if let user = user {
                    self.fetchUserLabel.text = user.fullName + " : " + String(user.id)
                } else {
                    self.fetchUserLabel.text = "No User Fetched"
                }
            }
        }
    }
    
    private func fetchUser(completion: @escaping (User?, Error?) -> Void) {
        AF.request("https://jsonplaceholder.typicode.com/users", method: .get).responseDecodable(of: [User].self) { response in
            if let error = response.error {
                completion(nil, error)
                print(error.localizedDescription)
            }
            
            let firstUser = response.value?.first
            completion(firstUser, nil)
            
            print("First User: \(String(describing: firstUser))")
            print("Response: \(response)")
        }
    }

}
