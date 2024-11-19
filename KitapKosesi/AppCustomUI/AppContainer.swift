//
//  AppLabel 2.swift
//  KitapKosesi
//
//  Created by Kadir on 17.11.2024.
//


//
//  AppLabel.swift
//  KitapKosesi
//
//  Created by Kadir on 13.11.2024.
//

import UIKit


class AppContainer : UIButton {
  
    init(view: UIView, padding: UIEdgeInsets = UIEdgeInsets(top: 16, left: 20, bottom: 16, right: 20)) {
        super.init(frame: .zero)
        backgroundColor = .boxColor
        layer.cornerRadius = 10
        layer.borderWidth = 0
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: padding.top),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding.bottom),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right)
           
        ])
    }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
     }
 
}

