//
//  SettingsViewController.swift
//  Tipster
//
//  Created by Lise Ho on 12/31/15.
//  Copyright © 2015 lise_ho. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    
    @IBOutlet weak var defaultTipCaption: UILabel!
    @IBOutlet weak var colorThemeCaption: UILabel!
    @IBOutlet weak var deftipSegCtrl: UISegmentedControl!
    @IBOutlet weak var ThemePicker: UIPickerView!
    let pickerData = ["White", "Cyan", "Dark", "Dark Neon"]
    @IBOutlet weak var maxGroupLabel: UILabel!
    @IBOutlet weak var maxGroupStepper: UIStepper!
        //default maximum is 100
    override func viewDidLoad() {
        super.viewDidLoad()
        
         // Do any additional setup after loading the view.
        //set default values for ThemePicker
        self.ThemePicker.dataSource = self;
        self.ThemePicker.delegate = self;
        
        //retrieve default value and display on segCtrl correctly
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipIndex = defaults.integerForKey("default_tip_percentage_index")
        deftipSegCtrl.selectedSegmentIndex = tipIndex;
        //get default theme
        let theme_ind = defaults.integerForKey("theme_index")
        ThemePicker.selectRow(theme_ind,inComponent:0,animated:true)
        initThemes(theme_ind)
        
        //get default max group size for split slider
        let max_group = defaults.integerForKey("max_group_size")
        if max_group == 0{
            defaults.setInteger(20, forKey: "max_group_size")
        }
        maxGroupStepper.value = Double(max_group)
        maxGroupLabel.text = String(format:"Max Group Size - %1.f", Float(maxGroupStepper.value))
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDefaultTipValueChanged(sender: AnyObject) {
        //tip_index is the same for tip calculator
        let tip_index = deftipSegCtrl.selectedSegmentIndex
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tip_index, forKey: "default_tip_percentage_index")
        defaults.synchronize()
    }
    
    
    //Initialize Theme Picker Functions from protocol
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count;
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(row, forKey: "theme_index")
        defaults.synchronize()
        
        initThemes(row)
    }
    
    
    //refresh themes
    
    func initThemes(ind:Int){

        let labels = [defaultTipCaption, colorThemeCaption, maxGroupLabel]
        if (ind == 0){
            //White Theme
            self.view.backgroundColor = UIColor( red: 10, green: 10, blue:10, alpha: 1.0 )
            for c in labels{
                c.textColor = UIColor.blackColor()
            }
            ThemePicker.backgroundColor = UIColor.whiteColor()
        }
        else if (ind == 1){
            // Cyan Theme
            self.view.backgroundColor = UIColor( red: 0, green: 250, blue:250, alpha: 1.0 )
            for c in labels{
                c.textColor = UIColor.blueColor()
            }
            ThemePicker.backgroundColor = UIColor(red:0, green:250, blue:250, alpha:1.0 )
        }
        else if (ind == 2){
            // Dark
            self.view.backgroundColor = UIColor( red: 0, green: 0, blue:0, alpha: 1.0 )
            for c in labels{
                c.textColor = UIColor.whiteColor()
            }
            ThemePicker.backgroundColor = UIColor.grayColor()
        }
        else{
            // Dark Neon
            self.view.backgroundColor = UIColor( red: 0, green: 0, blue:0, alpha: 1.0 )
            for c in labels{
                c.textColor = UIColor.greenColor()
            }
            ThemePicker.backgroundColor = UIColor.greenColor()
        }
    
    }
    
    @IBAction func onGroupStepperChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(Int(maxGroupStepper.value), forKey: "max_group_size")
         maxGroupLabel.text = String(format:"Max Group Size - %1.f", Float(maxGroupStepper.value))
        
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
