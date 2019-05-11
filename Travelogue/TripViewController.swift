//
//  TripViewController.swift
//  Travelogue
//
//  Created by Ryan Rottmann on 5/10/19.
//  Copyright © 2019 Ryan Rottmann. All rights reserved.
//

import UIKit

class TripViewController: UIViewController {

    @IBOutlet weak var tripTitleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createTrip(_ sender: Any) {
  
        let title = Trip(tripTitle: tripTitleTextField.text ?? "")
        do {
            let managedContext = title?.managedObjectContext
            try title?.managedObjectContext?.save()
        } catch{
            alertNotifyUser(message: "The title could not be saved")
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
