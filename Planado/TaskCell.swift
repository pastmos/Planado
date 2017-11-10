//
//  TaskCell.swift
//  Planado
//
//  Created by Past on 10.11.2017.
//  Copyright © 2017 LateraSoft. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var taskCompletedImage: UIImageView!
    @IBOutlet weak var taskText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        //Configure the view for the selected state

    }

    
}
