//
//  TransactionDetailViewController.swift
//  Transactions
//
//  Created by Jofin George on 31/03/21.
//

import UIKit

class TransactionDetailViewController: UIViewController {

    lazy var presenter = TransactionDetailPresenter()
    var details: TransactionResponds?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var accountNumber: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var gstLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        self.navigationController?.navigationItem.backBarButtonItem?.accessibilityIdentifier = "btnBack"
        setupView()
    }
    
    func setupView() {
        
        self.nameLabel.text = "David John"
        
        if let credit = details?.credit, credit > 0 {
            self.amountLabel.textColor = .green
            self.amountLabel.text = String(format: "+ $%.2f", credit)
        } else if let debit = details?.debit, debit > 0{
            self.amountLabel.textColor = .red
            self.amountLabel.text = String(format: "- $%.2f", debit)
            self.gstLabel.text = presenter.getGstAmount(amount: debit)
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd HH:mm:ss"
        
        let date = dateFormatter.string(from: presenter.getDate(dateString: details?.transactionDate ?? "") ?? Date())
        self.datelabel.text = String(format: "Processed on : %@", date)
        
        self.accountNumber.text = "9201-1255-4848-79"
        self.detailLabel.text = "Transaction"
    }
    
}
