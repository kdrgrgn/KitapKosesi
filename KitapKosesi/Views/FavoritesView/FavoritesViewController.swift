//
//  FavoritesViewController.swift
//  KitapKosesi
//
//  Created by Kadir on 22.11.2024.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesViewController: BaseViewController , UIScrollViewDelegate{
    
    let favoritesVM = LibraryViewModel()
    let disposeBag = DisposeBag()
    
    
    private let favoritesList : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()
    
    private  let indicatorView : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .systemTextGrey
        return indicator
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        favoritesVM.getBooks(isReset: true)
    }
    
    
    
    override func setupUI() {
        setTitle("myFavorites".localized())
        favoritesList.backgroundColor = .secondaryColor

        view.addSubview(favoritesList)
        favoritesList.rx.setDelegate(self).disposed(by: disposeBag)
        favoritesList.register(FavoriteItemCell.self, forCellReuseIdentifier: FavoriteItemCell.reuseIdentifier)
        
        indicatorView.center = view.center
        view.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
        
            favoritesList.topAnchor.constraint(equalTo: self.view.topAnchor),
            favoritesList.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            favoritesList.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            favoritesList.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

        ])    }
    

    
    private func setupBindings(){
        
        favoritesVM.homeLoading.bind(to: self.indicatorView.rx.isAnimating).disposed(by: disposeBag)
        
        favoritesList.rx.itemDeleted
             .subscribe(onNext: { [weak self] indexPath in
                 guard let self = self else { return }
                 self.favoritesVM.deleteBook(at: indexPath.row)
             })
             .disposed(by: disposeBag)
        

        
        favoritesVM.books.bind(to: favoritesList.rx.items(cellIdentifier: FavoriteItemCell.reuseIdentifier, cellType: FavoriteItemCell.self)) {row, item, cell in
            cell.setBook = item

        }.disposed(by: disposeBag)


    }
    


    

}


