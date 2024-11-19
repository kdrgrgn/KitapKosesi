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
        
    }

    func setupNavigationBar() {

        self.navigationItem.setLeftBarButton(UIBarButtonItem(title: "back".localized(), image: UIImage(systemName: "chevron.backward"), target: self, action: #selector(popView)), animated: true)
        
    }
    
    
    @objc func popView() {
        self.navigationController?.popViewController(animated: true)

    }
    
    func setTitle(_ title: String) {
        setupNavigationBar()
        self.navigationItem.title = title
    }
    


}
