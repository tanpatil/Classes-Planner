//
//  AllClubsTableViewController.swift
//  ORHS Classes
//
//  Created by Brian Qu on 6/2/20.
//  Copyright © 2020 Steven QU. All rights reserved.
//

import UIKit

class AllClubsTableViewController: UITableViewController {
    @IBOutlet weak var Homes: UIBarButtonItem!
    @IBAction func Homes(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
    }
    
    // MARK: Properties
    var reader = Reader()
    var clubs = [Club]()
    func getClubs() {
        //add club data
        let clubArray = Bundle.main.urls(forResourcesWithExtension: "txt", subdirectory: "Clubs")! as [URL]
        
        for files: URL in clubArray {
            let data = reader.findData(fileURL: files)
            guard let new_club = Club(data: data, add: false) else {
                fatalError("Unable to create class")
            }
            clubs.append(new_club)
        }
        func sortFunc(Club1: Club, Club2: Club) -> Bool {
            return Club1.name < Club2.name
        }
        clubs.sort(by: sortFunc)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getClubs()
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
        return clubs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "clubCells", for: indexPath) as? AllClubsTableViewCell else {
            fatalError("The dequeued cell is not an instance of ClassTableViewCell")
        }
        let club = clubs[indexPath.row]
        cell.textLabel?.text = club.name
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        return cell
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
        switch(segue.identifier ?? "") {
            case "ClubDetail":
                guard let ClubDetail = segue.destination as? ClubDetailsViewController else {
                    fatalError("Unexpected destination")

                }
                guard let selectedClubCell = sender as? AllClubsTableViewCell else {
                    fatalError("Unexpected sender")
                }
                guard let indexPath = tableView.indexPath(for: selectedClubCell) else {
                    fatalError("The selected cell is not being displayed by table")
                }
                ClubDetail.club = clubs[indexPath.row]
        case "Homes":
            return
            default: fatalError("Unexpected Segue Identifier")
        }
    }

}
