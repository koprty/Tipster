//
//  SettingsViewController.swift
//  Tipster
//
//  Created by Lise Ho on 12/31/15.
//  Copyright © 2015 lise_ho. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController{

    @IBOutlet weak var deftipSegCtrl: UISegmentedControl!
    let pickerData = ["15%", "18%", "20%", "25%"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
         // Do any additional setup after loading the view.
        
        //retrieve default value and display on segCtrl correctly
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipIndex = defaults.integerForKey("default_tip_percentage_index")
        deftipSegCtrl.selectedSegmentIndex = tipIndex;
       
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onDefaultTipValueChanged(sender: AnyObject) {
        //tip_index is the same for tip calculator
        var tip_index = deftipSegCtrl.selectedSegmentIndex
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tip_index, forKey: "default_tip_percentage_index")
        defaults.synchronize()
    }
    @IBAction func onEditingChanged(sender: AnyObject) {
        
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
