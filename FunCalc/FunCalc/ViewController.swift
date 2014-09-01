//
//  ViewController.swift
//  FunCalc
//
//  Created by Bryan Harrell on 18/08/2014.
//  Copyright (c) 2014 Bryan Harrell. All rights reserved.
//

import UIKit;

class ViewController: UIViewController {
    var currentCalculation: Double = 0.00
    @IBOutlet var totalTextField : UITextField!
    @IBOutlet var taxPctSlider : UISlider!
    @IBOutlet var taxPctLabel : UILabel!
    @IBOutlet var resultsTextView : UITextView!
    @IBOutlet var calculationHolder : UITextView!
    @IBOutlet var nextButton : UILabel!
    @IBOutlet var clearTotal : UITextView!
    @IBOutlet var counter : UIProgressView!
    @IBOutlet var finishButton : UIButton!
    @IBOutlet var startButton : UIButton!
    @IBOutlet var nextButton2 : UIButton!
    @IBOutlet var numberOfRounds : UIStepper!
    @IBOutlet var maxNumber : UIStepper!
    @IBOutlet var calculationTotal : UITextView!
    @IBOutlet var userResult : UITextField!
    @IBOutlet var numberOfRoundsText : UITextView!
    @IBOutlet var maxNumberText : UITextView!
    var finalCalculationHolder: String = "";
    var counterinternal = 0.0;
    let funCalc = FunCalcModel(total: 0, taxPct: 0,calcTotal:0)
    @IBAction func checkResultView(sender : AnyObject) {
        numberOfRoundsText.text = String(format: "%@%.0f", "",numberOfRounds.value)
        maxNumberText.text = String(format: "%@%.0f", "",maxNumber.value)
    }
    
    @IBAction func calculateTapped(sender : AnyObject) {
        // 1
        funCalc.total = Double((totalTextField.text as NSString).doubleValue)
        // 2
        let possibleTips = funCalc.returnPossibleTips()
        var results = ""
        // 3
        for (tipPct, tipValue) in possibleTips {
            // 4
            results += "\(tipPct)%: \(tipValue)\n"
        }
        // 5
        resultsTextView.text = results
        
        
        
    }
    
    
    @IBAction func taxPercentageChanged(sender : AnyObject) {
        funCalc.taxPct = Double(taxPctSlider.value) / 100.0
        refreshUI()
    }
    @IBAction func viewTapped(sender : AnyObject) {
        userResult.resignFirstResponder()
    }
    @IBAction func clearCalc (sender : AnyObject) {
        funCalc.setCalc(0.0);
        calculationTotal.text = " ";
        calculationHolder.text = " ";
        counter.progress = 0.0;
        counterinternal = 0;
        let diceRoll = Int(arc4random_uniform(20))
        let diceRollDouble = String(diceRoll)
        
        calculationHolder.text = "\(diceRollDouble)"
        calculationTotal.text = " ";
        println(String(format: "%@%.2f", "a float number: ", 1.03213242342))
    }
    func checkResult () -> Int{
        if (userResult.text == calculationTotal)
        {
            return 1;
        }
        else{
            return 0;
        }
    }
    func stepperValueDidChange(stepper: UIStepper) {
        println("A stepper changed its value: \(stepper).")
    }
    
