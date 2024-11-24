//
//  FavoritesViewController.swift
//  KitapKosesi
//
//  Created by Kadir on 22.11.2024.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesViewController: BaseViewController , UIScrollViewDelegate ,  AppCellOnTapDelegate{
    
    let favoritesVM = FavoritesViewModel()
    let disposeBag = DisposeBag()
    
    
    private let favoritesList : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        favoritesVM.getBooks()
    }
    
    override func setupUI() {
        setTitle("myFavorites".localized())
        favoritesList.backgroundColor = .secondaryColor


        view.addSubview(favoritesList)
        favoritesList.rx.setDelegate(self).disposed(by: disposeBag)
        favoritesList.register(FavoriteItemCell.self, forCellReuseIdentifier: FavoriteItemCell.reuseIdentifier)
        favoritesList.rowHeight = 108

        
        NSLayoutConstraint.activate([
        
            favoritesList.topAnchor.constraint(equalTo: self.view.topAnchor),
            favoritesList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            favoritesList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            favoritesList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

        ])    }
    

    
    private func setupBindings(){
        
        
        favoritesList.rx.itemDeleted
             .subscribe(onNext: { indexPath in
                 self.favoritesVM.deleteBook(at: indexPath.row)
             })
             .disposed(by: disposeBag)
        
        
        favoritesVM.books.bind(to: favoritesList.rx.items(cellIdentifier: FavoriteItemCell.reuseIdentifier, cellType: FavoriteItemCell.self)) {row, item, cell in
            cell.setBook = item
            cell.delegate = self

        }.disposed(by: disposeBag)


    }
    


    

}


