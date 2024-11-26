//
//  KitapKosesiUITests.swift
//  KitapKosesiUITests
//
//  Created by Kadir on 26.11.2024.
//

import XCTest

final class KitapKosesiUITests: XCTestCase {

    func testAddFavorite() throws {
        print("Test calisiyor")

        let app = XCUIApplication()
        app.launch()
        let indicator = app.activityIndicators["indicatorView"]
        // indicator gorunur olmamasi bekleniyor
             let existsPredicate = NSPredicate(format: "exists == false")
             expectation(for: existsPredicate, evaluatedWith: indicator, handler: nil)

             // indicatorun durmasını bekliyoruz
             waitForExpectations(timeout: 10) { error in
                 if let error = error {
                     XCTFail("Indicator stop olmadı: \(error.localizedDescription)")
                 }
             }

        // Hücreye tikla
        let collectionViewCell = app.collectionViews.cells.element(boundBy: 3)
        XCTAssertTrue(collectionViewCell.exists, "3. hücre bulunamadı.")
        collectionViewCell.tap()

        // Favori eklemeye tikla
        let addFavoritesButton = app.buttons["Add Favorites"]
        if addFavoritesButton.exists {
            addFavoritesButton.tap()
        } else{
            print("Favori butonu bulunamadi. Beklendik bir durum")
        }
        
        // Geri Git
        let backButton = app.navigationBars.buttons["Back"]
        
        XCTAssertTrue(backButton.exists, "Geri butonu bulunamadı.")
        backButton.tap()
    }

}

