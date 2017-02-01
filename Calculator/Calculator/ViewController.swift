//
//  ViewController.swift
//  Calculator
//
//  Created by Jenny Shalai on 1/21/17.
//  Copyright © 2017 shalai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    private var isUserInTyping = false
    private var brain = CalculatorBrain()
    private var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    

    @IBAction private func digitTapped(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if isUserInTyping {
            let textCurrentlyOnDisplay = display.text!
            display.text = textCurrentlyOnDisplay + digit
        } else {
            display.text! = digit
        }
        isUserInTyping = true
    }
    
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if isUserInTyping {
            brain.setOperand(operand: displayValue)
            isUserInTyping = false
        }
        if let mathSymbol = sender.currentTitle {
            brain.performOperation(symbol: mathSymbol)
        }
        displayValue = brain.result
    }

    var savedProgram: CalculatorBrain.PropertyList?
    
    @IBAction func saveTapped() {
        savedProgram = brain.program
    }
    
    @IBAction func restoreTapped() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
}




