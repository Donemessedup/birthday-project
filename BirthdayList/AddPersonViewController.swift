//
//  AddTripViewController.swift
//  Pa7
//  This class is the view controller for adding a trip. Allows the user to add adestination, start date, and end date, and if all input is valid the trip will be added to the table view
//  CPSC 315-01, Fall 2020
//  No sources to cite
//  Created by Walker, Charles Milton on 11/5/20.
//  Copyright © 2020 Walker, Charles Milton. All rights reserved.
//

import UIKit
import CoreData

class AddPersonViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dateFormatter = DateFormatter()
    var friendOptional: Friend? = nil
    var tripNum: Int = 1
    let alert = UIAlertController(title: "Error", message: "Missing destination", preferredStyle: .alert)
    let startDateAlert = UIAlertController(title: "Error", message: "Invalid start date", preferredStyle: .alert)
    let endDateAlert = UIAlertController(title: "Error", message: "Invalid end date", preferredStyle: .alert)
    let continueAction = UIAlertAction(title: "Continue", style: .cancel, handler: nil)
    let addImageAlert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    var imageAdded = false
    var allCorrect = true
    var imageFileName = ""
    var image: UIImage? = nil
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var birthDateTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tripNumLabel.text = "Add Trip #" + String(tripNum)
        alert.addAction(continueAction)
        startDateAlert.addAction(continueAction)
        endDateAlert.addAction(continueAction)
        addImageAlert.addAction(continueAction)

    }

/*dismisses thew keyboard when the background is tapped */
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        print("background tapped")
        nameTextField.resignFirstResponder()
        birthDateTextField.resignFirstResponder()
    }
/*
 Creates and saves the new trip if all inpiut fields are valid
*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        friendOptional = Friend(context: self.context)
        dateFormatter.dateFormat = "MM/dd/yyyy"
            if let identifier = segue.identifier {
                if identifier == "SaveUnwindSegue" {
                    if let name = nameTextField.text, let birthDate = dateFormatter.date(from: birthDateTextField.text ?? "Unknown"){
                        if allCorrect {
                            if let friend = friendOptional {
                                friend.name = name
                                friend.birthday = birthDate
                            }
                                saveFriend()
                        }
                    }
                }
            }
        }
/*checks if all input is valid, if not then displays an alert
 */
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if allCorrect {
            return true
        }
        return false
    }
    

    func saveFriend() {
        // we want to save the context "to disk" (db)
        do {
            try context.save() // like git commit
        }
        catch {
            print("Error saving trips \(error)")
        }
    }
    
}
