//
//  TipViewController.swift
//  tips
//
//  Created by Steve Buza on 12/4/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class TipViewController: UIViewController {
    
    
    @IBOutlet var defaultViewColor: UIView!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipPercentLabel: UILabel!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorDefaults = NSUserDefaults.standardUserDefaults()
        let backgroundColor = colorDefaults.integerForKey("defaultTheme")
        if backgroundColor == 0 {
            view.backgroundColor = UIColor.darkGrayColor()
        }
        else{
            self.view.backgroundColor = UIColor(red: 57.0/255.0, green: 164.0/255.0, blue: 1.0/255.0, alpha: 1)
        }
        //new format. converts the string into a doubleValue
        //loads the defaults and saves the customTip and splitBill numbers
        let billAmount = NSString(string: billField.text!).doubleValue
        let tipControlDefault = NSUserDefaults.standardUserDefaults()
        let tipPercentage = tipControlDefault.doubleForKey("myDefaultTip")
        let customTipDefault = NSUserDefaults.standardUserDefaults()
        let customTip = Double(customTipDefault.integerForKey("myCustomTip"))
        let splitBillDefault = NSUserDefaults.standardUserDefaults()
        let splitBill = Double(splitBillDefault.integerForKey("mySplitBill"))
        
        //displays if the user changed the custom tip to anything but zero
        if customTip != 0.0
        {
            //displays if the user has split bill to zero
            if splitBill == 0{
                let tip = billAmount * (customTip/100)
                let total = billAmount + tip
                tipLabel.text = String(format: "$%.2f", tip)
                totalLabel.text = String(format: "$%.2f", total)
                splitLabel.text = "$0.00"
                tipPercentLabel.text = "(\(Int(customTip))%)"
                splitNumberLabel.text = "(\(Int(splitBill)))"
            }
            //displays if the user did change the split bill to anything but zero
            else {
                let tip = billAmount * (customTip/100)
                let total = billAmount + tip
                let split = (billAmount + tip)/splitBill
                
                tipLabel.text = String(format: "$%.2f", tip)
                if billField.text == ""{
                    splitLabel.text = "$0.00"
                }
                else{
                    splitLabel.text = String(format: "$%.2f", split)
                }
                totalLabel.text = String(format: "$%.2f", total)
                tipPercentLabel.text = "(\(Int(customTip))%)"
                splitNumberLabel.text = "(\(Int(splitBill)))"
            }
        }
        //displays if the user did not change the custom tip to anything but zero
        else{
            //displays if the user has the split bill to zero
            if splitBill == 0{
                let tip = billAmount * tipPercentage
                let total = billAmount + tip
                tipLabel.text = String(format: "$%.2f", tip)
                totalLabel.text = String(format: "$%.2f", total)
                splitLabel.text = "$0.00"
                tipPercentLabel.text = "(\(Int(tipPercentage*100))%)"
                splitNumberLabel.text = "(\(Int(splitBill)))"
            }
            //displays if the user did change the split bill to anything but zero
            else{
                let tip = billAmount * tipPercentage
                let total = billAmount+tip
                let split = (billAmount+tip)/splitBill
                
                tipLabel.text = String(format: "$%.2f", tip)
                if billField.text == ""{
                    splitLabel.text = "$0.00"
                }
                else{
                    splitLabel.text = String(format: "$%.2f", split)
                }
                totalLabel.text = String(format: "$%.2f", total)
                tipPercentLabel.text = "(\(Int(tipPercentage*100))%)"
                splitNumberLabel.text = "(\(Int(splitBill)))"
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //sets bill field as first responder
        billField.becomeFirstResponder()
        
        //sets the background color
        let colorDefaults = NSUserDefaults.standardUserDefaults()
        let backgroundColor = colorDefaults.integerForKey("myColor")
        if backgroundColor == 0{
            view.backgroundColor = UIColor.darkGrayColor()
        }
        else{
            view.backgroundColor = defaultViewColor.backgroundColor
        }
        
        //when the code is loaded for the first time this is displayed
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        splitLabel.text = "$0.00"
        
        //this is for when the user changes options in the settings view
        //it will display the chosen custom tip or split number

        let splitBillDefault = NSUserDefaults.standardUserDefaults()
        let splitNumber = splitBillDefault.doubleForKey("mySplitBill")
        splitNumberLabel.text = "(\(Int(splitNumber)))"
        
        let customTipDefault = NSUserDefaults.standardUserDefaults()
        let customTip = Double(customTipDefault.integerForKey("myCustomTip"))
        if customTip == 0{
            let tipControlDefault = NSUserDefaults.standardUserDefaults()
            let tipPercentage = tipControlDefault.doubleForKey("myDefaultTip")
            tipPercentLabel.text = "(\(Int(tipPercentage)*100)%)"
        }
        else{
            tipPercentLabel.text = "(\(Int(customTip))%)"
        }
        
    
        //this portion of code is to configure the navigation bars and the background color and fix the title colors
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.view.backgroundColor = UIColor.clearColor()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    
        
        
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {        
        
        //loads the defaults to get information for calculations
        let billAmount = NSString(string: billField.text!).doubleValue
        let tipControlDefault = NSUserDefaults.standardUserDefaults()
        let tipPercentage = tipControlDefault.doubleForKey("myDefaultTip")
        let customTipDefault = NSUserDefaults.standardUserDefaults()
        let splitBillDefault = NSUserDefaults.standardUserDefaults()
        let splitBill = Double(splitBillDefault.integerForKey("mySplitBill"))
        let customTip = Double(customTipDefault.integerForKey("myCustomTip"))
        
        //calculates the tip, split, and total
        if customTip != 0.0
        {
            if splitBill == 0{
                let tip = billAmount * (customTip/100)
                let total = billAmount + tip
                tipLabel.text = String(format: "$%.2f", tip)
                totalLabel.text = String(format: "$%.2f", total)
                splitLabel.text = "$0.00"
            }
            else {
                let tip = billAmount * (customTip/100)
                let total = billAmount + tip
                let split = (billAmount + tip)/splitBill
                
                tipLabel.text = String(format: "$%.2f", tip)
                splitLabel.text = String(format: "$%.2f", split)
                totalLabel.text = String(format: "$%.2f", total)
            
            }
        }
        else{
            if splitBill == 0{
                let tip = billAmount * tipPercentage
                let total = billAmount + tip
                tipLabel.text = String(format: "$%.2f", tip)
                totalLabel.text = String(format: "$%.2f", total)
                splitLabel.text = "$0.00"
            }
            else{
                let tip = billAmount * tipPercentage
                let total = billAmount+tip
                let split = (billAmount+tip)/splitBill
                
                tipLabel.text = String(format: "$%.2f", tip)
                splitLabel.text = String(format: "$%.2f", split)
                totalLabel.text = String(format: "$%.2f", total)
            }
        }
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
