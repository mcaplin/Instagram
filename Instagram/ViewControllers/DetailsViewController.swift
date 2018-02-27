//
//  DetailsViewController.swift
//  Instagram
//
//  Created by Michelle Caplin on 2/26/18.
//  Copyright © 2018 Michelle Caplin. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DetailsViewController: UIViewController {

    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var postImage: PFImageView!
    var post = Post()
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameLabel.text = post.author.username
        captionLabel.text = post.caption
        postImage.file = post.media
        postImage.loadInBackground()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
