//
//  JobViewController.swift
//  GroceryStoreEmployeePortal
//
//  Created by Rashid Goshtasbi on 6/1/21.
//

import UIKit

class JobViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = department.title
        titleLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return titleLabel
    }()
    
    lazy var taskLabel: UILabel = {
       let taskLabel = UILabel()
        taskLabel.translatesAutoresizingMaskIntoConstraints = false
        taskLabel.text = "Daily Task: \(department.taskDescription)"
        taskLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return taskLabel
    }()
    
    lazy var jobImageView: UIImageView = {
       let jobImageView = UIImageView()
        jobImageView.translatesAutoresizingMaskIntoConstraints = false
        jobImageView.contentMode = .scaleAspectFit
        
        let jobImage = department.taskImage?.withRenderingMode(.alwaysTemplate)
        jobImageView.image = jobImage
        jobImageView.tintColor = .black
        
        return jobImageView
    }()
    
    var startTaskButton: UIButton = {
        let startTaskButton = UIButton()
        startTaskButton.translatesAutoresizingMaskIntoConstraints = false
        startTaskButton.setTitle("Start Task", for: .normal)
        startTaskButton.backgroundColor = .blue
        startTaskButton.layer.cornerRadius = 20
        startTaskButton.addTarget(self, action: #selector(startTaskButtonPressed), for: .touchUpInside)
        
        return startTaskButton
    }()
    
    let department: Department
    
    weak var delegate: GroceryStoreWorkable?
    
    init(department: Department, delegate: GroceryStoreWorkable) {
        self.department = department
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        switch department {
        case .bakery:
            navigationController?.popViewController(animated: true)
            delegate?.bakeCake()
        case .produce:
            navigationController?.popViewController(animated: true)
            delegate?.inspectFruitForFreshness()
        }
    }
}
