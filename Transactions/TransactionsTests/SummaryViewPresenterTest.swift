//
//  SummaryViewPresenterTest.swift
//  TransactionsTests
//
//  Created by Jofin George on 1/04/21.
//

import XCTest
@testable import Transactions

class SummaryViewPresenterTest: XCTestCase {
    var presenter = SummaryViewPresenter()
    
    func testSortTransactions() {
        let transactionDetals = [TransactionResponds(dictionary: ["id" : "1" as AnyObject,"transactionDate" : "2021-02-02T08:11:16+13:00" as AnyObject,"summary" : "Fancy Food Market Auckland" as AnyObject,"debit" : 197.9, "credit" : 0]),TransactionResponds(dictionary: ["id" : "1" as AnyObject,"transactionDate" : "2021-02-02T08:11:16+13:00" as AnyObject,"summary" : "Auckland" as AnyObject,"debit" : 1.9, "credit" : 0])]
        // Checking func returns a value
        XCTAssertNotNil(presenter.sortTransactions(transactions: transactionDetals))
        // Checking Sorting functionality
        XCTAssertNotEqual(presenter.sortTransactions(transactions: transactionDetals)[0].summary, transactionDetals[0].summary)
        XCTAssertEqual(presenter.sortTransactions(transactions: transactionDetals)[0].summary, transactionDetals[1].summary)
    }
}
