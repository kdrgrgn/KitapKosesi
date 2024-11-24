//
//  ViewController.swift
//  KitapKosesi
//
//  Created by Kadir on 24.11.2024.
//

import UIKit
import RxSwift
import RxCocoa

class BookDetailViewController: BaseViewController {
    let bookDetailVM  = BookDetailViewModel()
    let disposeBag = DisposeBag()

    
    let bottomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("addFavorites".localized(), for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        return button
    }()
    
    private  let indicatorView : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.color = .systemTextGrey
        return indicator
    }()
    
    
    
    let bookImageView : UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true

        return image
    }()
    
    let bookInfoLabel : AppLabel = {
        var label = AppLabel(style: .body)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let scrollView : UIScrollView = {
        var view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
    }
    
    private func setupBindings(){
        
        bookDetailVM.homeLoading.bind(to: self.indicatorView.rx.isAnimating).disposed(by: disposeBag)
        
        
        bookDetailVM.book.observe(on: MainScheduler.instance).subscribe { book in
            if let book = book {
                self.setTitle(book.volumeInfo?.title ?? "")
                
                self.bookImageView.sd_setImage(with: URL(string: book.volumeInfo?.imageLinks?.extraLarge ?? book.volumeInfo?.imageLinks?.large ??  book.volumeInfo?.imageLinks?.thumbnail ?? "" ))
                self.bookInfoLabel.text = book.volumeInfo?.description ?? ""
                self.isAddedFavorite()
            }
        
        }.disposed(by: disposeBag)
        



    }
    
    override func setupUI() {
        scrollView.addSubview(bookInfoLabel)
        view.addSubview(bookImageView)
        view.addSubview(scrollView)
        
        
        bottomButton.addTarget(self, action: #selector(addFavorites), for:.touchUpInside)
        view.addSubview(bottomButton)
        indicatorView.center = view.center
        view.addSubview(indicatorView)

        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bookImageView.heightAnchor.constraint(equalToConstant: screenHeight / 3),
            
            
            scrollView.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomButton.bottomAnchor, constant: -50),
            
            
            bookInfoLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            bookInfoLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            bookInfoLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            bookInfoLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            bookInfoLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bottomButton.heightAnchor.constraint(equalToConstant: 50)

            
        ])

        
    }
    
    public var setBook : String! {
        didSet {
            self.bookDetailVM.getBook(id: setBook)
        }
    }
    
    @objc func addFavorites(){
        if let book = try? self.bookDetailVM.book.value() {
            let cdBook = CDBook(context:  CoreDataManager.shared.privateManagedObjectContext)
         
            cdBook.title = book.volumeInfo?.title ?? ""
            cdBook.author = book.volumeInfo?.authors?.first ?? ""
            cdBook.image = book.volumeInfo?.imageLinks?.smallThumbnail ??  book.volumeInfo?.imageLinks?.thumbnail
            cdBook.id = book.id
             
           CoreDataManager.shared.saveData(objects: [cdBook])
           bottomButton.isHidden = true
        }
        
  
    }
    func isAddedFavorite(){
        if let book = try? self.bookDetailVM.book.value() {
            if CoreDataManager.shared.fetchObjectById(entity: CDBook.self, id: book.id ?? "") != nil {
                bottomButton.isHidden = true
            }
        }
    }


}
