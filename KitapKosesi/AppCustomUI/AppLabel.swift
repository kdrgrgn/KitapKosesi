//
//  AppLabel.swift
//  KitapKosesi
//
//  Created by Kadir on 13.11.2024.
//

import UIKit


class AppLabel : UILabel {
    
    

    
    enum TextStyle: String {
        case head
        case title
        case subtitle
        case body
        case action
        // Diğer stilleri buraya ekleyin
    }
    
    init(style: TextStyle) {
         super.init(frame: .zero)
         applyStyle(style)
     }
     
     required init?(coder: NSCoder) {
         super.init(coder: coder)
     }
    
    func applyStyle(_ style: TextStyle){
        if let styleAttributes = AppLabel.styles[style] {
            font = styleAttributes.font
            textColor = styleAttributes.color
            translatesAutoresizingMaskIntoConstraints = false
            
             }
    }
    
    
    // Stil özelliklerini içeren yapı
    private struct StyleAttributes {
        var font: UIFont?
        let color: UIColor
    }
    
    private static let styles: [TextStyle: StyleAttributes] = [
        .head: StyleAttributes(font: UIFont(name: FontStyles.boldFontName, size: 34), color: .textColor),
        .title: StyleAttributes(font:UIFont(name: FontStyles.boldFontName, size: 22), color: .textColor),
        .subtitle: StyleAttributes(font: UIFont(name: FontStyles.regularFontName, size: 15), color: .systemTextGrey),
        .body: StyleAttributes(font: UIFont(name: FontStyles.semiboldFontName, size: 16), color: .textColor),
        .action: StyleAttributes(font: UIFont(name: FontStyles.regularFontName, size: 12), color: .systemTextGrey),

        
     ]
    
}
//NewYork stili icin font weight kisaltmasi
class FontStyles {
    static let regularFontName = "STIXTwoText"
    static let boldFontName = "STIXTwoText-Bold"
    static let semiboldFontName = "STIXTwoText-Semibold"
    static let italicFontName = "STIXTwoText-Italic"
}

