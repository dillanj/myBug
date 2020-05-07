//
//  EditDetailController.swift
//  myBug
//
//  Created by Dillan Johnson on 10/18/19.
//  Copyright © 2019 Dillan Johnson. All rights reserved.
//

import UIKit

class EditDetailController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,                                                 UINavigationControllerDelegate  {
    var bug: Bug!
    var bugCage : BugCage!
    var imageStore: ImageStore!
    
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextView!
    @IBOutlet var qualitiesTextField: UITextView!
    @IBOutlet var imageView: UIImageView!
    
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
   
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.text = bug.name
        descriptionTextField.text = bug.bugDescription
        descriptionTextField.layer.cornerRadius = 5
        qualitiesTextField.text = bug.qualities
        qualitiesTextField.layer.cornerRadius = 5
        let key = bug.bugKey
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // dismiss keyboard on back button ( or anytime the view is about to disappear)
        view.endEditing(true)
        
        //"save" changes to bug
        bug.name = nameTextField.text ?? ""
        bug.bugDescription = descriptionTextField.text ?? ""
        bug.qualities = qualitiesTextField.text ?? ""
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
    

    @IBAction func selectPicture(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        // place the image picker on the screen modally
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
