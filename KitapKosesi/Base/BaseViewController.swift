//
//  BaseViewController.swift
//  CryptoCrazy
//
//  Created by Kadir on 10.11.2024.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar ayarlarını tek bir yerde tanımlıyoruz
        setupNavigationBar()
    }

    // Navigation bar ayarlarını buraya koyuyoruz
    func setupNavigationBar() {
        // Navigation bar appearance ayarları
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .primaryColor

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.textColor
        ]
        
        // Standart ve scrollEdge appearance için ayarları yapıyoruz
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.backItem?.backButtonTitle = "back".localized()
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance

        // Navigation bar’ın görünür olduğunu belirliyoruz
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // Başlık belirleme fonksiyonu
    func setTitle(_ title: String) {
        self.navigationItem.title = title
    }
    
    // Title yukseklik alma
    func getTitleHeight() -> CGFloat {
        return self.navigationController?.navigationBar.frame.height ?? 44
    }

}
