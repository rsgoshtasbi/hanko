//
//  ViewController.swift
//  Pokedex
//
//  Created by Rashid Goshtasbi on 6/12/21.
//

import UIKit

class PokedexViewController: UIViewController {
    
    let titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center ?? DO WE NEED THIS THEN IF WE HAVE NSLAYOUTCONSTRAINT ACTIVATED???
        label.attributedText = NSAttributedString(
            string: "Pokedex",
            attributes: [
                NSAttributedString.Key.font : UIFont(name: "Nunito-Bold", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .bold),
                NSAttributedString.Key.foregroundColor : UIColor(named: "PokeBlue") ?? .black
            ]
        )
        return label
    }()
    
    let searchViewContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let pokemonCaughtContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        view.backgroundColor = UIColor(named: "PokeCream")
        
        setUpTitleView()
        setUpSearchView()
        setUpPokemonCaughtView()
    }
    
    private func setUpTitleView() {
        view.addSubview(titleView)
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15)
        ])
        
        titleView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleView.safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
    }
    
    private func setUpSearchView() {
        
        let searchViewController = SearchViewController()
        searchViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(searchViewController)
        searchViewContainerView.addSubview(searchViewController.view)
        searchViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            searchViewController.view.topAnchor.constraint(equalTo: searchViewContainerView.topAnchor),
            searchViewController.view.leadingAnchor.constraint(equalTo: searchViewContainerView.leadingAnchor),
            searchViewController.view.bottomAnchor.constraint(equalTo: searchViewContainerView.bottomAnchor),
            searchViewController.view.trailingAnchor.constraint(equalTo: searchViewContainerView.trailingAnchor),
        ])
        view.addSubview(searchViewContainerView)
        
        NSLayoutConstraint.activate([
            searchViewContainerView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20),
            searchViewContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchViewContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchViewContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        
        
    }
    
    private func setUpPokemonCaughtView() {
        let pokemonCaughtViewController = PokemonCaughtViewController()
        pokemonCaughtViewController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(pokemonCaughtViewController)
        pokemonCaughtContainerView.addSubview(pokemonCaughtViewController.view)
        pokemonCaughtViewController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            pokemonCaughtViewController.view.topAnchor.constraint(equalTo: pokemonCaughtContainerView.topAnchor),
            pokemonCaughtViewController.view.leadingAnchor.constraint(equalTo: pokemonCaughtContainerView.leadingAnchor),
            pokemonCaughtViewController.view.bottomAnchor.constraint(equalTo: pokemonCaughtContainerView.bottomAnchor),
            pokemonCaughtViewController.view.trailingAnchor.constraint(equalTo: pokemonCaughtContainerView.trailingAnchor)
        ])
        
        view.addSubview(pokemonCaughtContainerView)
        NSLayoutConstraint.activate([
            pokemonCaughtContainerView.topAnchor.constraint(equalTo: searchViewContainerView.bottomAnchor, constant: 20),
            pokemonCaughtContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            pokemonCaughtContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            pokemonCaughtContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
}
