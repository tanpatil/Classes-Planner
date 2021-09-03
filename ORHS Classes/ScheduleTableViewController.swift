//
//  ScheduleTableViewController.swift
//  ORHS Classes
//
//  Created by Steven QU on 6/22/18.
//  Copyright © 2018 Steven QU. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController {

    //MARK: Properties
    var classes = [Class]()
    var yearIndex: Int?
    let years = ["Freshman", "Sophomore", "Junior", "Senior"]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        classes = YearTableViewController.schedules[yearIndex!]
        tableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hiiiii")
        tableView.tableFooterView = UIView(frame: .zero)
        navigationItem.rightBarButtonItem = editButtonItem
        self.title = years[yearIndex!]
        
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return classes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("whhy")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCells", for: indexPath) as? ScheduleTableViewCell else {
            fatalError("The dequeued cell is not an instance of ScheduleTableViewCell")
        }
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 28.0)
        var index = indexPath.row
        cell.textLabel?.text = classes[index].name
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = self.classes[sourceIndexPath.row]
        classes.remove(at: sourceIndexPath.row)
        classes.insert(movedObject, at: destinationIndexPath.row)
        YearTableViewController.schedules[yearIndex!] = classes
        //YearTableViewController.schedules = [classes]
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: YearTableViewController.schedules)
        UserDefaults.standard.set(encodedData, forKey: "savedSchedules")
        debugPrint("\(sourceIndexPath.row) => \(destinationIndexPath.row)")
        // To check for correctness enable: self.tableView.reloadData()
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            YearTableViewController.schedules[yearIndex!].remove(at: indexPath.row)
            //update checklist
            ChecklistTableViewController.edit(classes[indexPath.row], false)
            // Delete the row from the data source
            classes[indexPath.row].added = false
            print("removed")
            classes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        print("hi")
        switch(segue.identifier ?? "") {
        case "test": guard let ClassController = segue.destination as? ScheduleDetailViewController else {
            fatalError("Unexpected deestination")
        }
        guard let selectedClassCell = sender as? ScheduleTableViewCell else {
            fatalError("Unexpected sender")
        }
        guard let indexPath = tableView.indexPath(for: selectedClassCell) else {
            fatalError("The selected cell is not being displayed by table")
        }
        ClassController.course = classes[indexPath.row]
        default: fatalError("Unexpected Segue Identifier")
        }
    }
    
    
    

}
