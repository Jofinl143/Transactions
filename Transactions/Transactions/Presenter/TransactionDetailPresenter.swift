//
//  TransactionDetailPresenter.swift
//  Transactions
//
//  Created by Jofin George on 31/03/21.
//

import Foundation
@objc
protocol TransactionDetailPresenterProtocol: AnyObject {
    func getGstAmount(amount: Double) -> String
    func getDate(dateString: String) -> Date?
}
class TransactionDetailPresenter: TransactionDetailPresenterProtocol {
    
    func getGstAmount(amount: Double) -> String {
        return String(format: "GST : $%.2f", (amount * 15)/100)
    }
    
    func getDate(dateString: String) -> Date? {
        let dateStr = dateString.replacingOccurrences(of: "+13:00", with: "")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: dateStr)
    }
}
