//
//  ChecklistTableViewController.swift
//  ORHS Classes
//
//  Created by Steven QU on 6/3/19.
//  Copyright © 2019 Steven QU. All rights reserved.
//

import UIKit

class ChecklistTableViewController: UITableViewController {

    @IBOutlet weak var Home: UIBarButtonItem!
    @IBAction func Home(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
    }
    
    
    //MARK: properties
    var GPA = 0.0
    static let requirements = [("English", 4.0), ("Math", 4.0), ("Science", 3.0), ("World Languages", 2.0), ("Fine Arts", 1.0), ("U.S. History", 1.0), ("World History/Geography", 1.0), ("Economics", 0.5), ("U.S. Government", 0.5), ("Personal Finance", 0.5), ("Wellness", 1.5)]
    static var current = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

    @IBOutlet weak var ResetButton: UIBarButtonItem!
    
    @IBAction func ResetButton(_ sender: UIBarButtonItem) {
            // Declare Alert message
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to reset your schedules?", preferredStyle: .alert)
            
        // Create OK button with action handler
        let Yes = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            print("Yes button tapped")
            ChecklistTableViewController.current = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
            UserDefaults.standard.set(ChecklistTableViewController.current, forKey: "savedList")
            YearTableViewController.schedules = [[Class](), [Class](), [Class](), [Class]()]
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: YearTableViewController.schedules)
            UserDefaults.standard.set(encodedData, forKey: "savedSchedules")
            self.tableView.reloadData()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        //Add Yes and Cancel button to dialog message
        dialogMessage.addAction(Yes)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
        tableView.reloadData()
    }

        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        var count = 0.0
//        var temp = 0.0
//        for Classes in YearTableViewController.schedules {
//            for Class in Classes {
//                count += Double(Class.credits)!
//                temp += Double(Class.credits)! * Double(Class.GPA)!
//            }
//        }
//        GPA = temp/count
//        print(GPA)
//        GPALabel.text = String(GPA)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ChecklistTableViewController.requirements.count+1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "requirementCell", for: indexPath) as? ChecklistTableViewCell else {
            fatalError("The dequeued cell is not an instance of requirementCell")
        }
        //This makes a GPA label. If you are going to use this again, make sure to change let num = indexPath.row to num = indexPath.row - 1 (the code below). Also, make return ChecklistTableViewController.requirements.count into return ChecklistTableViewController.requirements.count + 1(in tableView func above). Finally, uncomment the stuff below, the code in viewWillAppear, and the part that makes the variable "GPA".
        if indexPath.row == 0 {
            var gpa = 0.0
            let gradesCP = [4.0, 3.0, 2.0, 1.0, 0.0]
            let gradesHonors = [4.5,3.5,2.5,1.5,0.0]
            let gradesAP = [5.0, 4.0, 3.0, 2.0, 0.0]
            let gradesAdvanced = [4.25,3.25,2.25,1.25,0.0]
            var count = 0.0
            for year in YearTableViewController.schedules {
                for classes in year {
                    let defaults = UserDefaults.standard
                    let grade = defaults.integer(forKey: classes.name)
                    count += Double(classes.credits)!
                    if Double(classes.GPA) == 5.0 {
                        gpa += gradesAP[grade]*Double(classes.credits)!
                    }
                    else if Double(classes.GPA) == 4.5 {
                        gpa += gradesHonors[grade]*Double(classes.credits)!
                    }
                    else if Double(classes.GPA) == 4.25 {
                        gpa += gradesAdvanced[grade]*Double(classes.credits)!
                    }
                    else if Double(classes.GPA) == 4.0 {
                        gpa += gradesCP[grade]*Double(classes.credits)!
                    }
                }
            }
            var realGPA = gpa/count
            cell.textLabel?.text = "GPA"
            if realGPA.isNaN {
                cell.completionLabel.text = String(0.0)
                cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
                cell.completionLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
                return cell
            }
            cell.completionLabel.text = String(realGPA)
            cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            cell.completionLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
            return cell
        }
        let num = indexPath.row-1
        cell.textLabel?.text = ChecklistTableViewController.requirements[num].0 //puts name of requirement
        if(ChecklistTableViewController.current[num] >= ChecklistTableViewController.requirements[num].1) {
//            cell.accessoryType = UITableViewCellAccessoryType.checkmark
            cell.textLabel?.textColor = UIColor(red:0, green: 0.7, blue: 0, alpha: 1.0)
            cell.completionLabel.textColor = UIColor(red:0, green: 0.7, blue: 0, alpha: 1.0)
        }
        else {
            //cell.accessoryType = UITableViewCellAccessoryType.none
            cell.textLabel?.textColor = UIColor(red:0, green: 0, blue: 0, alpha: 1.0)
            cell.completionLabel.textColor = UIColor(red:0, green: 0, blue: 0, alpha: 1.0)
        }
        
        
        cell.completionLabel.textAlignment = .center
        let temp = ChecklistTableViewController.current[num]
        cell.completionLabel.text = "(\(temp)/\(ChecklistTableViewController.requirements[num].1))" //keeps track of how many completed in a box

        return cell
    }
    
    //edits the checklist
    static func edit(_ course:Class, _ add:Bool) {
        //this is wrong we need the real graduation credit subject fix later
        let index = convert(course.subject)
        if course.subject == "Other" {
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: YearTableViewController.schedules)
            UserDefaults.standard.set(encodedData, forKey: "savedSchedules")
            return
        }
        if course.subject == "Career Academies" {
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: YearTableViewController.schedules)
            UserDefaults.standard.set(encodedData, forKey: "savedSchedules")
            return
        }
        if add == false {
            ChecklistTableViewController.current[index] -= Double(course.credits)!
            return
        }
        if (ChecklistTableViewController.current[index] < 0.0) {
            ChecklistTableViewController.current[index] = 0.0
        }
        else {
            print(index)
            print(ChecklistTableViewController.current.count)
            ChecklistTableViewController.current[index] += Double(course.credits)!
            if course.name == "AP United States Government & Politics" {
                ChecklistTableViewController.current[9] += Double(course.credits)!
            }
        }
        UserDefaults.standard.set(ChecklistTableViewController.current, forKey: "savedList")
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: YearTableViewController.schedules)
        UserDefaults.standard.set(encodedData, forKey: "savedSchedules")
        print(YearTableViewController.schedules)
        
        
    }
    
    
    static func convert(_ oldNum:String) -> Int{
        print(oldNum)
        var num = -1
        var index = 0
        for tuples in requirements{
            if (oldNum == tuples.0) {
                num = index
                break
            }
            index += 1
        }
        if (num < 0) {
            print("subject not found")
        }
        print("num \(num)")
        return num
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        switch(segue.identifier ?? "") {
        case "goinHome":
            return
        default: fatalError("Unexpected segue identifier")
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    //attempted to restore state
//    override func encodeRestorableState(with coder: NSCoder) {
//        coder.encode(ChecklistTableViewController.current, forKey: "credits")
//        super.encodeRestorableState(with: coder)
//    }
//
//    override func decodeRestorableState(with coder: NSCoder) {
//        ChecklistTableViewController.current = coder.decodeObject(forKey: "credits") as! [Double]
//        super.decodeRestorableState(with: coder)
//    }
//
//    override func applicationFinishedRestoringState() {
//
//    }
}