    @IBAction func mainCalc (sender : AnyObject) {
        startButton.hidden = true;
        nextButton2.hidden = false;
        userResult.hidden = true
      //  nextButton.text = ""
        
        // println(maxNumber.value);
        //  println(numberOfRounds.value);
        var divide = "/"
        var times = "*"
        var subtract = "-"
        var add = "+"
        //var temporaryMaxNumber:Int = Int((maxNumber.value))
       // var temporaryRounds:Int = Int((numberOfRounds.value))
        
        let diceRoll = Int((arc4random_uniform(UInt32(10))))
        var diceRollDouble = Float(diceRoll)
        let multiplicationRoll = Int(arc4random_uniform(4))
        if (counterinternal == 10 - 2){
            calculationTotal.text = "Enter total below"
            //snextButton.text = "Finish"
            userResult.hidden = false
            finishButton.hidden = false
            nextButton2.hidden = true;
        }
        if (counterinternal == 10 - 1){
            println("User Result")
            println(userResult.text);
            println("CalculationTotal")
            println(funCalc.getCalc());
            // nextButton.text = "Start Again"
            var s = String(format: "%@%.0f", "",funCalc.getCalc());
            
            if (userResult.text == s){
                nextButton.text = "Correct"
                userResult.hidden = true
            }
            else{
              //  nextButton.text = "Incorrect"
                userResult.hidden = true
            }
            
            var temp = funCalc.getCalc();
            calculationTotal.text = String(format: "%@%.0f", "",temp);
            calculationHolder.text = finalCalculationHolder;
            funCalc.setCalc(0.0);
            //counter.progress = 0.0;
            counterinternal = 0;
            finishButton.hidden = true
            nextButton2.hidden = true;
            startButton.hidden = false;
        }
            
        else{
            
            //  println("something";
            
            
            if (multiplicationRoll == 1){
                
                if ((funCalc.getCalc() % diceRollDouble) != 0){
                    var diceRoll2 = Int(arc4random_uniform(UInt32(10)));
                    var diceRollDouble2 = Float(diceRoll2);
                    while ((funCalc.getCalc() % diceRollDouble2) != 0){
                        
                        
                        
                        diceRoll2 = Int(arc4random_uniform(UInt32(10)))
                        diceRollDouble2 = Float(diceRoll2)
                        /* println("something1");
                        println(funCalc.getCalc());
                        println("something2");
                        println(diceRollDouble2);
                        println("something3");
                        println( multiplicationRoll);
                        */
                        
                    }
                    //println("something4");
                    // println(funCalc.getCalc()/(diceRollDouble2));
                    funCalc.setCalc(funCalc.getCalc()/(diceRollDouble2))
                    calculationHolder.text = "\(divide)" + " " + "\(diceRoll2)";
                }
                else if (diceRollDouble == 0.0){
                    diceRollDouble = 1.0
                    println("I saved the day");
                    funCalc.setCalc(funCalc.getCalc()/diceRollDouble)
                    calculationHolder.text = "\(divide)" + " " + "\(diceRoll)"
                }
                else{
                    funCalc.setCalc(funCalc.getCalc()/diceRollDouble)
                    calculationHolder.text = "\(divide)" + " " + "\(diceRoll)"
                }
                
            }
                
            else if(multiplicationRoll == 2){
                funCalc.setCalc(funCalc.getCalc()*diceRollDouble)
                calculationHolder.text = "\(times)" + " " + "\(diceRoll)"
            }
            else if(multiplicationRoll == 3){
                funCalc.setCalc(funCalc.getCalc()-diceRollDouble)
                calculationHolder.text = "\(subtract)" + " " + "\(diceRoll)"
                
            }
            else{
                funCalc.setCalc(funCalc.getCalc()+diceRollDouble)
                calculationHolder.text = "\(add)" + " " + "\(diceRoll)"
                
                
            }
            if (counterinternal == 0){
                let diceRoll = Int(arc4random_uniform(20))
                let diceRollDouble = String(diceRoll)
                funCalc.setCalc(Float(diceRoll))
                calculationHolder.text = "\(diceRollDouble)"
                calculationTotal.text = " ";
                finalCalculationHolder = calculationHolder.text
            }
            else{
                
                finalCalculationHolder = finalCalculationHolder + " " + calculationHolder.text
                println(funCalc.getCalc());
                println(counterinternal);
            }
            //println(funCalc.getCalc());
            //  calculationTotal.text = "\(funCalc.getCalc())";
            counterinternal++;
            
            var counterinternalpercentage = (Float(counterinternal)/(Float(10)));
            
            //counter.progress = counterinternalpercentage;
            println(funCalc.getCalc());
            
            
            
        }
    }
    
    
    
    
    func refreshUI() {
        // 1
        // totalTextField.text = String(format: "%0.2f", funCalc.total)
        // 2
        // taxPctSlider.value = Float(funCalc.taxPct) * 100.0
        // 3
        //  taxPctLabel.text = "Tax Percentage (\(Int(taxPctSlider.value))%)"
        // 4
        //  resultsTextView.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       nextButton2.hidden = true
        startButton.hidden = false
        finishButton.hidden = true
        userResult.hidden = true
       // maxNumber.value = 10;
      //  numberOfRounds.value = 10;
        let diceRoll = Int(arc4random_uniform(10))
        let diceRollDouble = String(diceRoll)
      //  numberOfRoundsText.text = String(format: "%@%.0f", "",numberOfRounds.value)
       // maxNumberText.text = String(format: "%@%.0f", "",maxNumber.value)
        calculationHolder.text = "\(diceRollDouble)"
        finalCalculationHolder = "\(diceRollDouble)"
        funCalc.setCalc(Float(diceRoll));
        counterinternal++;
        refreshUI()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

