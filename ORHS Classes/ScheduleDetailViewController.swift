//
//  ClassDetailViewController.swift
//  ORHS Classes
//
//  Created by Steven QU on 5/30/18.
//  Copyright © 2018 Steven QU. All rights reserved.
//

import UIKit
import Foundation
class ScheduleDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    //static var dialog = false
    //MARK: Properties
    @IBOutlet weak var picker: UIPickerView!
    var course: Class?
    var subject: String? //passed from classTableView
    @IBOutlet weak var gpaLabel: UILabel!
    @IBOutlet weak var CreditLabel: UILabel!
    @IBOutlet weak var HourLabel: UITextView!
    @IBOutlet weak var DescriptionTextBox: UITextView!
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var grader: UILabel!
    var pickerData: [String] = [String]()
    var pressed: Int = 0
    let defaults = UserDefaults.standard
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    @IBAction func Show(_ sender: UIBarButtonItem) {
        picker.isHidden = !picker.isHidden;
        pressed += 1
        if pressed % 2 == 1 {
            let gradient = CAGradientLayer(layer: DescriptionTextBox.layer)
            gradient.frame = DescriptionTextBox.bounds
            gradient.colors = [UIColor.clear.cgColor, UIColor.blue.cgColor]
            gradient.startPoint = CGPoint(x:0.5,y:1.0)
            gradient.endPoint = CGPoint(x:0.5,y:0.0)
            gradient.opacity = Float(0.7)
            DescriptionTextBox.layer.mask = gradient
            grader.isHidden = false
        }
        else {
            let gradient = CAGradientLayer(layer: DescriptionTextBox.layer)
                gradient.frame = DescriptionTextBox.bounds
            gradient.colors = [UIColor.black.cgColor, UIColor.black.cgColor]
                DescriptionTextBox.layer.mask = gradient
            grader.isHidden = true
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: course!.name)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        grader.isHidden = true
        picker.isHidden = !picker.isHidden;
        self.picker.delegate = self
        self.picker.dataSource = self
        if course?.percent == "general" {
            pickerData = ["A: 92.5-100", "B: 84.5-92.49", "C: 74.5-84.49", "D: 69.5-74.49", "F: 0-69.49"]
        }
        else if course?.percent == "Honors" {
            pickerData = ["A: 89.5-100", "B: 81.5-89.49", "C: 71.5-81.49", "D: 66.5.5-71.49", "F: 0-66.49"]
        }
        else if course?.percent == "None" {
            pickerData = ["A", "B", "C", "D", "F"]
        }
        else if course?.percent == "AdvancedPlacement" {
            pickerData = ["A: 87.5-100", "B: 79.5-87.49", "C: 69.5-79.49", "D: 64.5-69.49", "F: 0-64.49"]
        }
        else {
            pickerData = ["A: 88.5-100", "B: 80.5-88.49", "C: 70.5-80.49", "D: 65.5-70.49", "F: 0-65.49"]
        }
        let screenRect = UIScreen.main.bounds
        let screenHeight = screenRect.size.height
        let screenWidth = screenRect.size.width
        print(screenHeight)
        print(screenWidth)
        var ratio = screenHeight/896
        var ratioW = screenWidth/414
        grader.font = grader.font.withSize(25*ratioW)
        let defaults = UserDefaults.standard
        let grade = defaults.integer(forKey: course!.name)
        picker.selectRow(grade, inComponent: 0, animated: true)
        // Input the data into the array
        self.title = course?.name
        gpaLabel.text = "GPA: \(course!.GPA)"
        CreditLabel.text = "Credits: \(course!.credits)"
        HourLabel.text = "Prerequisites: \(course!.hours)"
        DescriptionTextBox.text = course!.summary
        CategoryLabel.text = "Subject: \(course!.subject)"
        HourLabel.sizeToFit()
        CategoryLabel.sizeToFit()
        CategoryLabel.frame.origin = CGPoint(x: 250, y: 95*ratio)
        CategoryLabel.numberOfLines = 0
//        UIFont(name: gpaLabel.font.fontName, size: 15*ratio)
//        UIFont(name: CreditLabel.font.fontName, size: 15*ratio)
//        UIFont(name: CategoryLabel.font.fontName, size: 15*ratio)
        CreditLabel.font = CreditLabel.font.withSize(15*ratio)
        gpaLabel.font = gpaLabel.font.withSize(15*ratio)
        CategoryLabel.font = CategoryLabel.font.withSize(15*ratio)
        DescriptionTextBox.font = UIFont.systemFont(ofSize: 15*ratio)
        HourLabel.font = UIFont.systemFont(ofSize: 15*ratio)
        print(HourLabel.font)
        HourLabel.sizeToFit()
        CategoryLabel.sizeToFit()
        CategoryLabel.frame.origin = CGPoint(x: 250, y: 95*ratio)
        CategoryLabel.numberOfLines = 0
        let numLines = (Int(HourLabel.contentSize.height) / Int(HourLabel.font!.lineHeight)) - 1
        if numLines <= 3 {
            HourLabel.frame.origin = CGPoint(x: 0, y: 88*ratio)
            gpaLabel.frame.origin = CGPoint(x: 250, y: 120*ratio)
            CreditLabel.frame.origin = CGPoint(x: 5, y: 120*ratio)
            DescriptionTextBox.frame.origin = CGPoint(x: 0, y: 194*ratio)
        }
        if numLines > 3 {
            if (course?.subject) == "Personal Finance" || (course?.subject) == "U.S. Government" || (course?.subject) == "World Languages" || (course?.subject) == "Career Academies" || (course?.subject) == "World History/Geography" {
                HourLabel.frame.origin = CGPoint(x: 0, y: 88*ratio)
                CreditLabel.frame.origin = CGPoint(x: 250, y: ratio*((HourLabel.font!.lineHeight * CGFloat(numLines-3) + 88) + 88)/2)
                gpaLabel.frame.origin = CGPoint(x: 250, y: ratio*HourLabel.font!.lineHeight * CGFloat(numLines-3) + 98)
                DescriptionTextBox.frame.origin = CGPoint(x: 0, y: ratio*HourLabel.font!.lineHeight * CGFloat(numLines-2)+150)
            }
            else {
                HourLabel.frame.origin = CGPoint(x: 0, y: ratio*88)
                CreditLabel.frame.origin = CGPoint(x: 250, y: ratio*((HourLabel.font!.lineHeight * CGFloat(numLines-4) + 88) + 88)/2)
                gpaLabel.frame.origin = CGPoint(x: 250, y: ratio*HourLabel.font!.lineHeight * CGFloat(numLines-3) + 98)
                DescriptionTextBox.frame.origin = CGPoint(x: 0, y: ratio*HourLabel.font!.lineHeight * CGFloat(numLines-2)+150)
            }
        }
        if (course?.subject) == "Personal Finance" {
            
            CategoryLabel.text = "Subject: Personal \n" + "Finance"
            CategoryLabel.sizeToFit()
        }
        if (course?.subject) == "U.S. Government" {
            
            CategoryLabel.text = "Subject: U.S. \n" + "Government"
            CategoryLabel.sizeToFit()
        }
        if (course?.subject) == "World Languages" {
            
            CategoryLabel.text = "Subject: World \n" + "Languages"
            CategoryLabel.sizeToFit()
        }
        if (course?.subject) == "Career Academies" {
            
            CategoryLabel.text = "Subject: Career \n" + "Academies"
            CategoryLabel.sizeToFit()
        }
        if (course?.subject) == "World History/Geography" {
            
            CategoryLabel.text = "Subject: World History/ \n" + "Geography"
            CategoryLabel.sizeToFit()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? "") {
        case "ChooseYear": guard let Navigation = segue.destination as? UINavigationController else {
            fatalError("Unexpected destination")
        }
        let Year = Navigation.topViewController as! AddYearTableViewController
        Year.tempCourse = self.course!
        default: fatalError("Unexpected Segue Identifier")
        }
    }
    



   
    

}
