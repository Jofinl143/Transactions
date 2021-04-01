//
//  TransactionResponds.swift
//  Transactions
//
//  Created by Jofin George on 30/03/21.
//

import Foundation
public class TransactionResponds: NSObject,Codable {
    var id: String?
    var transactionDate: String?
    var summary: String?
    var debit: Double?
    var credit: Double?
    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as? String
        self.transactionDate = dictionary["transactionDate"] as? String
        self.summary = dictionary["summary"] as? String
        self.debit = dictionary["debit"] as? Double
        self.credit = dictionary["credit"] as? Double
    }
}
