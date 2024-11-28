//
//  AccountViewController.swift
//  KitapKosesi
//
//  Created by Kadir on 14.11.2024.
//

import UIKit

class AccountViewController: BaseViewController, AppBarViewDelegate {
    let appTitle = AppBarView()
    
    

 
    
    private  let favoriteView : AppContainer = {
        let favoriteRow = UIStackView()
        favoriteRow.axis = .horizontal
        favoriteRow.translatesAutoresizingMaskIntoConstraints = false
        favoriteRow.distribution = .fillProportionally
        
        let title = AppLabel(style: .body)
        title.text = "favorites".localized()
        
        let imageView = UIImageView()
        imageView.image = .arrowNext
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        favoriteRow.addArrangedSubview(title)
        favoriteRow.addArrangedSubview(imageView)
 
        let container = AppContainer(view: favoriteRow)
        container.isUserInteractionEnabled = true
   

        return container
        
    }()
    
    
    
    private  let languageView : AppContainer = {
        var languages = [DropDownModel(name: "turkish".localized(), key: "tr"),DropDownModel(name: "english".localized(), key: "en")]
        let row = UIStackView()
        row.axis = .horizontal
        row.translatesAutoresizingMaskIntoConstraints = false
        row.distribution = .fillProportionally
        
        let title = AppLabel(style: .body)
        title.text = UserDefaults.standard.string(forKey: appLangKey) == "tr" ? "turkish".localized() : "english".localized()
        
        let imageView = UIImageView()
        imageView.image = .arrowNext
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit

     
        row.addArrangedSubview(title)
        row.addArrangedSubview(imageView)
        
    
        
        var actions = Array<UIAction>()
        for language in languages {
            let action = UIAction(title: language.name, image: nil) { _ in
            Bundle.setLanguage(lang:language.key)
            }
            actions.append(action)
        }

 
        let container = AppContainer(view: row)
        container.isUserInteractionEnabled = true
        container.showsMenuAsPrimaryAction = true
        container.menu = UIMenu(options: .displayInline, children: actions)

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
        


    }
    
    
    override func setupUI() {
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(directFavorites))
        favoriteView.addGestureRecognizer(tapGesture)
    
        appTitle.delegate = self
        view.addSubview(appTitle)
        view.addSubview(viewModeView)
        view.addSubview(favoriteView)
        view.addSubview(languageView)
        



        
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
    
    @objc func directFavorites() {
        self.navigationController?.pushViewController(FavoritesViewController(), animated: true)

    }
    


}
