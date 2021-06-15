//
//  HomeViewController.swift
//  Daily Dose of Definitions
//
//  Created by Rashid Goshtasbi on 6/7/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "DDDRed")
        return view
    }()
    
    let headerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.attributedText = NSAttributedString(
            string: "Daily Dose \nof Definitions",
            attributes: [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 32, weight: .bold),
                NSAttributedString.Key.foregroundColor : UIColor(named: "DDDBlue") ?? .black
            ]
        )
        return label
    }()
    
    let randomWordView: RandomWordView = {
        let randomWordView = RandomWordView()
        randomWordView.translatesAutoresizingMaskIntoConstraints = false
        randomWordView.refreshButton.addTarget(self, action: #selector(rafreshButtonPressed), for: .touchUpInside)
        return randomWordView
    }()
    
    let definitionsSearchContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setUpUI()
    }

    private func setUpUI() {
        setUpHeader()
        setUpRandomWordView()
        setUpDefinitionsSearchContainerView()
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
            headerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20)
                
        ])
    }
    
    private func setUpRandomWordView() {
        view.addSubview(randomWordView)
        
        NSLayoutConstraint.activate([
            randomWordView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            randomWordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            randomWordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            randomWordView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.20)
            
        ])
    }
    
    private func setUpDefinitionsSearchContainerView() {
        let definitionSearchViewController = DefinitionSearchViewController()
        definitionSearchViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(definitionSearchViewController)
        definitionsSearchContainerView.addSubview(definitionSearchViewController.view)
        definitionSearchViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            definitionSearchViewController.view.topAnchor.constraint(equalTo: definitionsSearchContainerView.topAnchor),
            definitionSearchViewController.view.leadingAnchor.constraint(equalTo: definitionsSearchContainerView.leadingAnchor),
            definitionSearchViewController.view.bottomAnchor.constraint(equalTo: definitionsSearchContainerView.bottomAnchor),
            definitionSearchViewController.view.trailingAnchor.constraint(equalTo: definitionsSearchContainerView.trailingAnchor),
        ])
        
        view.addSubview(definitionsSearchContainerView)
        
        NSLayoutConstraint.activate([
            definitionsSearchContainerView.topAnchor.constraint(equalTo: randomWordView.bottomAnchor, constant: 20),
            definitionsSearchContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            definitionsSearchContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            definitionsSearchContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func rafreshButtonPressed() {
        print("Refresh button pressed")
        fetchRandomWordResponse { wordDetails, error in
            if let error = error {
                print("fetch random word error: \(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.randomWordView.addTextToLabels(usingWordDetails: wordDetails)
            }
            
        }
    }
    
    private func fetchRandomWordResponse(completion: @escaping (WordDetails?, Error?) -> Void) {
        guard let randomWordDataURL = URL(string: "https://wordsapiv1.p.rapidapi.com/words/?random=true&hasDetails=definitions") else {
            print("expected random words api url broke")
            return
        }
        
        let headers =  [
            "x-rapidapi-key": "ba67dd619cmsh7c7ff22502748c0p1309bejsnbce67ca677f4",
            "x-rapidapi-host": "wordsapiv1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: randomWordDataURL)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, urlResponse, error in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            do {
                let randomWordDetails = try JSONDecoder().decode(WordDetails.self, from: data)
                completion(randomWordDetails, nil)
                print(randomWordDetails.word)
                print(randomWordDetails.results?.first?.definition)
            } catch {
                print("failed to decode word details with error: \(error.localizedDescription)")
                completion(nil, error)
            }
        }.resume()
    }
}
