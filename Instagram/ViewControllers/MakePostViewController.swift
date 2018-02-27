//
//  MakePostViewController.swift
//  Instagram
//
//  Created by Michelle Caplin on 2/25/18.
//  Copyright © 2018 Michelle Caplin. All rights reserved.
//

import UIKit
import Parse

class MakePostViewController: UIViewController {
    
    var image = UIImage()
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel.text = PFUser.current()?.username
        photo.image = image
        caption.text = ""

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func onPost(_ sender: Any) {
        //let post = Post()
        //let post = PFObject(className: "Post")
        let captionText = caption.text ?? "no caption (this is temporary)"
        //post.author = PFUser.current()
        //query.includeKey("author")
        
        Post.postUserImage(image: image, withCaption: captionText) { (success, error) in
            if success {
                print("The message was saved!")
                
                self.dismiss(animated: true, completion: nil)
            }
            else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
        
        
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
