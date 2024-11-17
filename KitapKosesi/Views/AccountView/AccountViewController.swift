//
//  AccountViewController.swift
//  KitapKosesi
//
//  Created by Kadir on 14.11.2024.
//

import UIKit

class AccountViewController: UIViewController {
    let appTitle = AppBarView()
    
    
 
    
    private  let favoriteView : AppContainer = {
        let favoriteRow = UIStackView()
        favoriteRow.axis = .horizontal
        favoriteRow.translatesAutoresizingMaskIntoConstraints = false
        favoriteRow.distribution = .fillProportionally
        
        let title = AppLabel(style: .body)
        title.text = "favorites".localized()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ArrowNext")
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 12),
            imageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        

        favoriteRow.addArrangedSubview(title)
        favoriteRow.addArrangedSubview(imageView)
        
 
        let container = AppContainer(view: favoriteRow)

        return container
        
    }()
    
    
    
    private  let languageView : AppContainer = {
        let row = UIStackView()
        row.axis = .horizontal
        row.translatesAutoresizingMaskIntoConstraints = false
        row.distribution = .fillProportionally
        
        let title = AppLabel(style: .body)
        title.text = UserDefaults.standard.string(forKey: appLangKey) == "tr" ? "turkish".localized() : "english".localized()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ArrowNext")
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 12),
            imageView.heightAnchor.constraint(equalToConstant: 12)
        ])
        

        row.addArrangedSubview(title)
        row.addArrangedSubview(imageView)
        
 
        let container = AppContainer(view: row)

        return container
        
    }()
    
    
    
    
    
    private  let viewModeRow : UIStackView = {
        let row = UIStackView()
        row.axis = .horizontal
        row.translatesAutoresizingMaskIntoConstraints = false
        row.distribution = .fillProportionally
        


        return row
        
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondaryColor
        
        //DARK MODE
        let title = AppLabel(style: .body)
        let isDarkMode = UserDefaults.standard.bool(forKey: darkModeKey)

        title.text = isDarkMode ? "toLightMode".localized() : "toDarkMode".localized()
        let appSwitch = AppSwitch(isOn: isDarkMode) { newValue in
            UserDefaults.standard.set(newValue, forKey: darkModeKey)
            self.applyGlobalAppearance(isDarkMode: newValue)
            title.text = newValue ? "toLightMode".localized() : "toDarkMode".localized()


        }
        viewModeRow.addArrangedSubview(title)
        viewModeRow.addArrangedSubview(appSwitch)
        let viewModeView = AppContainer(view: viewModeRow)
        
   
        
        view.addSubview(appTitle)
        view.addSubview(viewModeView)
        view.addSubview(favoriteView)
        view.addSubview(languageView)
        
        //Language
        // UITapGestureRecognizer oluşturma
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeLang))
          
        languageView.addGestureRecognizer(tapGesture)
          
        languageView.isUserInteractionEnabled = true


        
        NSLayoutConstraint.activate([
            
            appTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            
            favoriteView.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 20),
            favoriteView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            favoriteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            languageView.topAnchor.constraint(equalTo: favoriteView.bottomAnchor, constant: 20),
            languageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            languageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            

            viewModeView.topAnchor.constraint(equalTo: languageView.bottomAnchor, constant: 20),
            viewModeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            viewModeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            

        ])

        // Do any additional setup after loading the view.
    }
    
    func applyGlobalAppearance(isDarkMode: Bool) {
        // Bağlanan tüm sahneleri al
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }

        // İlk pencereyi al
        if let window = windowScene.windows.first {
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }

    }
    
     @objc func changeLang() {
         let lang = UserDefaults.standard.string(forKey: appLangKey)

         Bundle.setLanguage(lang:lang == "tr" ? "en" : "tr")
     }


}
