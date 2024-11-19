//
//  ViewController.swift
//  KitapKosesi
//
//  Created by Kadir on 12.11.2024.
//

import UIKit
import RxSwift
import RxCocoa

class LibraryViewController: BaseViewController, UIScrollViewDelegate, AppBarViewDelegate{
    
    
    var collectionView: UICollectionView!
    let libraryVM = LibraryViewModel()
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
    
    
    private  let indicatorView : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .systemTextGrey
        return indicator
    }()
    
    private  let paginationIndicatorView : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .systemTextGrey
        return indicator
    }()
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        appTitle.delegate = self
        view.addSubview(appTitle)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: bookListLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.register(BookItemCell.self, forCellWithReuseIdentifier: BookItemCell.reuseIdentifier)
        view.addSubview(collectionView)

        
        indicatorView.center = view.center
        view.addSubview(indicatorView)
        paginationIndicatorView.frame = CGRect(x:screenWidth/2 - 12, y: screenHeight - 125 , width: 24, height: 24)  
        view.addSubview(paginationIndicatorView)
        
        NSLayoutConstraint.activate([
            appTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            appTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            appTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
//            paginationIndicatorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -100),
//            paginationIndicatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
//            paginationIndicatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
        ])
        
        setupBindings()
        libraryVM.getBooks()
    }

    private func setupBindings(){
        
        libraryVM.homeLoading.bind(to: self.indicatorView.rx.isAnimating).disposed(by: disposeBag)
        
        libraryVM.pageLoading.bind(to: self.paginationIndicatorView.rx.isAnimating).disposed(by: disposeBag)

        
        libraryVM.books.bind(to: collectionView.rx.items(cellIdentifier: BookItemCell.reuseIdentifier, cellType: BookItemCell.self)) {row, item, cell in
            cell.setBook = item

        }.disposed(by: disposeBag)


    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collectionView.checkPagination()) {
            if !libraryVM.isLastPage && !paginationIndicatorView.isAnimating  && !indicatorView.isAnimating{
                libraryVM.getBooks();
              }
          }
    }
    

}



