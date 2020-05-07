//
//  addBugController.swift
//  myBug
//
//  Created by Dillan Johnson on 10/23/19.
//  Copyright © 2019 Dillan Johnson. All rights reserved.
//

import UIKit

class addBugController: UIViewController, UITextFieldDelegate,
                        UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var bug = Bug()
    var bugCage : BugCage!
    var imageStore: ImageStore!
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextView!
    @IBOutlet var qualitiesTextField: UITextView!
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func selectPicture(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        // place the image picker on the screen modally
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func addBug(_ sender: UIButton ){
        // append if there aren't empty values, and if it isn't already there
        // TODO: ADD CHECKS FOR EMPTY
        bugCage.allBugs.append(bug)
        navigationController?.popViewController(animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // Get picked image from info dictionary
        let image = info[.originalImage] as! UIImage
        
        //Store the image in the ImageStore for the bug's key
        imageStore.setImage(image, forKey: bug.bugKey)
        
        // Put that image on the screen in the image view
        imageView.image = image
        
        // Take image picker off the screen -
        // you must call this dismiss method
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        descriptionTextField.layer.cornerRadius = 5
        qualitiesTextField.layer.cornerRadius = 5
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // dismiss keyboard on back button ( or anytime the view is about to disappear)
        view.endEditing(true)
        //"save" changes to bug
        //TODO: do validation checking before saving
        bug.name = nameTextField.text ?? ""
        bug.bugDescription = descriptionTextField.text ?? ""
        bug.qualities = qualitiesTextField.text ?? ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "saveBug"?:
            let bugListController = segue.destination as! BugListController
            bugListController.bugCage = bugCage
            bugListController.imageStore = imageStore
            
        default:
            preconditionFailure("Unexpected segue identifier")
        }// end of switch
    }//end of prepare()
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
