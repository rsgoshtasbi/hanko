//
//  MenuViewController.swift
//  Cafe App
//
//  Created by Rashid Goshtasbi on 5/5/21.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    let menuTableView = UITableView()
    var menu: Menu? {
        guard let espressoImage = UIImage(named: "espresso"),
              let icedCoffeeImage = UIImage(named: "icedCoffee"),
              let macaronImage = UIImage(named: "macaron"),
              let matchaLatteImage = UIImage(named: "matcha"),
              let mochaLatteImage = UIImage(named: "latte"),
              let donutImage = UIImage(named: "donut"),
              let pourOverImage = UIImage(named: "pourOver") else {
                return nil
              }
        
        let espressoMenuItem = MenuItem(image: espressoImage, name: "Espresso")
        let icedCoffeeMenuItem = MenuItem(image: icedCoffeeImage, name: "Iced Coffee")
        let macaronImageMenuItem = MenuItem(image: macaronImage, name: "Macaron")
        let matchaLatteImageMenuItem = MenuItem(image: matchaLatteImage, name: "Matcha Latte")
        let mochaLatteImageMenuItem = MenuItem(image: mochaLatteImage, name: "Mocha Latte")
        let donutImageMenuItem = MenuItem(image: donutImage, name: "Mochi Donut")
        let pourOverImageMenuItem = MenuItem(image: pourOverImage, name: "Pour Over")
        
        let menu = Menu(menuItems: [
            espressoMenuItem, icedCoffeeMenuItem, macaronImageMenuItem, matchaLatteImageMenuItem, mochaLatteImageMenuItem, donutImageMenuItem, pourOverImageMenuItem
        ])
        
        return menu
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    // MARK: - UI Setup
    
    func setUpUI() {
        view.backgroundColor = UIColor(named: "CreamColor")
        navigationItem.title = "Hanko's Cafe Menu"
        setUpTableView()
    }
    
    func setUpTableView() {
        menuTableView.translatesAutoresizingMaskIntoConstraints = false;
        menuTableView.backgroundColor = .clear
        menuTableView.dataSource = self
        menuTableView.delegate = self
        menuTableView.register(MenuItemTableViewCell.self, forCellReuseIdentifier: "menuItemCell")
        
        view.addSubview(menuTableView)
        
        let menuTableViewContraints: [NSLayoutConstraint] = [
            menuTableView.topAnchor.constraint(equalTo: view.topAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(menuTableViewContraints)
    }
    
    //MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu?.menuItems.count ?? 0
    }
    
    
    // WHAT
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let menuItem = menu?.menuItems[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCell", for: indexPath) as? MenuItemTableViewCell else {
            return UITableViewCell()
        }
        cell.load(text: menuItem.name, image: menuItem.image)
        return cell
        
        // This determines if we want to show the cell selection by having it be highlighted on click
        // cell.selectionStyle = .none
        
        // Alternative option
//        cell.menuItemImageView.image = UIImage(named: "icedCoffee")
//        cell.menuItemNameLabel.text = "Iced Coffee"
    }
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let menu = menu else {
            return
        }
        
        present(MenuItemViewController(menuItem: menu.menuItems[indexPath.row]), animated: true, completion: nil)
    }
}
