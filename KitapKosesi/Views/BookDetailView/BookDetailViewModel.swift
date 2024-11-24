//
//  BookDetailViewModel.swift
//  KitapKosesi
//
//  Created by Kadir on 24.11.2024.
//


//
//  LibraryViewModel.swift
//  KitapKosesi
//
//  Created by Kadir on 17.11.2024.
//

import Foundation
import RxSwift
import RxCocoa

class BookDetailViewModel : BaseViewModel{
    let book = BehaviorSubject<BookModel?>(value: nil)
    
    
    
    
    
    
    func getBook (id: String){
        
    

            self.homeLoading.onNext(true)

       
        
        NetworkManager.shared.request(urlString: "volumes/\(id)", model: BookModel.self) { result in
                self.homeLoading.onNext(false)

       
            switch result {
            case .success(let newBook):
                self.book.on(.next(newBook))

            case .failure(let error):
                print("Hata: \(error.localizedDescription)")
                
            }
        }
    }
    
    


    

    
}
