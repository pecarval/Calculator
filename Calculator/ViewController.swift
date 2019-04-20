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

    var tempResult : Float = 0
    var multiplier : String = ""
    
    var currentConsoleValue : String = ""
    var buttonPressedValue : String = ""
    var inputFinished : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConsoleValue.text! = "0"
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        currentConsoleValue = ConsoleValue.text!
        buttonPressedValue = (sender.titleLabel?.text)!
        
        if (inputFinished) {
            ConsoleValue.text! = (sender.titleLabel?.text)!
            inputFinished = false
        } else {
            if (currentConsoleValue == "0"){
                ConsoleValue.text! = (sender.titleLabel?.text)!
            } else {
                ConsoleValue.text! = currentConsoleValue + buttonPressedValue
            }
        }
    }
    
    @IBAction func eraseValueButtonPressed(_ sender: UIButton) {
        ConsoleValue.text! = "0"
        previousValue = ""
        currentValue = ""
        operationActive = false
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        
        if (operationActive) {
            inputFinished = true
            previousValue = currentValue
            currentValue = ConsoleValue.text!
            executeOperation(operation: operation, value1: (previousValue as NSString).floatValue, value2: (currentValue as NSString).floatValue)
            previousValue = currentValue
            currentValue = "\(tempResult)"
            ConsoleValue.text! = "\(tempResult)"
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
            executeOperation(operation: operation, value1: (previousValue as NSString).floatValue, value2: (currentValue as NSString).floatValue)
            ConsoleValue.text! = "\(tempResult)"
            operationActive = false
            previousValue = currentValue
            currentValue = "\(tempResult)"
            inputFinished = true
        } else {
            multiplier = previousValue
            previousValue = multiplier
            currentValue = ConsoleValue.text!
            
            executeOperation(operation: operation, value1: (currentValue as NSString).floatValue, value2: (multiplier as NSString).floatValue)
            ConsoleValue.text! = "\(tempResult)"
        }
    }
    
    func executeOperation(operation : String, value1 : Float, value2 : Float){
        
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
