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
    let alert = UIAlertController(title: "Error", message: "Missing Name", preferredStyle: .alert)
    let dateAlert = UIAlertController(title: "Error", message: "Invalid date", preferredStyle: .alert)
    let continueAction = UIAlertAction(title: "Continue", style: .cancel, handler: nil)

    var allCorrect = true

   
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var birthDateTextField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var interest1TextField: UITextField!
    @IBOutlet var interest2TextField: UITextField!
    @IBOutlet var interest3TextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        alert.addAction(continueAction)
        dateAlert.addAction(continueAction)
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
                    if let name = nameTextField.text, let birthDate = dateFormatter.date(from: birthDateTextField.text ?? "Unknown"), let interest1 = interest1TextField.text, let interest2 = interest2TextField.text, let interest3 = interest3TextField.text{
                        if allCorrect {
                            if let friend = friendOptional {
                                friend.name = name
                                friend.birthday = birthDate
                                friend.interests = "\(interest1)* \(interest2)* \(interest3)"
                                print(friend.interests!)
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
        checkDest()
        if allCorrect {
            return true
        }
        return false
    }
    
    func checkDest(){
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: birthDateTextField.text ?? "Unknown")
        if nameTextField.text == "" {
            present(alert,animated: true)
            allCorrect = false
            return
        }
        if date == nil {
            present(dateAlert, animated: true)
            allCorrect = false
            return
        }

        allCorrect = true
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
