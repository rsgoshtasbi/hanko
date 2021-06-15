//
//  WordDetailsViewController.swift
//  Daily Dose of Definitions
//
//  Created by Rashid Goshtasbi on 6/11/21.
//

import UIKit

class WordDetailsViewController: UIViewController {
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "DDDRed")
        return view
    }()
    
    lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = UIColor(named: "DDDBlue")
        label.text = word.uppercased()
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 20
        return stackView
    }()
    
    let definitionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    let definitionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Definition"
        label.textColor = UIColor(named: "DDDBlue")
        return label
    }()
    
    let synonymStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    let synonymTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Synonym"
        label.textColor = UIColor(named: "DDDBlue")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let antonymStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    let antonymTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Antonym"
        label.textColor = UIColor(named: "DDDBlue")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let exampleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    let examplesTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Examples"
        label.textColor = UIColor(named: "DDDBlue")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    let word: String
    let wordResult: WordResult
    
    init(word: String, wordResult: WordResult) {
        self.word = word
        self.wordResult = wordResult
        
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
        
        setUpHeader()
        setUpStackViewContainer()
        setUpDefinitionStackView()        
        setUpSynonymStackView()
        setUpAntonymStackView()
        setUpExamplesStackView()
        addEmptyView()
    }
    
    
    private func setUpHeader() {
        view.addSubview(headerView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
        ])
        
        headerView.addSubview(headerTitle)
        
        NSLayoutConstraint.activate([
            headerTitle.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20)
        ])
    }
    
    private func setUpStackViewContainer() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setUpDefinitionStackView() {
        definitionStackView.distribution = .fill
        
        definitionStackView.addArrangedSubview(definitionTitleLabel)
        
        NSLayoutConstraint.activate([
            definitionTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let definitionDescriptionLabel = UILabel()
        definitionDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        definitionDescriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        definitionDescriptionLabel.text = wordResult.definition
        definitionDescriptionLabel.numberOfLines = 0
        definitionDescriptionLabel.lineBreakMode = .byWordWrapping
        definitionDescriptionLabel.textColor = UIColor(named: "DDDBlue")

        definitionStackView.addArrangedSubview(definitionDescriptionLabel)
        
        stackView.addArrangedSubview(definitionStackView)
    }
    
    private func setUpSynonymStackView() {
        guard let synonyms = wordResult.synonyms, !synonyms.isEmpty else {
            return
        }
        
        synonymStackView.addArrangedSubview(synonymTitleLabel)
        
        NSLayoutConstraint.activate([
            synonymTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        for synonym in synonyms {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            label.text = synonym
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.textColor = UIColor(named: "DDDBlue")
            
            synonymStackView.addArrangedSubview(label)
        }
        
        stackView.addArrangedSubview(synonymStackView)
    }
    
    private func setUpAntonymStackView() {
        guard let antonyms = wordResult.antonyms, !antonyms.isEmpty else {
            return
        }

        antonymStackView.addArrangedSubview(antonymTitleLabel)
        
        NSLayoutConstraint.activate([
            antonymTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        for antonym in antonyms {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            label.text = antonym
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.textColor = UIColor(named: "DDDBlue")
            
            antonymStackView.addArrangedSubview(label)
        }
        
        stackView.addArrangedSubview(antonymStackView)
    }
    
    private func setUpExamplesStackView() {
        guard let examples = wordResult.examples, !examples.isEmpty else {
            return
        }

        exampleStackView.addArrangedSubview(examplesTitleLabel)
        
        NSLayoutConstraint.activate([
            examplesTitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        for example in examples {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
            label.text = example
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.textColor = UIColor(named: "DDDBlue")
            
            exampleStackView.addArrangedSubview(label)
        }
        
        stackView.addArrangedSubview(exampleStackView)
    }
    
    private func addEmptyView() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(view)
    }
}
