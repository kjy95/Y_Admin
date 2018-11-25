//
//  FriendsTableViewCell.swift
//  IAMGROOT
//
//  Created by 김지영 on 26/11/2018.
//  Copyright © 2018 김지영. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    @IBOutlet weak var FriendName: UILabel!
    @IBOutlet weak var placeF: UILabel!
    @IBOutlet weak var pid: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
