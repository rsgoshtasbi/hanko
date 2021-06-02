//
//  JobViewController.swift
//  GroceryStoreEmployeePortal
//
//  Created by Rashid Goshtasbi on 6/1/21.
//

import UIKit

class JobViewController: UIViewController {
    
    let titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Department.bakery.title
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return titleLabel
    }()
    
    let taskLabel: UILabel = {
       let taskLabel = UILabel()
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.text = Department.bakery.task
        taskLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return taskLabel
    }()
    
    let jobImageView: UIImageView = {
       let jobImageView = UIImageView()
        jobImageView.translatesAutoresizingMaskIntoConstraints = false
        jobImageView.contentMode = .scaleAspectFit
        
        let jobImage = UIImage(named: "cake")?.withRenderingMode(.alwaysTemplate)
        jobImageView.image = jobImage
        jobImageView.tintColor = .black
        
        return jobImageView
    }()
    
    let startTaskButton: UIButton = {
        let startTaskButton = UIButton()
        startTaskButton.translatesAutoresizingMaskIntoConstraints = false
        startTaskButton.setTitle("Start Task", for: .normal)
        startTaskButton.backgroundColor = .blue
        startTaskButton.layer.cornerRadius = 20
        startTaskButton.addTarget(self, action: #selector(startTaskButtonPressed), for: .touchUpInside)
        
        return startTaskButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = .white
        
        setUpTitleLabel()
        setUpTaskLabel()
        setUpImageView()
        setUpButton()
    }
    
    private func setUpTitleLabel() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpTaskLabel() {
        view.addSubview(taskLabel)
        NSLayoutConstraint.activate([
            taskLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            taskLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setUpImageView() {
        view.addSubview(jobImageView)
        
        NSLayoutConstraint.activate([
            jobImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            jobImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setUpButton() {
        view.addSubview(startTaskButton)
        
        NSLayoutConstraint.activate([
            startTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  35),
            startTaskButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            startTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            startTaskButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func startTaskButtonPressed() {
        print("task button pressed")
    }
}
