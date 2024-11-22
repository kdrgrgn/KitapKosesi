//
//  LibraryViewModel.swift
//  KitapKosesi
//
//  Created by Kadir on 17.11.2024.
//

import Foundation
import RxSwift
import RxCocoa

class FavoritesViewModel : BaseViewModel{
    let books = BehaviorSubject<[BookModel]>(value: [])
    
    
    
    
    
    func getBooks (){
        
        


            self.homeLoading.onNext(true)

    

    }
    
    

    
}
