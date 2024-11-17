//
//  ViewController.swift
//  KitapKosesi
//
//  Created by Kadir on 12.11.2024.
//

import UIKit
import RxSwift
import RxCocoa

class LibraryViewController: UIViewController, UIScrollViewDelegate{
    
    
    var collectionView: UICollectionView!
    var books = Array<BookModel>()
    let libraryVM = LibraryViewModel()
    let indicator = UIActivityIndicatorView()
    let disposeBag = DisposeBag()
    let appTitle = AppBarView()



    
    private  let bookListLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 10
        var itemWidth = (UIScreen.main.bounds.width - 50) / 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth*2) // İki öğe için her öğenin genişliği

        
        return layout
        
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(appTitle)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: bookListLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.register(BookItemCell.self, forCellWithReuseIdentifier: BookItemCell.reuseIdentifier)
        view.addSubview(collectionView)

        
        indicator.hidesWhenStopped = true
        indicator.color = .systemTextGrey
        indicator.center = view.center
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            appTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
        
        setupBindings()
        libraryVM.getBooks()
    }

    private func setupBindings(){
        
        libraryVM.homeLoading.bind(to: self.indicator.rx.isAnimating).disposed(by: disposeBag)
        
        libraryVM.books.bind(to: collectionView.rx.items(cellIdentifier: BookItemCell.reuseIdentifier, cellType: BookItemCell.self)) {row, item, cell in
            cell.setBook = item

        }.disposed(by: disposeBag)


    }
    
 

}



