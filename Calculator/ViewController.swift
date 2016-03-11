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
  
    var operandStack = Array<Double>()
    
    @IBAction func enter() {
        userTouchedButtonBefore = false
        userCanInsertPoint = true
        operandStack.append(displayValue)
        print("operandStack = \(operandStack)")
    }
    
    @IBAction func clearScreen(sender: UIButton) {
        display.text = "0"
        userTouchedButtonBefore = false
        userCanInsertPoint = true
    }
    @IBAction func clearAll(sender: UIButton) {
        display.text = "0"
        userTouchedButtonBefore = false
        userCanInsertPoint = true
        operandStack.removeAll()
        print("operandStack = \(operandStack)")
    }

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if userTouchedButtonBefore {
            enter()
        }
        switch operation {
        case "✕": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "-": performOperation { $1 - $0 }
        case "√": performSimpleOperation { sqrt($0)}
        case "sin": performSimpleOperation{ sin($0)}
        case "cos": performSimpleOperation{ cos($0)}
        default: break
        }
    }
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    func performSimpleOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
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

