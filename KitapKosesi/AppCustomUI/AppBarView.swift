//
//  AppBarView.swift
//  KitapKosesi
//
//  Created by Kadir on 17.11.2024.
//

import UIKit


class AppBarView : UIView {
    
    
    
    private  let appTitleLable : AppLabel = {
        let label = AppLabel(style: .head)
        label.text = "appName".localized()

        return label
    }()
    
    private  let searchIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SearchIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
        
    }()

    private  let titleRow : UIStackView = {
        let row = UIStackView()
        row.axis = .horizontal
        row.translatesAutoresizingMaskIntoConstraints = false
        row.distribution = .fill
        row.spacing = 16 // Elemanlar arasındaki boşluk

        return row
        
    }()
    
    
  
    init() {
        super.init(frame: .zero)
        titleRow.addArrangedSubview(appTitleLable)
        titleRow.addArrangedSubview(searchIcon)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleRow)
        
        // Auto Layout ile titleRow'u hizala
          NSLayoutConstraint.activate([
              titleRow.topAnchor.constraint(equalTo: topAnchor),
              titleRow.leadingAnchor.constraint(equalTo: leadingAnchor),
              titleRow.trailingAnchor.constraint(equalTo: trailingAnchor),
              titleRow.bottomAnchor.constraint(equalTo: bottomAnchor)
          ])

    }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
     }
 
}


