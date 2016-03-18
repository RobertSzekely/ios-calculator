//
//  ViewController.swift
//  Calculator
//
//  Created by Robert Szekely on 26/02/16.
//  Copyright © 2016 Robert Szekely. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var display: UILabel!
    
    var userTouchedButtonBefore = false
    
    var userCanInsertPoint = true
    
    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        //print("digit = \(digit)")
        if userTouchedButtonBefore && digit == "." && userCanInsertPoint {
            display.text = display.text! + digit
            userCanInsertPoint = false
            
        } else if userTouchedButtonBefore && digit != "."{
            display.text = display.text! + digit
        
        } else if digit != "." {
            userTouchedButtonBefore = true
            display.text = digit
        }
        
    }
    @IBAction func loadPiValue(sender: AnyObject) {
        //let pi = 3.1415926535
        if userTouchedButtonBefore {
            enter()
        }
        display.text = "3.1415926535"
        enter()
    }
    
    @IBAction func enter() {
        userTouchedButtonBefore = false
        userCanInsertPoint = true
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func clearScreen(sender: UIButton) {
        display.text = "0"
        userTouchedButtonBefore = false
        userCanInsertPoint = true
        brain.clearStack()
    }
    

    @IBAction func operate(sender: UIButton) {
        if userTouchedButtonBefore {
            enter()
        }
        if let operation = sender.currentTitle {
            if let result = brain.performOperantion(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }

    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
            
        }
        set{
            display.text = "\(newValue)"
            userTouchedButtonBefore = false
        }
    }
}

