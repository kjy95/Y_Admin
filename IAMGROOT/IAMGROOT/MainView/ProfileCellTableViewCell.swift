//
//  ProfileCellTableViewCell.swift
//  IAMGROOT
//
//  Created by 김지영 on 18/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit

class ProfileCellTableViewCell: UITableViewCell {

    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var waterF: UILabel!
    @IBOutlet weak var potF: UILabel!
    @IBOutlet weak var placeF: UILabel!
    @IBOutlet weak var pid: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func showDetailButton(_ sender: Any) {
        print((sender as AnyObject).tag)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
