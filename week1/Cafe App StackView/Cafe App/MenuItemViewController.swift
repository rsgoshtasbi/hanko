//
//  MenuItemViewController.swift
//  Cafe App
//
//  Created by Rashid Goshtasbi on 5/6/21.
//

import UIKit

class MenuItemViewController: UIViewController {
    
    // MARK: - Properties
    
    let stackView = UIStackView()
    let nameLabel = UILabel()
    let imageView = ShadowImageView(frame: .zero) // HELP why do we pass zero, the documentation does make sense?
    
    let menuItem: MenuItem
    
    
    // MARK: - Inits
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    //MARK: - UI Setup
    func setUpUI() {
        view.backgroundColor = UIColor(named: "CreamColor")
        setUpStackView()
        setUpNameLabel()
        setUpImageView()
    }
    
    func setUpStackView() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        
        view.addSubview(stackView)
        
        let stackViewConstraints: [NSLayoutConstraint] = [
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    
    func setUpNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = .center
        nameLabel.attributedText = NSAttributedString(
            string: menuItem.name,
            attributes: [NSAttributedString.Key.font : UIFont(name: "SourceSansPro-Bold", size: 40) ?? UIFont.systemFont(ofSize: 40, weight: .bold)]
        )
        
        stackView.addArrangedSubview(nameLabel)
        
    }
    
    func setUpImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = menuItem.image
        imageView.contentMode = .scaleAspectFit
        
        stackView.addArrangedSubview(imageView)
        
        let imageViewConstraint: [NSLayoutConstraint] = [
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(imageViewConstraint)
    }
}
