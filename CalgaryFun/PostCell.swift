//
//  PostCell.swift
//  CalgaryFun
//
//  Created by Steve Mecking on 2016-12-13.
//  Copyright © 2016 Steve Mecking. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postAddress: UILabel!
    @IBOutlet weak var viewmapImage: UIImageView!
}
