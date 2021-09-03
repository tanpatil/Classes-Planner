//
//  AllSportsTableViewController.swift
//  ORHS Classes
//
//  Created by Brian Qu on 6/10/20.
//  Copyright © 2020 Steven QU. All rights reserved.
//

import UIKit

class AllSportsTableViewController: UITableViewController {
    
    var reader = Reader()
    var sports = [Sports]()
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
    func getSports() {
        //add club data
        let sportArray = Bundle.main.urls(forResourcesWithExtension: "txt", subdirectory: "Sports")! as [URL]
        print(sportArray)
        
        for files: URL in sportArray {
            let data = reader.findData(fileURL: files)
            guard let new_sport = Sports(data: data, adds: false) else {
                fatalError("Unable to create class")
            }
            sports.append(new_sport)
        }
        func sortFunc(Sport1: Sports, Sport2: Sports) -> Bool {
            return Sport1.name < Sport2.name
        }
        sports.sort(by: sortFunc)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSports()
        tableView.tableFooterView = UIView(frame: .zero)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sports.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sportCells", for: indexPath) as? AllSportsTableViewCell else {
            fatalError("The dequeued cell is not an instance of ClassTableViewCell")
        }
        let sport = sports[indexPath.row]
        cell.textLabel?.text = sport.name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        return cell
        // Configure the cell...
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch(segue.identifier ?? "") {
                case "SportsDetails":
                    guard let SportDetail = segue.destination as? SportsDetailViewController else {
                        fatalError("Unexpected destination")

                    }
                    guard let selectedSportCell = sender as? AllSportsTableViewCell else {
                        fatalError("Unexpected sender")
                    }
                    guard let indexPath = tableView.indexPath(for: selectedSportCell) else {
                        fatalError("The selected cell is not being displayed by table")
                    }
                    SportDetail.sport = sports[indexPath.row]
        case "Homee":
            return
                default: fatalError("Unexpected Segue Identifier")
            }
        }
    

}
