//
//  TransactionDetailPresenterTest.swift
//  TransactionsTests
//
//  Created by Jofin George on 1/04/21.
//

import XCTest
@testable import Transactions
class TransactionDetailPresenterTest: XCTestCase {
    
    let presenter = TransactionDetailPresenter()
    func testGetGstAmount() {
        // Fixed GST rate = 15%
        //Amount = 100
        // Expected Result = 15
        XCTAssertEqual(presenter.getGstAmount(amount: 100), "GST : $15.00")
        //Amount = 50
        // Expected Result = 7.5
        XCTAssertEqual(presenter.getGstAmount(amount: 50), "GST : $7.50")
        //Amount = 0
        // Expected Result = 0
        XCTAssertEqual(presenter.getGstAmount(amount: 0), "GST : $0.00")
        //Amount = 10
        // Expected Result = 1.5
        XCTAssertNotEqual(presenter.getGstAmount(amount: 10), "GST : $20.00")
    }

    func testGetdate() {
        // Date String = "2021-02-02T08:11:16+13:00"
        // Expected Result = 2021-02-01 19:11:16
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        var date = dateFormatter.date(from: "2021-02-02T08:11:16")
        XCTAssertEqual(presenter.getDate(dateString: "2021-02-02T08:11:16+13:00"), date)
        
        // Date String = "2019-02-02T08:11:16+13:00"
        // Expected Result = 2021-02-01 19:11:16
        date = dateFormatter.date(from: "2021-02-02T08:11:16")
        XCTAssertNotEqual(presenter.getDate(dateString: "2019-02-02T08:11:16+13:00"), date)

    }
}
