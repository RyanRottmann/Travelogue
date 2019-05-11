//
//  EntryViewController.swift
//  Travelogue
//
//  Created by Ryan Rottmann on 5/10/19.
//  Copyright © 2019 Ryan Rottmann. All rights reserved.
//

import UIKit
import CoreData

class EntryViewController: UIViewController {

    @IBOutlet weak var entryTitleTextField: UITextField!
    
    @IBOutlet weak var entryDate: UIDatePicker!
    @IBOutlet weak var entryDescriptionTextField: UITextField!
    let imagePicker = UIImagePickerController()
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let entry = entry {// I am not sure why data is not being re loaded on EntryViewController
            entryTitleTextField.text = entry.entryTitle
        } else{
            entryTitleTextField.text = ""
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("camera not supported by this device")
            return
        }
        imagePicker.sourceType = .camera

    }
    
    @IBAction func selectPhotoFromLibrary(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func addEntry(_ sender: Any) {
        
        let title = Entry(entryTitle: entryTitleTextField.text ?? "")
        do {
            let managedContext = title?.managedObjectContext
            try title?.managedObjectContext?.save()
        } catch{
            alertNotifyUser(message: "The entry could not be saved")
        }
        
        navigationController?.popViewController(animated: true)
        
        
    }
    func alertNotifyUser(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
