//
//  HomeViewController.swift
//  ORHS Classes
//
//  Created by Brian Qu on 6/11/20.
//  Copyright © 2020 Steven QU. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var ORHSWebsite: UITextView!
    @IBOutlet weak var ORHSFacebook: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributedString = NSMutableAttributedString(string: "Click here to learn more about ORHS!")
            attributedString.addAttribute(.link, value: "https://www.ortn.edu/highschool/", range: NSRange(location: 0, length: 36))

            ORHSWebsite.attributedText = attributedString
        ORHSWebsite.font = UIFont(name: ORHSWebsite.font!.fontName, size: 17)
        ORHSWebsite.sizeToFit()
        let attributedstring = NSMutableAttributedString(string: "Click here for ORHS facebook!")
        attributedstring.addAttribute(.link, value: "https://www.facebook.com/pages/Oak-Ridge-High-School/107690722586884", range: NSRange(location: 0, length: 29))

        ORHSFacebook.attributedText = attributedstring
        ORHSFacebook.font = UIFont(name: ORHSFacebook.font!.fontName, size: 17)
        ORHSFacebook.sizeToFit()
        }

//    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
//        UIApplication.shared.openconvertToUIApplicationOpenExternalURLOptionsKeyDictionary(()URL)
//         if UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url, options: [:])
//         }
//        return false
//    }
        // Do any additional setup after loading the view.
    

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
