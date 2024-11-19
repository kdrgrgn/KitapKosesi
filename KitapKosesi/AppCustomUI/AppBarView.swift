//
//  AppBarView.swift
//  KitapKosesi
//
//  Created by Kadir on 17.11.2024.
//

import UIKit


class AppBarView : UIView {
    
    weak var delegate: AppBarViewDelegate?

    
    private  let appTitleLable : AppLabel = {
        let label = AppLabel(style: .head)
        label.text = "appName".localized()

        return label
    }()
    
    private  let searchIcon : UIImageView = {
        let imageView = UIImageView()
        imageView.image = .searchIcon
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 32),
            imageView.heightAnchor.constraint(equalToConstant: 32)
        ])
        imageView.isUserInteractionEnabled = true
        
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
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(directSearchBook))
        searchIcon.addGestureRecognizer(tapGesture)
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
    
    @objc func directSearchBook() {
        delegate?.navigationController?.pushViewController(SearchViewController(), animated: true)

    }
 
}


