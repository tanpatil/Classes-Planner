//
//  ClassTableViewController.swift
//  ORHS Classes
//
//  Created by Steven QU on 5/30/18.
//  Copyright © 2018 Steven QU. All rights reserved.
//

import UIKit

class ClassTableViewController: UITableViewController {
    //MARK: Properties
    var classes = [Class]()
    var reader = Reader()
    //this value is passed from previous controller
    var subject: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        makeClasses()
        for Classes in classes {
            if Classes.name == "English 9 Honors" {
                if let index = classes.firstIndex(of: Classes) {
                    classes.remove(at: index)
                }
                classes.insert(Classes, at: 4)
            }
            if Classes.name == "English 9 CP" {
                if let index = classes.firstIndex(of: Classes) {
                    classes.remove(at: index)
                }
                classes.insert(Classes, at: 3)
            }
            if Classes.name == "English 9 Workshop" {
                if let index = classes.firstIndex(of: Classes) {
                    classes.remove(at: index)
                }
                classes.insert(Classes, at: 5)
            }
        }
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
        return classes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "classCells", for: indexPath) as? ClassTableViewCell else {
            fatalError("The dequeued cell is not an instance of ClassTableViewCell")
        }
        let currentClass = classes[indexPath.row]
        cell.textLabel?.text = currentClass.name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
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
        switch(segue.identifier ?? "") {
            
        case "ShowDetail": guard let ClassDetail = segue.destination as? ClassDetailViewController else {
            fatalError("Unexpected deestination")
        }
        guard let selectedClassCell = sender as? ClassTableViewCell else {
            fatalError("Unexpected sender")
        }
        guard let indexPath = tableView.indexPath(for: selectedClassCell) else {
            fatalError("The selected cell is not being displayed by table")
        }
        let selectedClass = classes[indexPath.row]
        ClassDetail.course = selectedClass
        ClassDetail.subject = subject
        default: fatalError("Unexpected Segue Identifier")
        }
    }
    
    
    //MARK: functions
    func makeClasses() {
        let classesArray = Bundle.main.urls(forResourcesWithExtension: "txt", subdirectory: "Classes/\(subject!)")! as [URL]
        print("JOoooo")
        print(classesArray)
        for files: URL in classesArray {
            let data = reader.findData(fileURL: files)
            guard let newClass = Class(data: data, added: false, grade: 0) else {
                fatalError("Unable to create class")
            }
            classes.append(newClass)
        }
        func cmp(c1: Class, c2: Class) -> Bool {
            return c1.name < c2.name
        }
        classes.sort(by: cmp)
    }

}
