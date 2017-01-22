//
//  ViewController.swift
//  Calculator
//
//  Created by Jenny Shalai on 1/21/17.
//  Copyright © 2017 shalai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var isUserInTyping = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func digitTapped(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if isUserInTyping {
            let textCurrentlyOnDisplay = display.text!
            display.text = textCurrentlyOnDisplay + digit
        } else {
            display.text! = digit
        }
        isUserInTyping = true
    }
    @IBAction func performOperation(_ sender: UIButton) {
        isUserInTyping = false
        if let mathSymbol = sender.currentTitle {
            if mathSymbol == "π" {
                display.text = String(M_PI)
            }
        }
    }

}

