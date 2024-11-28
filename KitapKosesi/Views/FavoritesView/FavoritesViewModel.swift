//
//  LibraryViewModel.swift
//  KitapKosesi
//
//  Created by Kadir on 17.11.2024.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

class FavoritesViewModel : BaseViewModel{
    let books = BehaviorSubject<[CDBook]>(value: [])
    
    
    
    
    
    func getBooks (){
    
            let newBooks =  CoreDataManager.shared.fetchAllData(entity: CDBook.self) ?? []
            books.onNext(newBooks)
    }
    
    func deleteBook(at index: Int) {
      
        if  var currentBooks = try? self.books.value() {
            CoreDataManager.shared.deleteData(objects: [currentBooks[index]])
            currentBooks.remove(at: index)
            self.books.on(.next(currentBooks))
            

        }

    }
    
    func  clearData(){
        books.onNext([])
        
    }
    

    
}
