//
//  CustomCollectionViewCell.swift
//  KitapKosesi
//
//  Created by Kadir on 16.11.2024.
//
import UIKit
import SDWebImage

class BookItemCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MyCollectionViewCell"
    private var gradientLayer: CAGradientLayer?

    
    var book : BookModel?
    // Hücredeki etiket
    let label: UILabel = {
        let lbl = AppLabel(style: .subtitle)
        lbl.textColor = .textColor
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 8
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image.contentMode = .scaleToFill
        image.clipsToBounds = true // Resmin taşmaması için
        image.translatesAutoresizingMaskIntoConstraints = false
        
        // Gölge özelliklerini ayarlama
        image.layer.shadowColor = UIColor.textColor.cgColor
        image.layer.shadowOffset = CGSize(width: -2, height: -1)
        image.layer.shadowOpacity = 0.4
        image.layer.shadowRadius = 8
        image.layer.masksToBounds = false
        
        return image
        
    }()
    override func layoutSubviews() {
        applyGradientBackground()

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 8
      //  contentView.backgroundColor = .linearColor
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        applyGradientBackground()
        
        
        
        // Auto Layout kısıtlamalarını ayarla
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)  //
            
        ])
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Linear gradient background için layer
    private func applyGradientBackground() {
        
        if let gradientLayer = gradientLayer{
            gradientLayer.colors = [UIColor.linearColor.cgColor, UIColor.boxColor.cgColor]
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.8)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            gradientLayer.cornerRadius = 8

            gradientLayer.frame = contentView.bounds

        }else{
            gradientLayer = CAGradientLayer()
            gradientLayer!.colors = [UIColor.linearColor.cgColor, UIColor.boxColor.cgColor]
            gradientLayer!.locations = [0.0, 1.0]
            gradientLayer!.startPoint = CGPoint(x: 0, y: 0.8)
            gradientLayer!.endPoint = CGPoint(x: 0, y: 1)
            gradientLayer!.cornerRadius = 8
            // Gradient layer'ı hücrenin arka planına uygula
            gradientLayer!.frame = contentView.bounds
            contentView.layer.insertSublayer(gradientLayer!, at: 0)
        }

    }
    
    
    

    // Hücre verisini ayarlamak için bir değişken
    public var setBook: BookModel! {
        didSet {
            self.book = setBook
            label.text = setBook.volumeInfo?.authors?.first ?? "Anonim"
            imageView.sd_setImage(with: URL(string: setBook.volumeInfo?.imageLinks?.smallThumbnail ?? ""))
        }
    }
    
    
}

