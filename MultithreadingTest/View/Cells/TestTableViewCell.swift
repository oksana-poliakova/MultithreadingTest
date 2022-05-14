//
//  TestTableViewCell.swift
//  MultithreadingTest
//
//  Created by Oksana Poliakova on 14.05.2022.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(text: String) {
        titleLabel.text = text
        
    }

}
