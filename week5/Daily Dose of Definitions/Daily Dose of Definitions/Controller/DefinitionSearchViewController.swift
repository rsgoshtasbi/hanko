//
//  DefinitionSearchViewController.swift
//  Daily Dose of Definitions
//
//  Created by Rashid Goshtasbi on 6/8/21.
//

import UIKit

class DefinitionSearchViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "DDDBlue")
        label.text = "Search for Definitions"
        return label
    }()
    
    let wordSearchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter a Word"
        textField.backgroundColor = .white
        return textField
    }()
    
    let goButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("GO", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "DDDBlue")
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(goButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DefinitionTableViewCell.self, forCellReuseIdentifier: "definitionCell")
        return tableView
    }()

    var selectedWordResults: [WordResult]?
    var selectedWord: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    private func setUpUI() {
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        
        view.backgroundColor = UIColor(named: "DDDAlabaster")
        
        setUpTitleLabel()
        setUpStackView()
        setUpTableView()
    }
    
    private func setUpTitleLabel() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
        ])
    }
    
    private func setUpStackView() {
        stackView.addArrangedSubview(wordSearchTextField)
        stackView.addArrangedSubview(goButton)
        
        NSLayoutConstraint.activate([
            goButton.heightAnchor.constraint(equalToConstant: 50),
            goButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    private func setUpTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    
    @objc func goButtonPressed() {
        guard let textFieldText = wordSearchTextField.text, !textFieldText.isEmpty else {
            let alert = UIAlertController(title: "", message: "Please enter a word and we'll get the definition for you", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        fetchWordDetails(forWord: textFieldText) { wordDetails, error in
            if let error = error {
                print("fetch word error: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                let resultsWithDefinitions = wordDetails?.results?.filter {
                    $0.definition != nil
                }
                self.selectedWordResults = resultsWithDefinitions
                self.selectedWord = wordDetails?.word
                
                self.tableView.reloadData()
            }
        }
    }
    
    private func fetchWordDetails(forWord word: String, completion: @escaping (WordDetails?, Error?) -> Void) {
        guard let fetchWordDataURL = URL(string: "https://wordsapiv1.p.rapidapi.com/words/\(word)") else {
            print("expected get word api url broke")
            return
        }
        
        let headers =  [
            "x-rapidapi-key": "ba67dd619cmsh7c7ff22502748c0p1309bejsnbce67ca677f4",
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: fetchWordDataURL)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            do {
                let wordDetails = try JSONDecoder().decode(WordDetails.self, from: data)
                completion(wordDetails, nil)
                print(wordDetails.word)
                print(wordDetails.results?.first?.definition)
            } catch {
                print("failed to decode word details with error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }.resume()

        
    }
}

extension DefinitionSearchViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedWordResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "definitionCell", for: indexPath)
                as? DefinitionTableViewCell,
              let selectedWordResult = selectedWordResults?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.loadWordDetail(selectedWordResult)
        
        return cell
    }
    
    // when we tap on a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedWord = selectedWord,
              let selectedWordResult = selectedWordResults?[indexPath.row] else {
            return
        }
        
        present(WordDetailsViewController(word: selectedWord, wordResult: selectedWordResult), animated: true, completion: nil)
    }
}
