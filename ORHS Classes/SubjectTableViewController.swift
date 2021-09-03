//
//  SubjectTableViewController.swift
//  ORHS Classes
//
//  Created by Steven QU on 5/29/18.
//  Copyright © 2018 Steven QU. All rights reserved.
//

import UIKit

class SubjectTableViewController: UITableViewController {
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
    //MARK: Properties
    struct subjectList {
        static  let subjects = ["Career Academies", "Economics", "English", "Fine Arts", "Math", "Other", "Personal Finance", "Science", "U.S. Government", "U.S. History", "Wellness", "World History:Geography", "World Languages"]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: .zero)

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
        return subjectList.subjects.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCells", for: indexPath) as? SubjectTableViewCell else {
            fatalError("The dequeued cell is not an instance of SubjectTableViewCell")
        }
        cell.subjectLabel.text = subjectList.subjects[indexPath.row]
        cell.subjectLabel.textAlignment = .center
        cell.subjectLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 28.0)

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
        case "ShowClasses": guard let ClassTableViewController = segue.destination as? ClassTableViewController else {
            fatalError("Unexpected deestination")
        }
        guard let selectedSubjectCell = sender as? SubjectTableViewCell else {
            fatalError("Unexpected sender")
        }
        guard let indexPath = tableView.indexPath(for: selectedSubjectCell) else {
            fatalError("The selected cell is not being displayed by table")
        }
        let selectedSubject = subjectList.subjects[indexPath.row]
        ClassTableViewController.subject = selectedSubject
        print(selectedSubject)
        case "goesHome":
            return
        default: fatalError("Unexpected Segue Identifier")
        }
    }
    

}
