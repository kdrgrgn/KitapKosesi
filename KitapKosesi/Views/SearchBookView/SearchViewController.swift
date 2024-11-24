//
//  ViewController.swift
//  KitapKosesi
//
//  Created by Kadir on 12.11.2024.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController, UIScrollViewDelegate, AppCellOnTapDelegate{
    
    
    var collectionView: UICollectionView!
    let searchVM = SearchViewModel()
    let disposeBag = DisposeBag()




    
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
    
    
    private let searchTextField : UITextField = {
        let field = UITextField()
        field.borderStyle = .roundedRect
        field.placeholder = "makeSearch".localized()
        
        field.translatesAutoresizingMaskIntoConstraints = false

        return field
    }()

    override func viewDidAppear(_ animated: Bool) {
        searchTextField.becomeFirstResponder()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupBindings()
    }
    
    override func setupUI() {
        setTitle("findYourBook".localized())
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: bookListLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.register(BookItemCell.self, forCellWithReuseIdentifier: BookItemCell.reuseIdentifier)

        
        
        view.addSubview(collectionView)
        view.addSubview(searchTextField)
        
        indicatorView.center = view.center
        paginationIndicatorView.frame = CGRect(x:screenWidth/2 - 12, y: screenHeight-125 , width: 24, height: 24)

        view.addSubview(indicatorView)
        view.addSubview(paginationIndicatorView)

        
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            
        ])
    }
    

    private func setupBindings(){
        
        searchVM.homeLoading.bind(to: self.indicatorView.rx.isAnimating).disposed(by: disposeBag)
        
        searchVM.pageLoading.bind(to: self.paginationIndicatorView.rx.isAnimating).disposed(by: disposeBag)
        
        searchTextField.rx.text.orEmpty
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)  // 500ms gecikme
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<Void> in
                
                guard !query.isEmpty else {
                        self.searchVM.getBooks(isReset: true)

                    return .just(())
                }

                self.searchVM.getBooks(isReset: true, search: query)
                return .just(())
            }
            .subscribe(onNext: { _ in
                // Burada API çağrısı tamamlandığında yapılacak işlemler
   
            })
            .disposed(by: disposeBag)

        
        searchVM.books.bind(to: collectionView.rx.items(cellIdentifier: BookItemCell.reuseIdentifier, cellType: BookItemCell.self)) {row, item, cell in
            cell.setBook = item
            cell.delegate = self

        }.disposed(by: disposeBag)


    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collectionView.checkPagination()) {
            if !searchVM.isLastPage && !paginationIndicatorView.isAnimating  && !indicatorView.isAnimating{
                searchVM.getBooks(search: searchTextField.text ?? "");
              }
          }
    }
    

}



