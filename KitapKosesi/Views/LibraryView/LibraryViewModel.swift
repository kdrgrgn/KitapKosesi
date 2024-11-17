//
//  LibraryViewModel.swift
//  KitapKosesi
//
//  Created by Kadir on 17.11.2024.
//

import Foundation
import RxSwift
import RxCocoa

class LibraryViewModel {
    let books : PublishSubject<[BookModel]> = PublishSubject()
    let homeLoading : PublishSubject<Bool> = PublishSubject()
    let pageLoading : PublishSubject<Bool> = PublishSubject()
    let isLastPage = false


    

    
    func getBooks (search: String = "a"){
        self.homeLoading.onNext(true)
        let searchValidate = (search).isEmpty ? "a" : search
    
        NetworkManager.shared.request(urlString: "volumes?q=\(searchValidate)", model: BookListModel.self) { result in
            self.homeLoading.onNext(false)

            switch result {
            case .success(let book):
                self.books.onNext(book.items ?? [])

                
            case .failure(let error):
                print("Hata: \(error.localizedDescription)")

            }
        }
    }
    
}
