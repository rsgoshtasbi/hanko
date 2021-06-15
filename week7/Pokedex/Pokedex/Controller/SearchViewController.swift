//
//  SearchView.swift
//  Pokedex
//
//  Created by Rashid Goshtasbi on 6/12/21.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
        
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter a word"
        textField.backgroundColor = .white
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("GO", for: .normal)
        button.backgroundColor = UIColor(named: "PokeBlue")
        button.tintColor = .white
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(goButtonPressed), for: .touchUpInside)
        return button
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSAttributedString(
            string: "Search for pokemon and bookmark those that you've caught!\nGotta catch em all!",
            attributes: [
                NSAttributedString.Key.font : UIFont(name: "Nunito-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .regular),
                NSAttributedString.Key.foregroundColor : UIColor(named: "PokeBlue") ?? .black
            ]
        )
        return label
    }()
    
    var pokemonDetailsResults: PokemonDetails?
    var pokemonResults: [Pokemon] = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpStackView()
    }

    
    private func setUpView() {
        view.backgroundColor = .clear
        view.layer.borderWidth = 2
        
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    
    private func setUpStackView() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            stackView.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor)
        ])
        
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(button)
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 50),
            button.widthAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc func goButtonPressed() {
        print("button pressed")
        
        guard let textFieldText = textField.text, !textFieldText.isEmpty else {
            let alert = UIAlertController(title: "No Text", message: "Please enter a pokemon so we can search for it", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return 
        }
        
        getData(word: textFieldText) { [weak self] pokemonDetails, error in
            guard let pokemonDetails = pokemonDetails, error == nil else {
                print("failed to fetch into, \(String(describing: error))")
                return
            }
            
            self?.getLocation(pokemonDetails: pokemonDetails) { [weak self] locationDetails, error in
                guard let locationDetails = locationDetails, error == nil else {
                    print("failed to get location: \(error?.localizedDescription)")
                    return
                }
                
                DispatchQueue.main.async {
                    let pokemon = Pokemon(name: self?.pokemonDetailsResults?.name,
                                          height: self?.pokemonDetailsResults?.height,
                                          weight: self?.pokemonDetailsResults?.weight,
                                          location: locationDetails.results?.first?.location_area?.name)
                    self?.pokemonResults.append(pokemon)
                }
            }
            
//            DispatchQueue.main.async {
//                self?.pokemonDetailsResults = pokemonDetails
//            }
        }
        
        
    }
    
    private func getData(word: String, completion: @escaping (PokemonDetails?, Error?) -> Void) {
        guard let getDataURL = URL(string: "https://pokeapi.co/api/v2/pokemon/\(word.lowercased())") else {
            print("Could not build data URL")
            return
        }
        
        AF.request(getDataURL, method: .get).responseDecodable(of: PokemonDetails.self) { response in
            guard let pokemonDetails = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            completion(pokemonDetails, response.error)
        }
        
    }
   
    private func getLocation(pokemonDetails: PokemonDetails, completion: @escaping (LocationDetails?, Error?) -> Void) {
        guard let getDataURL = URL(string: pokemonDetails.location_area_encounters!) else {
            print("Could not build location URL")
            return
        }
        
        AF.request(getDataURL, method: .get).responseDecodable(of: LocationDetails.self) { response in
            guard let locationDetails = response.value, response.error == nil else {
                completion(nil, response.error)
                return
            }
            
            completion(locationDetails, response.error)
        }
        
    }
}

struct Pokemon: Decodable {
    let name: String?
    let height: Int?
    let weight: Int?
    let location: String?
//    let sprites: Sprites?
}


struct PokemonDetails: Decodable {
    let name: String?
    let height: Int?
    let weight: Int?
    let location_area_encounters: String?
    let sprites: Sprites?
}

struct Sprites: Decodable {
    let front_default: String?
}

struct LocationDetails: Decodable {
    let results: [LocationInfo]?
}

struct LocationInfo: Decodable {
    let location_area: LocationArea?
}

struct LocationArea: Decodable {
    let name: String?
}
