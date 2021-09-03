//
//  CurrentSportsTableViewController.swift
//  ORHS Classes
//
//  Created by Brian Qu on 6/10/20.
//  Copyright © 2020 Steven QU. All rights reserved.
//

import UIKit

class CurrentSportsTableViewController: UITableViewController {
    static var currentSports = [Sports]()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    @IBOutlet weak var Back: UIBarButtonItem!
    @IBAction func Back(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        navigationItem.rightBarButtonItem = editButtonItem
        let key = UserDefaults.standard.object(forKey: "savedSports")
         if key != nil {
            if let old = NSKeyedUnarchiver.unarchiveObject(with: key as! Data) as? [Sports] {
                CurrentSportsTableViewController.currentSports = old
            }
        }
        print(CurrentSportsTableViewController.currentSports)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CurrentSportsTableViewController.currentSports.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "currSports", for: indexPath) as? CurrentSportsTableViewCell else {
            fatalError("The dequeued cell is not an instance of ClassTableViewCell")
        }
        let sport = CurrentSportsTableViewController.currentSports[indexPath.row]
        print(sport.name)
        cell.textLabel?.text = sport.name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        
        
        return cell
        // Configure the cell...
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                // Delete the row from the data source
            CurrentSportsTableViewController.currentSports.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: CurrentSportsTableViewController.currentSports)
                UserDefaults.standard.set(encodedData, forKey: "savedSports")
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view

        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = CurrentSportsTableViewController.self.currentSports[sourceIndexPath.row]
        CurrentSportsTableViewController.currentSports.remove(at: sourceIndexPath.row)
        CurrentSportsTableViewController.currentSports.insert(movedObject, at: destinationIndexPath.row)
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: CurrentSportsTableViewController.currentSports)
        UserDefaults.standard.set(encodedData, forKey: "savedSports")
        debugPrint("\(sourceIndexPath.row) => \(destinationIndexPath.row)")
        // To check for correctness enable: self.tableView.reloadData()
    }
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
            case "ShowSportDetails": guard let ClassController = segue.destination as? SportsDetailViewController else {
                fatalError("Unexpected destination")
                }
                guard let selectedClassCell = sender as? CurrentSportsTableViewCell else {
                fatalError("Unexpected sender")
                }
                guard let indexPath = tableView.indexPath(for: selectedClassCell) else {
                fatalError("The selected cell is not being displayed by table")
                }
                ClassController.sport = CurrentSportsTableViewController.currentSports[indexPath.row]
        case "Homes":
            return
            default: fatalError("Unexpected Segue Identifier")
        }
    }

}
