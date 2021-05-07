//
//  ViewController.swift
//  Cafe App
//
//  Created by Hannie Kim on 2/12/21.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK: - Properties
    
    let coffeeCupImageView = UIImageView()
    let welcomeLabel = UILabel()
    let menuButton = UIButton()
    let stackView = UIStackView()
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar for this view controller
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Allow other view controllers in the navigation stack to display a navigation bar
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: - UI Setup
    
    func setUpUI() {
        view.backgroundColor = UIColor(named: "CreamColor")
        navigationController?.navigationBar.prefersLargeTitles = true
        setUpStackView()
        setUpWelcomeLabel()
        setUpCoffeeCupImageView()
        setUpMenuButton()
    }
    
    func setUpStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 30
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setUpCoffeeCupImageView() {
        
        coffeeCupImageView.translatesAutoresizingMaskIntoConstraints = false
        coffeeCupImageView.image = UIImage(named: "coffeeCup")
        coffeeCupImageView.contentMode = .scaleAspectFit
        
        stackView.addArrangedSubview(coffeeCupImageView)
        
        let coffeeCupImageViewConstraints: [NSLayoutConstraint] = [
            coffeeCupImageView.widthAnchor.constraint(equalToConstant: 150),
            coffeeCupImageView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        NSLayoutConstraint.activate(coffeeCupImageViewConstraints)
    }
    
    func setUpWelcomeLabel() {
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.attributedText = NSAttributedString(
            string: "Welcome to Rashid's Cafe",
            attributes: [NSAttributedString.Key.font : UIFont(name: "SourceSansPro-Bold", size: 32) ?? UIFont.systemFont(ofSize: 32, weight: .bold)]
        )
        welcomeLabel.textAlignment = .center
        
        stackView.addArrangedSubview(welcomeLabel)
    }
    
    func setUpMenuButton() {
        
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.layer.cornerRadius = 20
        menuButton.backgroundColor = UIColor(named: "TaupeColor")
        menuButton.setTitle("Show Menu", for: .normal)
        
        stackView.addArrangedSubview(menuButton)
        
        let menuButtonConstraints: [NSLayoutConstraint] = [
            menuButton.widthAnchor.constraint(equalToConstant: 120),
            menuButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(menuButtonConstraints)
        
        menuButton.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc func menuButtonPressed() {
        navigationController?.pushViewController(MenuViewController(), animated: true)
    }
}

