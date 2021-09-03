//
//  ClubDetailsViewController.swift
//  ORHS Classes
//
//  Created by Brian Qu on 6/3/20.
//  Copyright © 2020 Steven QU. All rights reserved.
//

import UIKit

class ClubDetailsViewController: UIViewController {
    var club: Club?
    @IBOutlet weak var meetingDays: UITextView!
    @IBOutlet weak var meetingTimes: UITextView!
    @IBOutlet weak var website: UITextView!
    @IBOutlet weak var desciption: UITextView!
    @IBOutlet weak var addClub: UIBarButtonItem!
    @IBOutlet weak var Flexibility: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for clubs in CurrentClubsTableViewController.currentClubs {
            if clubs.name == club!.name {
                addClub.isEnabled = false
                return
            }
        }
        addClub.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loading club data")
        self.title = club?.name
        meetingDays.text = "Meeting Location: \(club!.days)"
        meetingTimes.text = "Meeting Times: \(club!.times)"
        website.text = "Announcements: \(club!.link)"
        Flexibility.text = "Sponsors: \(club!.commitment)"
        desciption.text = club!.summary
        meetingDays.sizeToFit()
        meetingTimes.sizeToFit()
        website.sizeToFit()
        desciption.sizeToFit()
        Flexibility.sizeToFit()
        for clubs in CurrentClubsTableViewController.currentClubs {
            if clubs.name == club!.name {
                addClub.isEnabled = false
            }
        }
        print(club!.name)
        print(club!.add)
    }
    
    
    @IBAction func favoriteClub(_ sender: UIBarButtonItem) {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want add this club to your favorites?", preferredStyle: .alert)
        // Create OK button with action handler
        let Yes = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            print("Yes button tapped")
            self.addClub.isEnabled = false
            self.club!.add = true
            CurrentClubsTableViewController.currentClubs.append(self.club!)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: CurrentClubsTableViewController.currentClubs)
            UserDefaults.standard.set(encodedData, forKey: "savedClubs")
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
    }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



