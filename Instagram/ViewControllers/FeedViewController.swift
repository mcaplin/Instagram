//
//  FeedViewController.swift
//  Instagram
//
//  Created by Michelle Caplin on 2/20/18.
//  Copyright © 2018 Michelle Caplin. All rights reserved.
//

import UIKit
import Parse

class FeedViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    var posts: [Post]! = []
    var tempImage =  UIImage()
    var refreshControl: UIRefreshControl!
    
    let CellIdentifier = "TableViewCell", HeaderViewIdentifier = "TableViewHeaderView"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        getPosts()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        tableView.insertSubview(refreshControl, at: 0)
        // Do any additional setup after loading the view.
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            //PFUser.current() = nil
            ///self.performSegue(withIdentifier: "logoutSegue", sender: nil)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.logout()
            
        }
        
    }
    
    
    @IBAction func onCamera(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        //vc.sourceType = UIImagePickerControllerSourceType.photoLibrary

        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onPhotos(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = .photoLibrary
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.tempImage = editedImage
        //temp.image = originalImage
        
        // Do something with the images (based on your use case)
        
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "makePost", sender: nil)
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let post = self.posts[indexPath.section]
        
        let postCaption = post.caption
        let postMedia = post.media
        
        cell.captionLabel.text = postCaption
    
        cell.postImage.file = postMedia
        cell.postImage.loadInBackground()
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderViewIdentifier) as! UITableViewHeaderFooterView
        let postUsername = posts[section].author.username
        let date = posts[section].createdAt! as Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let postDate = dateFormatter.string(from: date)
        header.textLabel?.text = (postUsername! + ", on " + postDate)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getPosts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "makePost" {
            let makePostViewController = segue.destination as! MakePostViewController
            makePostViewController.image = tempImage
        
        }
        if segue.identifier == "detailSegue" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let detailsViewController = segue.destination as! DetailsViewController
                let post = posts[indexPath.row]
                detailsViewController.post = post
                
            }
        }
    }
    
    func getPosts() {

        let query = Post.query()
        query?.includeKey("author")
        query?.addDescendingOrder("createdAt")
        query?.limit = 20
        query?.findObjectsInBackground { (posts, error) -> Void in
            if let posts = posts {
                self.posts = posts as! [Post]
                self.tableView.reloadData()
            } else {
                // handle error
                print ("no post")
            }
        }
        
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        
        getPosts()
        
            // Tell the refreshControl to stop spinning
        refreshControl.endRefreshing()
        
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
