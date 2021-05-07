//
//  ShadowImageView.swift
//  Cafe App
//
//  Created by Rashid Goshtasbi on 5/6/21.
//

import UIKit

class ShadowImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 100, height: 10) // OK this is where does do we place the shadow behind the image
        layer.shadowRadius = 10
    }

}
