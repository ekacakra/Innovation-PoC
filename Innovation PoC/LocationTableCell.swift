//
//  LocationTableCell.swift
//  Innovation PoC
//
//  Created by C1MNC7DMDTY3 on 5/11/15.
//  Copyright (c) 2015 Photon Interactive. All rights reserved.
//

import UIKit

class LocationTableCell: UITableViewCell {
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
