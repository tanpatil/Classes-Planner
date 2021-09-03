//
//  YearTableViewController.swift
//  ORHS Classes
//
//  Created by Steven QU on 6/12/18.
//  Copyright © 2018 Steven QU. All rights reserved.
//

import UIKit

class YearTableViewController: UITableViewController {
    
    
    @IBOutlet weak var Back: UIBarButtonItem!
    @IBAction func Back(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    //MARK: Properties
    let years = ["Freshman", "Sophomore", "Junior", "Senior"]
    static var schedules = [[Class](), [Class](), [Class](), [Class]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
        if let old = UserDefaults.standard.object(forKey: "savedList") as? [Double] {
            ChecklistTableViewController.current = old
        }
        let key = UserDefaults.standard.object(forKey: "savedSchedules")
        if key != nil {
            if let old = NSKeyedUnarchiver.unarchiveObject(with: key as! Data) as? [[Class]] {
            YearTableViewController.schedules = old
            }
        }
        else {
            print("no schedule saved")
        }
       
        
        
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "school logo")!)


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

    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.red
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.red
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "yearCells", for: indexPath) as? YearTableViewCell else {
            fatalError("The dequeued cell is not an instance of yearTableView")
        }
        cell.yearLabel.text = self.years[indexPath.row]
        cell.yearLabel.textAlignment = .center
        cell.yearLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 28.0)
        cell.layer.backgroundColor = UIColor.clear.cgColor
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
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "ShowSchedule":
            guard let ScheduleController = segue.destination as? ScheduleTableViewController else {
            fatalError("Unexpected deestination")
            }
            guard let selectedYearCell = sender as? YearTableViewCell else {
                fatalError("Unexpected sender")
            }
            guard let indexPath = tableView.indexPath(for: selectedYearCell) else {
                fatalError("The selected cell is not being displayed by table")
            }
            ScheduleController.classes = YearTableViewController.schedules[indexPath.row]
            ScheduleController.yearIndex = indexPath.row
        case "HomeScreen": return
        default: fatalError("Unexpected Segue Identifier")
        }
        
    }
    

}
