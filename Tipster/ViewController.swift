//
//  ViewController.swift
//  Tipster
//
//  Created by Lise Ho on 12/31/15.
//  Copyright © 2015 lise_ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipCaption: UILabel!
    @IBOutlet weak var totalCaption: UILabel!
    @IBOutlet weak var tipSegCtrl: UISegmentedControl!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var dollarLabel: UILabel!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    var starttime = NSDate()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inputField.text = ""
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        inputField.layer.cornerRadius = 8
        let myColor : UIColor = UIColor( red: 0, green: 0, blue:0, alpha: 1.0 )
        inputField.layer.borderColor = myColor.CGColor;
        //tipSegCtrl.select(2)
        self.view.backgroundColor = UIColor( red: 10, green: 10, blue:10, alpha: 1.0 )
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // event for seg ctrl controlling tip amounts
    @IBAction func onValueChanged(sender: AnyObject) {
        refreshvalues()
    }
    // event for changed input
    @IBAction func onInputEditChange(sender: AnyObject) {
        refreshvalues()
    }

    func refreshvalues(){
        var tipPercents = [0.15, 0.18, 0.20, 0.25]
        let tipP = tipPercents[tipSegCtrl.selectedSegmentIndex]
        
        let inputAmt = NSString(string: inputField.text!).doubleValue
        let tipAmt = inputAmt * tipP
        let totalAmt = inputAmt * (1+tipP)
       
        tipLabel.text = String(format:"$%.2f",tipAmt)
        totalLabel.text = String(format:"$%.2f",totalAmt)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipIndex = defaults.integerForKey("default_tip_percentage_index")
        tipSegCtrl.selectedSegmentIndex = tipIndex;
        refreshvalues()
        //time elapsed in seconds
        var timePassed = NSDate().timeIntervalSinceDate(starttime)
        print (timePassed)
        if (timePassed > 600){
            inputField.text = ""
            refreshvalues()
        }
        
        let theme_ind = defaults.integerForKey("theme_index")
        initThemes(theme_ind)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
        starttime = NSDate()
        print (starttime)
        
    }
    
    
    func initThemes(ind:Int){
        var labels = [tipCaption, totalCaption, totalLabel, tipLabel,dollarLabel]
        if (ind == 0){
            //White Theme
            self.view.backgroundColor = UIColor( red: 10, green: 10, blue:10, alpha: 1.0 )
            for c in labels{
                c.textColor = UIColor.blackColor()
            }
            inputField.textColor = UIColor.blackColor()
            lineView.backgroundColor = UIColor.blackColor()
            
        }
        else if (ind == 1){
            // Cyan Theme
            self.view.backgroundColor = UIColor( red: 0, green: 250, blue:250, alpha: 1.0 )
            for c in labels{
                c.textColor = UIColor.blueColor()
            }
            inputField.textColor = UIColor.blueColor()
            lineView.backgroundColor = UIColor.blueColor()
       
        }
        else if (ind == 2){
            // Dark
            self.view.backgroundColor = UIColor( red: 0, green: 0, blue:0, alpha: 1.0 )
            for c in labels{
                c.textColor = UIColor.whiteColor()
            }
            inputField.textColor = UIColor.whiteColor()
            lineView.backgroundColor = UIColor.whiteColor()
            
        }
        else{
            // Dark Neon
            self.view.backgroundColor = UIColor( red: 0, green: 0, blue:0, alpha: 1.0 )
            for c in labels{
                c.textColor = UIColor.greenColor()
            }
            inputField.textColor = UIColor.greenColor()
            lineView.backgroundColor = UIColor.greenColor()
        }
        
    }

}

