//
//  TodoCell.swift
//  To_Do_App
//
//  Created by Mohamed Atallah on 04/11/2022.
//

import UIKit

class TodoCell: UITableViewCell {
    
    @IBOutlet weak var taskImageView: UIImageView!
    @IBOutlet weak var taskTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
