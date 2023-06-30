//
//  OptionTableViewCell.swift
//  Radius Agent
//
//  Created by Ravindra Arya on 28/06/23.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    @IBOutlet weak var checkBoxIcon: UIImageView!
    @IBOutlet weak var cellButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
