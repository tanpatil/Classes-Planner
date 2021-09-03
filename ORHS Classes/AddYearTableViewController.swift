//
//  AddYearTableViewController.swift
//  ORHS Classes
//
//  Created by Steven QU on 6/21/18.
//  Copyright © 2018 Steven QU. All rights reserved.
//

import UIKit

class AddYearTableViewController: UITableViewController {

    //MARK: Properties
    let years = ["Freshman", "Sophomore", "Junior", "Senior"]
    var tempCourse: Class?
    var count = 0
    var repeated = [] as [String]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        //ClassDetailViewController.dialog = false
        print(YearTableViewController.schedules)
        for schedules in YearTableViewController.schedules {
            for classes in schedules {
                //ClassDetailViewController.dialog = false
                if (classes.name == tempCourse!.name) {
                    if schedules == YearTableViewController.schedules[0] {
                        count = 0
                        repeated.append(years[0])
                    }
                    if schedules == YearTableViewController.schedules[1] {
                        count = 1
                        repeated.append(years[1])
                    }
                    if schedules == YearTableViewController.schedules[2] {
                        count = 2
                        repeated.append(years[2])
                    }
                    if schedules == YearTableViewController.schedules[3] {
                        count = 3
                        repeated.append(years[3])
                    }
                    print(count)
                    print(repeated)
                    let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to add this to your schedules again?", preferredStyle: .alert)
                    // Create OK button with action handler
                    let Yes = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
                        print("Yes button tapped")
                        //ClassDetailViewController.dialog = false
                        
                    })
                    
                    // Create Cancel button with action handlder
                    let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
                        print("Cancel button tapped")
                        //ClassDetailViewController.dialog = true
                        self.performSegue(withIdentifier: "unwindSegueToClassDetailViewController", sender: self)
                    }
                    
                    
                    //Add Yes and Cancel button to dialog message
                    dialogMessage.addAction(Yes)
                    dialogMessage.addAction(cancel)
                    
                    self.present(dialogMessage, animated: true, completion: nil)
                }
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "yearCells2", for: indexPath) as? AddYearTableViewCell else {
            fatalError("The dequeued cell is not an instance of yearTableView")
        }
        cell.yearLabel.text = self.years[indexPath.row]
        cell.yearLabel.textAlignment = .center
        cell.yearLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 28.0)
        if count < 0 {
            count = 0
        }
        print(repeated)
        
        if repeated.contains(cell.yearLabel.text!) {
            cell.isUserInteractionEnabled = false
            cell.textLabel!.isEnabled = false
        }
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") { //this is bad, need to create unwind
        case "SaveClass":
        guard let selectedCell = sender as? AddYearTableViewCell else {
            fatalError("Unexpected sender")
        }
        guard let indexPath = tableView.indexPath(for: selectedCell) else {
            fatalError("The selected cell is not being displayed by table")
        }
        YearTableViewController.schedules[indexPath.row].append(tempCourse!)
        default: print("cancelled")
        }
     }
    
    //MARK: Actions
    @IBAction func cancelSaveClass(_ sender: Any) {
        performSegue(withIdentifier: "unwindSegueToClassDetailViewController", sender: self)
    }
    
    
}
