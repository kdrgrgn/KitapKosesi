//
//  LibraryViewModel.swift
//  KitapKosesi
//
//  Created by Kadir on 17.11.2024.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel : BaseViewModel{
    let books = BehaviorSubject<[BookModel]>(value: [])
    var isLastPage = false
    
    
    
    
    
    func getBooks (isReset: Bool = false, search: String = "a"){
        
        
        if(isReset) {
            resetPagination()
        }
        var tempBook : [BookModel] = (try? self.books.value()) ?? []

        if(tempBook.isEmpty){
            self.homeLoading.onNext(true)

        }else{
            self.pageLoading.onNext(true)
        }
        
        NetworkManager.shared.request(urlString: "volumes", model: BookListModel.self
                                      ,queryParams: ["q":(search).isEmpty ? "a" : search, "maxResults" : 20,"startIndex" : tempBook.count]) { result in
            if(tempBook.isEmpty){
                self.homeLoading.onNext(false)

            }else{
                self.pageLoading.onNext(false)
            }
            switch result {
            case .success(let book):
                    
                if((book.items ?? []).isEmpty){
                    self.isLastPage = true
                }else{
                    for e in (book.items ?? [] ){
                        tempBook.append(e)
                        
                    }
                    self.books.on(.next(tempBook))
                }
                 
                
                
                
                                
                
                
            case .failure(let error):
                print("Hata: \(error.localizedDescription)")
                
            }
        }
    }
    
    
    func  resetPagination(){
        self.books.onNext([])
        self.isLastPage = false
        
    }
    
}
