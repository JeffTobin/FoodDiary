//
//  MealViewController.swift
//  Food Diary
//
//  Created by Jeff Tobin on 12/7/16.
//  Copyright © 2016 Jeff Tobin. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    //declerations
    @IBOutlet weak var titleBar: UINavigationItem!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    let pickedImage = UIImagePickerController()
    var meal : Meal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickedImage.delegate      = self
        descriptionField.delegate = self
        
        //retrive data before displaying
        descriptionField.text = meal?.mealDescription
        imageView.image       = meal?.mealImage
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        let photo = imageView.image
        let details = descriptionField.text
        
        //save data before exiting
        meal?.mealImage       = photo!
        meal?.mealDescription = details!
    }
    
    //presents photo library when clicked
    @IBAction func photoTapHandler(_ sender: UITapGestureRecognizer) {
        pickedImage.allowsEditing = false
        pickedImage.sourceType = .photoLibrary
        present(pickedImage, animated: true, completion: nil)
    }
    
    //selects image and returns it to app
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage]
        imageView.image = image as? UIImage
        dismiss(animated: true, completion: nil)
    }
    
    //image selection cancled
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //collapses keyboard
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            view.endEditing(true)
        }
        return true
    }
}
