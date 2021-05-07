//
//  MenuItemTableViewCell.swift
//  Cafe App
//
//  Created by Rashid Goshtasbi on 5/3/21.
//

import UIKit

class MenuItemTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    let menuItemImageView = UIImageView()
    let menuItemNameLabel = UILabel()

    
    //MARK: - Initializer
    // TODO: what are these arguments and where do they come from and why do we use them?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - UI Setup
    func setUpUI() {
        backgroundColor = .clear
        setUpImageview()
        setUpNameLabel()
    }
    
    
    // TODO: 2:36 was a bit confusing, perhaps a diagram during the video to explain the logic Han was saying?
    func setUpImageview() {
        menuItemImageView.translatesAutoresizingMaskIntoConstraints = false
        menuItemImageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(menuItemImageView)
        
        let menuItemImageViewConstraints: [NSLayoutConstraint] = [
            menuItemImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            menuItemImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            menuItemImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            menuItemImageView.heightAnchor.constraint(equalTo: menuItemImageView.widthAnchor)
        ]
        
        NSLayoutConstraint.activate(menuItemImageViewConstraints)
    }
    
    func setUpNameLabel() {
        menuItemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        menuItemNameLabel.textAlignment = .center
        menuItemNameLabel.font = UIFont(name: "SourceSansPro-SemiBoldItalic", size: 24)
        
        contentView.addSubview(menuItemNameLabel) 
        
        let menuItemNameLabelViewConstraints: [NSLayoutConstraint] = [
            menuItemNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            menuItemNameLabel.leadingAnchor.constraint(equalTo: menuItemImageView.trailingAnchor),
            menuItemNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            menuItemNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(menuItemNameLabelViewConstraints)
    }
    
    func load(text: String, image: UIImage) {
        
        menuItemImageView.image = image
        menuItemNameLabel.text = text
    }
}
