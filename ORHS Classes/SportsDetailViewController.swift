//
//  SportsDetailViewController.swift
//  ORHS Classes
//
//  Created by Brian Qu on 6/10/20.
//  Copyright © 2020 Steven QU. All rights reserved.
//

import UIKit

class SportsDetailViewController: UIViewController {
    var sport: Sports?
    @IBOutlet weak var coach: UITextView!
    @IBOutlet weak var email: UITextView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var Link: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for sports in CurrentSportsTableViewController.currentSports {
            if sports.name == sport!.name {
                addButton.isEnabled = false
                return
            }
        }
        addButton.isEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = sport?.name
        coach.text = "Coach: \(sport!.coach)"
        email.text = "Email: \(sport!.email)"
        Link.text = "Link: \(sport!.link)"
        for sports in CurrentSportsTableViewController.currentSports {
            if sports.name == sport!.name {
                addButton.isEnabled = false
            }
        }
        coach.sizeToFit()
        email.sizeToFit()
        Link.sizeToFit()
        let attributedString = NSMutableAttributedString(string: "Click here to learn more about ORHS sports!")
            attributedString.addAttribute(.link, value: "https://oakridgeathletics.com/", range: NSRange(location: 0, length: 43))

            Link.attributedText = attributedString
        Link.font = UIFont(name: Link.font!.fontName, size: 30)
        }
//make this uncommented later
//        func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//            UIApplication.shared.openconvertToUIApplicationOpenExternalURLOptionsKeyDictionary((),URL)
//            return false
//        }

        // Do any additional setup after loading the view.
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want add this sport to your favorites?", preferredStyle: .alert)
        // Create OK button with action handler
        let Yes = UIAlertAction(title: "Yes", style: .default, handler: { (action) -> Void in
            print("Yes button tapped")
            self.addButton.isEnabled = false
            self.sport!.adds = true
            CurrentSportsTableViewController.currentSports.append(self.sport!)
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: CurrentSportsTableViewController.currentSports)
            UserDefaults.standard.set(encodedData, forKey: "savedSports")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
