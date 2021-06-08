//
//  ViewController.swift
//  GroceryStoreEmployeePortal
//
//  Created by Rashid Goshtasbi on 6/1/21.
//

import UIKit

class GroceryStoreDepartmentViewController: UIViewController {
    
    //MARK: - View Properties
    
    let topContainer: UIView = {
        let topContainer = UIView()
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        topContainer.backgroundColor = .clear
        return topContainer
    }()
    
    let bottomContainer: UIView = {
        let bottomContainer = UIView()
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.backgroundColor = .clear
        return bottomContainer
    }()
    
    
    let bakeryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Department.bakery.title
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let bakeryButton: UIButton = {
       let bakeryButton = UIButton()
        bakeryButton.translatesAutoresizingMaskIntoConstraints = false
        bakeryButton.addTarget(self, action: #selector(bakeryButtonPressed), for: .touchUpInside)
        
        let breadImage = Department.bakery.image?.withRenderingMode(.alwaysTemplate)
        bakeryButton.setImage(breadImage, for: .normal)
        bakeryButton.tintColor = .brown
        
        return bakeryButton
    }()
    
    let produceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Department.produce.title
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let produceButton: UIButton = {
       let bakeryButton = UIButton()
        bakeryButton.translatesAutoresizingMaskIntoConstraints = false
        bakeryButton.addTarget(self, action: #selector(produceButtonPressed), for: .touchUpInside)
        
        let breadImage = Department.produce.image?.withRenderingMode(.alwaysTemplate)
        bakeryButton.setImage(breadImage, for: .normal)
        bakeryButton.tintColor = .red
        
        return bakeryButton
    }()
    
    
    //MARK: - Lifecycle setups

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
    }
    //MARK: - UI Setup
    private func setUpUI() {
        view.backgroundColor = .white
        setUpNavigationBar()
        setUpTopContainer()
        setUpBottomContainer()
        setUpBakeryLabel()
        setUpBakeryButton()
        setUpProduceLabel()
        setUpProduceButton()
    }
    
    private func setUpNavigationBar() {
        navigationItem.title = "Select Your Department"
        navigationController?.navigationBar.backgroundColor = .blue
    }
    
    private func setUpTopContainer() {
        view.addSubview(topContainer)
        
        NSLayoutConstraint.activate([
            topContainer.topAnchor.constraint(equalTo: view.topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func setUpBottomContainer() {
        view.addSubview(bottomContainer)
        
        NSLayoutConstraint.activate([
            bottomContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setUpBakeryLabel() {
        topContainer.addSubview(bakeryLabel)
        NSLayoutConstraint.activate([
            bakeryLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor)
        ])
    }
    
    private func setUpBakeryButton() {
        topContainer.addSubview(bakeryButton)
        
        NSLayoutConstraint.activate([
            bakeryButton.topAnchor.constraint(equalTo: bakeryLabel.bottomAnchor, constant: 15),
            bakeryButton.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor),
            bakeryButton.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -30)
        ])
    }
    
    private func setUpProduceLabel() {
        bottomContainer.addSubview(produceLabel)
        NSLayoutConstraint.activate([
            produceLabel.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
            produceLabel.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 30)
        ])
    }
    
    private func setUpProduceButton() {
        bottomContainer.addSubview(produceButton)
        
        NSLayoutConstraint.activate([
            produceButton.topAnchor.constraint(equalTo: produceLabel.bottomAnchor, constant: 15),
            produceButton.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
            
        ])
    }
    
    // MARK: - Actions
    @objc func bakeryButtonPressed() {
        navigationController?.pushViewController(JobViewController(department: .bakery, delegate: self), animated: true)
    }
    
    @objc func produceButtonPressed() {
        navigationController?.pushViewController(JobViewController(department: .produce, delegate: self), animated: true)
        
    }

}


// MARK: - Grocery Store Workable Methods
extension GroceryStoreDepartmentViewController: GroceryStoreWorkable {
    func bakeCake() {
        print("started to bake a cake")
        
        let alertController = UIAlertController(title: "Bakery Department Task", message: "You have started baking a cake. You can go home once you've finished", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func inspectFruitForFreshness() {
        print("started to inspect fruit for freshness")
        
        let alertController = UIAlertController(title: "Produce Department Task", message: "You have started inspecting the fruit for freshness. You can go home once you've finished", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
