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
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var dollarLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
   
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var tipSegCtrl: UISegmentedControl!
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var evenLabel: UILabel!
    @IBOutlet weak var evenStepper: UIStepper!
    
    @IBOutlet weak var splitCaption: UILabel!
    @IBOutlet weak var splitSlider: UISlider!
    @IBOutlet weak var splitNumLabel: UILabel!
    
    var starttime = NSDate()
    var baseStep = 50.0
    var inputAmt = 0.0
    var tipAmt = 0.0
    var totalAmt = 0.0
    
    var currencySymbol = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inputField.text = ""
        
        let locale = NSLocale.currentLocale()
        let currencySymbols = locale.objectForKey(NSLocaleCurrencySymbol) as! String
        currencySymbol = String(currencySymbols.characters.last!)
        tipLabel.text = currencySymbol+"0.00"
        totalLabel.text = currencySymbol+"0.00"
        dollarLabel.text = currencySymbol
        inputField.layer.cornerRadius = 8
        let myColor : UIColor = UIColor( red: 0, green: 0, blue:0, alpha: 1.0 )
        inputField.layer.borderColor = myColor.CGColor;
        //tipSegCtrl.select(2)
        self.view.backgroundColor = UIColor( red: 10, green: 10, blue:10, alpha: 1.0 )
 
        self.inputField.becomeFirstResponder()
        self.evenStepper.value = 50 //50 is base of step values
        self.evenStepper.stepValue = 1
        
        self.splitSlider.value = 2
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // event for seg ctrl controlling tip amounts
    @IBAction func onValueChanged(sender: AnyObject) {
        refreshvalues()
        refreshSlider()
    }
    // event for changed input
    @IBAction func onInputEditChange(sender: AnyObject) {
        refreshvalues()
        refreshSlider()
    }

    func refreshvalues(){
        let tipPercents = [0.15, 0.18, 0.20, 0.25]
        let tipP = tipPercents[tipSegCtrl.selectedSegmentIndex]
        
        inputAmt = NSString(string: inputField.text!).doubleValue
        tipAmt = inputAmt * tipP
        totalAmt = inputAmt * (1+tipP)
       
        tipLabel.text = String(format:currencySymbol+"%.2f",tipAmt)
        totalLabel.text = String(format:currencySymbol+"%.2f",totalAmt)
        percentLabel.text = String(format:"%.2f%%", tipP*100)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaults = NSUserDefaults.standardUserDefaults()
        //refresh default tip percentage
        let tipIndex = defaults.integerForKey("default_tip_percentage_index")
        tipSegCtrl.selectedSegmentIndex = tipIndex;
        refreshvalues()
        
        //refresh max groups split size
        let maxValue = Float(defaults.integerForKey("max_group_size"))
        if splitSlider.value > maxValue{
            splitSlider.value = maxValue
        }
        splitSlider.maximumValue = maxValue
        refreshSlider()
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
        let labels = [totalLabel, tipLabel, dollarLabel, evenLabel,percentLabel,splitCaption,splitNumLabel]
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
            totalLabel.text = String(format:currencySymbol+"%.2f",totalAmt)
            let perAmt = totalAmt/inputAmt - 1
            tipAmt = perAmt*inputAmt
            tipLabel.text = String(format:currencySymbol+"%.2f",tipAmt)
            percentLabel.text = String(format:"%.2f%%",perAmt*100)
            baseStep = evenStepper.value
        }
        refreshSlider()
        
    }

    @IBAction func onSliderChanged(sender: AnyObject) {
        refreshSlider()
    }
    func refreshSlider(){
        self.splitSlider.value = Float(Int(self.splitSlider.value))
        let each = Float(totalAmt)/self.splitSlider.value
        if self.splitSlider.value <= 1{
            splitCaption.text = String (format:"%1.f Person",self.splitSlider.value)
        }
        else{
        splitCaption.text = String(format:"%1.f People",self.splitSlider.value)
        }
        splitNumLabel.text = String(format:currencySymbol+"%.2f",each)
    }
}

