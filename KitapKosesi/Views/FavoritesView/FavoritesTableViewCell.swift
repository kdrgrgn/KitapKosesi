//
//  FavoritesTableViewCell.swift
//  KitapKosesi
//
//  Created by Kadir on 22.11.2024.
//

import UIKit
import SDWebImage

class FavoriteItemCell: UITableViewCell {
    
    static let reuseIdentifier = "FavoriteItemCell"

    
    var book : BookModel?
    
    let bookNameLabel: UILabel = {
        let lbl = AppLabel(style: .body)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let authorLabel: UILabel = {
        let lbl = AppLabel(style: .subtitle)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let infoColumn: UIStackView = {
        let column = UIStackView()
        column.axis = .vertical
        column.alignment = .leading
        column.distribution = .fillProportionally
        column.translatesAutoresizingMaskIntoConstraints = false
        return column
    }()
    
    let infoRow: UIStackView = {
        let row = UIStackView()
        row.axis = .horizontal
        row.spacing = 12

        row.translatesAutoresizingMaskIntoConstraints = false
        return row
    }()
    
    
    
    let imageViewCell: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 4
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true // Resmin taşmaması için
        image.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 75),

        ])

        return image
        
    }()
    
  

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        infoColumn.addArrangedSubview(bookNameLabel)
        infoColumn.addArrangedSubview(authorLabel)
        contentView.backgroundColor = .secondaryColor
        
        infoRow.addArrangedSubview(imageViewCell)
        infoRow.addArrangedSubview(infoColumn)
        let container = AppContainer(view: infoRow,padding: UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12))
        
        self.contentView.addSubview(container)
        

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            container.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 20),
            container.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor,constant: -20),
            container.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
      
        ])    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Hücre verisini ayarlamak için bir değişken
    public var setBook: BookModel! {
        didSet {
            self.book = setBook
            authorLabel.text = setBook.volumeInfo?.authors?.first ?? "Anonim"
            bookNameLabel.text = setBook.volumeInfo?.title ?? ""

            imageViewCell.sd_setImage(with: URL(string: setBook.volumeInfo?.imageLinks?.smallThumbnail ?? ""))
        }
    }
    

}
