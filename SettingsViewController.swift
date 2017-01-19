//
//  SettingsViewController.swift
//  tips
//
//  Created by Steve Buza on 12/4/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    
    
    @IBOutlet weak var darkLightControl: UISegmentedControl!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var splitBillField: UITextField!
    @IBOutlet weak var customTipField: UITextField!
    
    //sets the background colors
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorDefaults = NSUserDefaults.standardUserDefaults()
        let backgroundColor = colorDefaults.integerForKey("defaultTheme")
        if backgroundColor == 0 {
            view.backgroundColor = UIColor.darkGrayColor()
            darkLightControl.selectedSegmentIndex = backgroundColor
        }
        else{
            self.view.backgroundColor = UIColor(red: 57.0/255.0, green: 164.0/255.0, blue: 1.0/255.0, alpha: 1)
            darkLightControl.selectedSegmentIndex = backgroundColor             
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //makes sure the tipControl is always on the last selected segment even if the user switches views
        let tipDefault = NSUserDefaults.standardUserDefaults()
        tipControl.selectedSegmentIndex = tipDefault.integerForKey("mySelectedSegment")
        
        //load the customTip default to reflect previous changes made
        let customTipDefault = NSUserDefaults.standardUserDefaults()
        customTipField.text = "\(customTipDefault.integerForKey("myCustomTip"))"
        
        //loads the splitBill default to reflect previous changes made
        let splitBillDefault = NSUserDefaults.standardUserDefaults()
        splitBillField.text = "\(splitBillDefault.integerForKey("mySplitBill"))"
        
        // Do any additional setup after loading the view.
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // D23ispose of any resources that can be recreated.
    }
    
    @IBAction func onTipControlChange(sender: UISegmentedControl) {
        
        //selected segment array form
        var tipPercentages = [0.10, 0.20, 0.25]
        //tipPercentage is the selected segment
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        //saves the index value to later load
        let selectedSegment = tipControl.selectedSegmentIndex
        let tipControlDefault = NSUserDefaults.standardUserDefaults()
        tipControlDefault.setInteger(selectedSegment, forKey:"mySelectedSegment")
        //saves the tip
        tipControlDefault.setDouble(tipPercentage, forKey:"myDefaultTip")
        tipControlDefault.synchronize()
    }
    

    @IBAction func onCustomTipChange(sender: AnyObject) {
        //when customTip is changed 
        //it saves the integer value to use in the calculating view
        let customTip = NSString(string: customTipField.text!).integerValue
        let customTipDefault = NSUserDefaults.standardUserDefaults()
        customTipDefault.setInteger(customTip, forKey: "myCustomTip")
        customTipDefault.synchronize()
        customTipField.text = "\(customTip)"
    }

    @IBAction func onSplitBillChange(sender: AnyObject) {
        //when splitBill is changed it saves the value to be used in the calculating view
        let splitBill = NSString(string: splitBillField.text!).integerValue
        let splitBillDefault = NSUserDefaults.standardUserDefaults()
        splitBillDefault.setInteger(splitBill, forKey:"mySplitBill")
        splitBillDefault.synchronize()
        splitBillField.text = "\(splitBill)"
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }

    //sets background color
    @IBAction func updateDefaultTheme(sender: AnyObject) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setInteger(darkLightControl.selectedSegmentIndex, forKey: "defaultTheme")
        defaults.synchronize()
        
        if darkLightControl.selectedSegmentIndex == 0 {
            self.view.backgroundColor = UIColor.darkGrayColor()
        }
        else {
            self.view.backgroundColor = UIColor(red: 57.0/255.0, green: 164.0/255.0, blue: 1.0/255.0, alpha: 1)
        }
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
