//
//  ViewController.swift
//  LightSwitchFidget
//
//  Created by Rashid Goshtasbi on 5/11/21.
//

import UIKit

class LightSwitchToggleViewController: UIViewController {
    
    enum LightSwitchState: String {
        case on = "ON"
        case off = "OFF"
    }

    let lightSwitchButton = UIButton()
    var lightSwitchState = LightSwitchState.off
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        view.backgroundColor = .white
        setUpButton()
    }
    
    func setUpButton() {
        lightSwitchButton.translatesAutoresizingMaskIntoConstraints = false
        lightSwitchButton.setTitle("OFF", for: .normal)
        lightSwitchButton.backgroundColor = .black
        lightSwitchButton.addTarget(self, action: #selector(lightSwitchButtonPressed), for: .touchUpInside)
        
        view.addSubview(lightSwitchButton)
        
        NSLayoutConstraint.activate([
            lightSwitchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lightSwitchButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            lightSwitchButton.widthAnchor.constraint(equalToConstant: 100),
            lightSwitchButton.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    @objc func lightSwitchButtonPressed() {
        switch lightSwitchState {
        case .on:
            lightSwitchState = .off
            lightSwitchButton.backgroundColor = .black
            lightSwitchButton.setTitleColor(.white, for: .normal)
        case .off:
            lightSwitchState = .on
            lightSwitchButton.backgroundColor = .yellow
            lightSwitchButton.setTitleColor(.blue, for: .normal)
        }
        
        lightSwitchButton.setTitle(lightSwitchState.rawValue, for: .normal)
        lightSwitchButton.tintColor = .blue
    }
}

