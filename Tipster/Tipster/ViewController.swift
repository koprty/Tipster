//
//  ViewController.swift
//  Tipster
//
//  Created by Lise Ho on 12/31/15.
//  Copyright © 2015 lise_ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipSegCtrl: UISegmentedControl!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputField.text = "$0.00"
        inputField.text = ""
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        inputField.layer.cornerRadius = 8
        let myColor : UIColor = UIColor( red: 0, green: 0, blue:0, alpha: 1.0 )
        inputField.layer.borderColor = myColor.CGColor;
        //tipSegCtrl.select(2)
        
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
        print("JASDKLFJAKDLSJF")
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipIndex = defaults.integerForKey("default_tip_percentage_index")
        tipSegCtrl.selectedSegmentIndex = tipIndex;
        refreshvalues()
    }
    
    
}

