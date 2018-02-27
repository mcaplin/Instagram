//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by Michelle Caplin on 2/20/18.
//  Copyright © 2018 Michelle Caplin. All rights reserved.
//

import UIKit
import Parse
import ParseUI


class PostCell: UITableViewCell {
    

    @IBOutlet weak var postImage: PFImageView!
    var post = Post()
    @IBOutlet weak var captionLabel: UILabel!
    /*var instagramPost: PFObject! {
        didSet {
            self.postImage.file = instagramPost["media"] as? PFFile
            self.postImage.loadInBackground()
        }
    }*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
