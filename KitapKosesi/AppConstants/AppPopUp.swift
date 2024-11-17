//
//  AppPopUp.swift
//  KitapKosesi
//
//  Created by Kadir on 16.11.2024.
//
import UIKit
class AppPopUp{
    static let shared = AppPopUp() // Singleton pattern
      private init() {}
    
     func showErrorAlert(message: String) {
        guard let topViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }

        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        topViewController.present(alert, animated: true, completion: nil)
    }

}

