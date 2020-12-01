//
//  ViewController.swift
//  BirthdayList
//
//  Created by Miller, Aaron Paul on 11/29/20.
//

//
//  TripTableViewController.swift
//  Pa7
//  This program runs an app where the user can add trips to a list, all with destination names, start date, end date. The user can also add an image from a photo library or from camera to each trip. The trips are saved to a database and are retrieved when the app is loaded again.
//  CPSC 315-01, Fall 2020
//  No sources to cite
//  Created by Walker, Charles Milton on 11/5/20.
//  Copyright © 2020 Walker, Charles Milton. All rights reserved.
//

import UIKit
import CoreData

class BdayTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let dateFormatter = DateFormatter()
    var friends = [Friend]()
    
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print(documentsDirectoryURL)
        loadFriends()

    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return friends.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let friend = friends[row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath) as! PersonTableViewCell
        
        cell.update(with: friend)
        
        cell.showsReorderControl = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let friend = friends.remove(at: sourceIndexPath.row)
        friends.insert(friend, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
    // MARK: Lab #20
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            context.delete(friends[indexPath.row])
            
            // persist the deletion by saving the context
            saveFriends()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "DetailSegue" {
                if let personDetailVC = segue.destination as? PersonDetailViewController {
                    // we need to get the indexPath for the row the user clicked on
                    // we need to get the trip at the row
                    // pass the trip into detailDetailVC
                    if let indexPath = tableView.indexPathForSelectedRow {
                        let friend = friends[indexPath.row]
                        personDetailVC.totalNumTrips = friends.count
                        personDetailVC.friendIndex = indexPath.row + 1
                        personDetailVC.friendOptional = friend
                    }
                }
            }
            else if identifier == "AddSegue" {
                if let addPersonVC = segue.destination as? AddPersonViewController {
                    if let indexPath = tableView.indexPathForSelectedRow {
                        tableView.deselectRow(at: indexPath, animated: true)
                        addPersonVC.tripNum = friends.count + 1
                    }
                }
            }
        }
    }
    
    @IBAction func unwindToTripTableViewController(segue: UIStoryboardSegue) {
        if let identifier = segue.identifier {
            if identifier == "SaveUnwindSegue" {
                if let addPersonVC = segue.source as? AddPersonViewController {
                    if let friend = addPersonVC.friendOptional {
                        // get the currently selected index path
                        if let indexPath = tableView.indexPathForSelectedRow {
                            friends[indexPath.row] = friend
                        }
                        else {
                            // we are undwinding from an AddSegue
                            
                            friends.append(friend)
                        }
                        // force update the table view
                        self.saveFriends()
                        tableView.reloadData()
                    }
                }
            }
        }
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
           let newEditingMode = !tableView.isEditing
           tableView.setEditing(newEditingMode, animated: true)
       }
    
    // READ of CRUD
    func loadFriends() {
        // we need to make a "request" to get the Category objects
        // via the persistent container
        let request: NSFetchRequest<Friend> = Friend.fetchRequest()
        // with a sql SELECT statement we usually specify a WHERE clause if we want to filter rows from the table we are selecting from
        // if we want to filter, we need to add a "predicate" to our request... we will do this later for Items
        do {
            friends = try context.fetch(request)
        }
        catch {
            print("Error loading categories \(error)")
        }
        tableView.reloadData()
    }
    
    func saveFriends() {
        // we want to save the context "to disk" (db)
        do {
            try context.save() // like git commit
        }
        catch {
            print("Error saving trips \(error)")
        }
    }
    
}



