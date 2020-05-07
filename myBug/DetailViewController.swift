//
//  DetailViewController.swift
//  myBug
//
//  Created by Dillan Johnson on 10/18/19.
//  Copyright © 2019 Dillan Johnson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var bug: Bug!
    var imageStore: ImageStore!
    
    @IBOutlet var bugImage: UIImageView!
    @IBOutlet var nameLabel: UILabel!
   
    @IBOutlet var bugDescription: UITextView!
    @IBOutlet var bugQualities: UITextView!
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameLabel.text = bug.name
        bugDescription.text = bug.bugDescription
        bugDescription.layer.cornerRadius = 5
        bugQualities.text = bug.qualities
        bugQualities.layer.cornerRadius = 5
        
        let key = bug.bugKey
        
        // if there is an associated image with the bug
        //  display it on the image view
        
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
        
    } // end of viewWillAppear
    
   
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "editDetails"?:
                // get the bug associated with this row and pass it along
                let editDetailViewController = segue.destination as! EditDetailController
                editDetailViewController.bug = bug
                editDetailViewController.imageStore = imageStore
            
        default:
            preconditionFailure("Unexpected segue identifier")
        }// end of switch
    }//end of prepare()
    
    
    
    
    
    
    
    
    
}
