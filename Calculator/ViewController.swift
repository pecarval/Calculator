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
    var inputFinished : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ConsoleValue.text! = "0"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        currConsoleVal = ConsoleValue.text!
        let buttonPressedValue = (sender.titleLabel?.text)!
        
        if (inputFinished) {
            ConsoleValue.text! = (sender.titleLabel?.text)!
            inputFinished = false
        } else {
            if (currConsoleVal == "0"){
                ConsoleValue.text! = buttonPressedValue
            } else {
                ConsoleValue.text! = currConsoleVal + buttonPressedValue
            }
        }
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        currConsoleVal = ConsoleValue.text!
        if (inputFinished){
            ConsoleValue.text! = "0."
        } else {
            if !currConsoleVal.contains(".") {
                ConsoleValue.text! = currConsoleVal + "."
            }
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
        if  current < 0 {
            ConsoleValue.text! = "\(abs(current))"
            currentValue = ConsoleValue.text!
        } else if current > 0{
            ConsoleValue.text! = "-"+ConsoleValue.text!
            currentValue = ConsoleValue.text!
        } else {
            ConsoleValue.text! = "0"
        }
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        var current = (ConsoleValue.text! as NSString).doubleValue
        current = current * 0.01
        ConsoleValue.text! = "\(current)"
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        
        if (operationActive) {
            implementOperation()
            operation = (sender.titleLabel?.text)!
        } else {
            inputFinished = true
            operationActive = true
            previousValue = currentValue
            currentValue = ConsoleValue.text!
            operation = (sender.titleLabel?.text)!
        }
    }
    
    @IBAction func equalButtonPressed(_ sender: UIButton) {
        if (operationActive){
            implementOperation()
            operationActive = false
        } else {
            multiplier = previousValue
            previousValue = multiplier
            currentValue = ConsoleValue.text!
            
            executeOperation()
            //ConsoleValue.text! = "\(tempResult.removeZerosFromEnd())"
            //ConsoleValue.text! = "\(tempResult)"
            ConsoleValue.text! = tempResult.formatNumbers()
        }
    }
    
    func implementOperation(){
        inputFinished = true
        previousValue = currentValue
        currentValue = ConsoleValue.text!
        executeOperation()
        previousValue = currentValue
        currentValue = "\(tempResult)"
        
        //ConsoleValue.text! = "\(tempResult.removeZerosFromEnd())"
        //ConsoleValue.text! = "\(tempResult)"
        ConsoleValue.text! = tempResult.formatNumbers()
    }
    
    func executeOperation(){
        
        let value1 : Double = (previousValue as NSString).doubleValue
        let value2 : Double = (currentValue as NSString).doubleValue
        
        print(operation + ":  \(value1) ; \(value2)")
        switch operation {
        case "+":
            tempResult = value1 + value2
        case "-":
            tempResult = value1 - value2
        case "x":
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
    func formatNumbers() -> String {
        let numberFormat = NumberFormatter()
        let number = NSNumber(value: self)
        print("Pre-formatted number: \(number)")
        numberFormat.usesSignificantDigits = true
        //numberFormat.minimumFractionDigits = 0
        numberFormat.maximumSignificantDigits = 6
        let numberFormatted = String(numberFormat.string(from: number) ?? "")
        print("Formatted number: " + numberFormatted)
        return numberFormatted
    }
}
