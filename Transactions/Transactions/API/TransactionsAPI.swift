//
//  GetTransactionsAPI.swift
//  Transactions
//
//  Created by Jofin George on 30/03/21.
//

import Foundation

@objc
public protocol TransactionsServiceProtocol {
    func fetchTransactions(completionHandler: @escaping ([TransactionResponds]) -> Void, failure: @escaping(Bool) -> Void)
}

class TransactionsAPI: TransactionsServiceProtocol {
    
    public static let API_PATH = "/api/v1/transactions"
    public static let BASE_URL = "https://60220907ae8f8700177dee68.mockapi.io"
    func fetchTransactions(completionHandler: @escaping ([TransactionResponds]) -> Void, failure: @escaping (Bool) -> Void) {
        let url = URL(string: TransactionsAPI.BASE_URL + TransactionsAPI.API_PATH)!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching: \(error)")
            failure(true)
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(String(describing: response))")
            return
          }
            do {
                guard let data =  data else{ return }
                let details = try JSONDecoder().decode([TransactionResponds].self, from: data)
                completionHandler(details)
            } catch let details {
                print("Error serializing json:", details)
                failure(true)
            }

        })
        task.resume()
      }
}
