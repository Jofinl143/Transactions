//
//  SummaryTableViewCell.swift
//  Transactions
//
//  Created by Jofin George on 30/03/21.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var debitLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
