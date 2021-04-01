//
//  SummaryTableViewController.swift
//  Transactions
//
//  Created by Jofin George on 30/03/21.
//

import UIKit
@objc
protocol SummaryTableViewControllerProtocol: NSObjectProtocol {
    func reloadTableView(_ details: [TransactionResponds])
    func failedResponds()
}

class SummaryTableViewController: UITableViewController {
    
    lazy var presenter = SummaryViewPresenter()
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var spinnerView: UIView!
    var transactions: [TransactionResponds]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Transactions"
        presenter.setView(self)
        presenter.fetchTransaction()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // Spinner
        spinnerView = UIView(frame: tableView.bounds)
        spinnerView.isUserInteractionEnabled = false
        spinnerView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        tableView.addSubview(spinnerView)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = UIColor.blue
        spinner.center.y = (spinnerView.frame.size.height - 88)/2
        spinner.center.x = spinnerView.center.x
        spinnerView.addSubview(spinner)
        
        showSpinner()
        
        // Refresh Controll
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }
    
    @objc func refresh(sender:AnyObject) {
        self.presenter.fetchTransaction()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactions?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as? SummaryTableViewCell else {
            return UITableViewCell()
        }
        let transact = self.transactions?[indexPath.row]
        cell.summaryLabel.text = transact?.summary
        if let credit = transact?.credit {
            cell.creditLabel.text = String(format: "+$%.2f", credit)
        }
        if let debit = transact?.debit {
            cell.debitLabel.text = String(format: "-$%.2f", debit)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = self.storyboard!.instantiateViewController(withIdentifier: "DetailView") as? TransactionDetailViewController {
            self.navigationController?.pushViewController(detailVC, animated: true)
            detailVC.details = self.transactions?[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // Spinner Actions
    func hideSpinner() {
        spinnerView.isHidden = true
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    
    func showSpinner() {
        spinnerView.isHidden = false
        spinner.isHidden = false
        spinner.startAnimating()
    }
}

extension SummaryTableViewController: SummaryTableViewControllerProtocol {
    
    func failedResponds() {
        DispatchQueue.main.async {
            self.hideSpinner()
            self.refreshControl?.endRefreshing()
            let alert = UIAlertController(title: "Alert", message: "Something went wrong please try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.showSpinner()
                self.presenter.fetchTransaction()
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                print("Cancelled")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func reloadTableView(_ details: [TransactionResponds]) {
        // Sort Transactions in alphabetical order
        self.transactions = self.presenter.sortTransactions(transactions: details)
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            self.hideSpinner()
        }
    }
    
    
}
