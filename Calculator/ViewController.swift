//
//  ViewController.swift
//  Calculator
//
//  Created by Pedro Oliveira on 4/17/19.
//  Copyright © 2019 Pedro Oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ConsoleValue: UILabel!
    @IBOutlet weak var EraseButtonValue: UIButton!
    
    var operation : String = ""
    var operationActive : Bool = false

    var previousValue : String = ""
    var currentValue : String = ""

    var tempResult : Double = 0
    var multiplier : String = ""
    
    var currConsoleVal : String = ""
    var buttonPressedValue : String = ""
    var inputFinished : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConsoleValue.text! = "0"
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        currConsoleVal = ConsoleValue.text!
        buttonPressedValue = (sender.titleLabel?.text)!
        
        if (inputFinished) {
            ConsoleValue.text! = (sender.titleLabel?.text)!
            inputFinished = false
        } else {
            if (currConsoleVal == "0"){
                ConsoleValue.text! = (sender.titleLabel?.text)!
            } else {
                ConsoleValue.text! = currConsoleVal + buttonPressedValue
            }
        }
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        currConsoleVal = ConsoleValue.text!
        if (currConsoleVal == "0"){
            ConsoleValue.text! = "."
        } else {
            ConsoleValue.text! = currConsoleVal + "."
        }
    }
    
    @IBAction func eraseValueButtonPressed(_ sender: UIButton) {
        ConsoleValue.text! = "0"
        previousValue = ""
        currentValue = ""
        operationActive = false
    }
    
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        let current = (ConsoleValue.text! as NSString).doubleValue
        currConsoleVal = ConsoleValue.text!
        if  (currConsoleVal as NSString).doubleValue < 0 {
            ConsoleValue.text! = "\(abs(current))"
            currentValue = ConsoleValue.text!
        } else {
            ConsoleValue.text! = "-"+ConsoleValue.text!
            currentValue = ConsoleValue.text!
        }
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        var current = (ConsoleValue.text! as NSString).doubleValue
        current = current * 0.01
        ConsoleValue.text! = "\(current)"
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        
        if (operationActive) {
            inputFinished = true
            previousValue = currentValue
            currentValue = ConsoleValue.text!
            executeOperation(operation: operation, value1: (previousValue as NSString).doubleValue, value2: (currentValue as NSString).doubleValue)
            previousValue = currentValue
            currentValue = "\(tempResult)"
            ConsoleValue.text! = "\(tempResult.stringWithoutZeroFraction)"
            operation = (sender.titleLabel?.text)!
        } else {
            inputFinished = true
            currentValue = ConsoleValue.text!
            operation = (sender.titleLabel?.text)!
            operationActive = true
        }
    }
    
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        if (operationActive){
            previousValue = currentValue
            currentValue = ConsoleValue.text!
            executeOperation(operation: operation, value1: (previousValue as NSString).doubleValue, value2: (currentValue as NSString).doubleValue)
            ConsoleValue.text! = "\(tempResult.stringWithoutZeroFraction)"
            operationActive = false
            previousValue = currentValue
            currentValue = "\(tempResult)"
            inputFinished = true
        } else {
            multiplier = previousValue
            previousValue = multiplier
            currentValue = ConsoleValue.text!
            
            executeOperation(operation: operation, value1: (currentValue as NSString).doubleValue, value2: (multiplier as NSString).doubleValue)
            ConsoleValue.text! = "\(tempResult.stringWithoutZeroFraction)"
        }
    }
    
    func executeOperation(operation : String, value1 : Double, value2 : Double){
        
        print(operation + ":  \(value1) ; \(value2)")
        
        switch operation {
        case "+":
            tempResult = value1 + value2
        case "-":
            tempResult = value1 - value2
        case "X":
            tempResult = value1 * value2
        case "/":
            tempResult = value1 / value2
        default:
            print("Error")
        }
        print(tempResult)
    }
}

extension Double {
    var stringWithoutZeroFraction: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
