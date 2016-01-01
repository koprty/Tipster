//
//  ViewController.swift
//  Tipster
//
//  Created by Lise Ho on 12/31/15.
//  Copyright © 2015 lise_ho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var percentLabel: UILabel!
    
    @IBOutlet weak var tipCaption: UILabel!
    @IBOutlet weak var totalCaption: UILabel!
    
  
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var dollarLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
   
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var tipSegCtrl: UISegmentedControl!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var evenLabel: UILabel!
    @IBOutlet weak var evenStepper: UIStepper!
    
    
    var starttime = NSDate()
    var baseStep = 50.0
    var inputAmt = 0.0
    var tipAmt = 0.0
    var totalAmt = 0.0
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
 
        self.inputField.becomeFirstResponder()
        self.evenStepper.value = 50 //50 is base of step values
        self.evenStepper.stepValue = 1
        print ("ASDLKFJADSLKFJAS")
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
        let tipPercents = [0.15, 0.18, 0.20, 0.25]
        var tipP = tipPercents[tipSegCtrl.selectedSegmentIndex]
        
        inputAmt = NSString(string: inputField.text!).doubleValue
        tipAmt = inputAmt * tipP
        totalAmt = inputAmt * (1+tipP)
       
        tipLabel.text = String(format:"$%.2f",tipAmt)
        totalLabel.text = String(format:"$%.2f",totalAmt)
        percentLabel.text = String(format:"%.2f%%", tipP*100)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        let tipIndex = defaults.integerForKey("default_tip_percentage_index")
        tipSegCtrl.selectedSegmentIndex = tipIndex;
        refreshvalues()
        //time elapsed in seconds
        let timePassed = NSDate().timeIntervalSinceDate(starttime)
        if (timePassed > 600){
            inputField.text = ""
            refreshvalues()
        }
        
        let theme_ind = defaults.integerForKey("theme_index")
        initThemes(theme_ind)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        starttime = NSDate()
    }
    
    
    func initThemes(ind:Int){
        //tipCaption, totalCaption,
        let labels = [totalLabel, tipLabel, dollarLabel, evenLabel,percentLabel]
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
    
    @IBAction func onEvenChanged(sender: AnyObject) {
        if totalAmt > 0{
            // using scale of 0-100 for stepper values
            if tipAmt == 0 && evenStepper.value == 10{
                //disable rounding down function for evenStepper
                evenStepper.value = 0
            }else if evenStepper.value < baseStep{
                if totalAmt%1 == 0{
                    if totalAmt-1 <= inputAmt{
                        totalAmt = inputAmt
                        evenStepper.value = 0
                    }else{
                        totalAmt = totalAmt - 1
                    }
                }else{
                    totalAmt = totalAmt - totalAmt%1
                }
            }else{
                if totalAmt%1 == 0{
                    totalAmt = totalAmt + 1
                }else{
                    totalAmt = totalAmt + (1-totalAmt%1)
                }
            }
            totalLabel.text = String(format:"$%.2f",totalAmt)
            let perAmt = totalAmt/inputAmt - 1
            tipAmt = perAmt*inputAmt
            tipLabel.text = String(format:"$%.2f",tipAmt)
            percentLabel.text = String(format:"%.2f%%",perAmt*100)
            baseStep = evenStepper.value
        }
        
    }

}

