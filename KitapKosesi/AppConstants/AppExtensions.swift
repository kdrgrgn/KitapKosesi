//
//  AppExtensions.swift
//  KitapKosesi
//
//  Created by Kadir on 17.11.2024.
//

import Foundation
import UIKit

extension Bundle {
    private static var bundle: Bundle!
    
    public static func localizedBundle() -> Bundle! {
        if bundle == nil {
            let appLang = UserDefaults.standard.string(forKey: appLangKey) ?? "en"
            let path = Bundle.main.path(forResource: appLang, ofType: "lproj")
            bundle = Bundle(path: path!)
        }
        
        return bundle;
    }
    
    public static func setLanguage(lang: String) {
        UserDefaults.standard.set(lang, forKey: appLangKey)
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        bundle = Bundle(path: path!)
        
    // Uygulamayi yeniden bastlatma
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            sceneDelegate.startApp()
        }


    
    }
}


extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.localizedBundle(), value: "", comment: "")
    }
    
    func localizeWithFormat(arguments: CVarArg...) -> String{
        return String(format: self.localized(), arguments: arguments)
    }
}


extension UICollectionView {
    func checkPagination() -> Bool {
        if contentSize.height == 0 {
                 return false
             }
        return contentOffset.y >= (contentSize.height - bounds.size.height)
    }
}

extension UITableView {
    func checkPagination() -> Bool {
        if contentSize.height == 0 {
                 return false
             }
        return contentOffset.y >= (contentSize.height - bounds.size.height)
    }
}
