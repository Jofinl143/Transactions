//
//  summaryViewPresenter.swift
//  Transactions
//
//  Created by Jofin George on 30/03/21.
//

import Foundation

@objc
protocol SummaryViewPresenterProtocol: AnyObject {
    func fetchTransaction()
    func setView(_ view: SummaryTableViewControllerProtocol?)
    func sortTransactions(transactions: [TransactionResponds]) -> [TransactionResponds]
}
class SummaryViewPresenter: SummaryViewPresenterProtocol{
 
    weak var view: SummaryTableViewControllerProtocol?
    // Pass something that conforms to PresenterView
    
    func setView(_ view: SummaryTableViewControllerProtocol?) {
        self.view = view
    }
    
    func fetchTransaction() {
        let service = TransactionsAPI()
        service.fetchTransactions { (details) in
            self.view?.reloadTableView(details)
        } failure: { (fail) in
            self.view?.failedResponds()
        }
    }
    
    // Sorting Transactions Alphabetically
    func sortTransactions(transactions: [TransactionResponds]) -> [TransactionResponds] {
        return transactions.sorted { $0.summary?.lowercased() ?? "" < $1.summary?.lowercased() ?? "" }
    }
}
