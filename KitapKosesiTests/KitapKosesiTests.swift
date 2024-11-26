//
//  KitapKosesiTests.swift
//  KitapKosesiTests
//
//  Created by Kadir on 26.11.2024.
//

import Testing
@testable import KitapKosesi
import XCTest

struct KitapKosesiTests {

    @Test func getBooksFromApi() async throws {
        let viewModel = LibraryViewModel()
        viewModel.getBooks(isReset: true)
        XCTAssertFalse(try! viewModel.books.value().isEmpty, "Kitap listesi boş olmamalı")

    }
    
    @Test func getBooksFromApiSearch() async throws {
        let viewModel = SearchViewModel()
        viewModel.getBooks(isReset: true,search: "aa")
        XCTAssertFalse(try! viewModel.books.value().isEmpty, "Kitap listesi boş olmamalı")

    }
    
    @Test func testGetBooksFromFavorites() async throws {
        let viewModel = FavoritesViewModel()

        do {
             viewModel.getBooks()

            let books = try viewModel.books.value()
            if books.isEmpty {
                print("Uyarı: Kitap listesi boş ancak hata yok.")
            } 

        } catch {
            XCTFail("Kitaplar alınırken bir hata oluştu: \(error)")
        }
    }
    
}
