//
//  SearchPlantsTableViewCell.swift
//  IAMGROOT
//
//  Created by 김지영 on 14/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit

class SearchPlantsTableViewCell: UITableViewCell {

    @IBOutlet weak var PlantName: UILabel!
    @IBOutlet weak var explanation: UILabel!
    @IBOutlet weak var frequency: UILabel!
    @IBOutlet weak var pid: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
