//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var fifteenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberButton: UILabel!
    
    var tip = 0.15
    var splitBtwn = 1
    var billTotal = 0.0
    var finalResult = "0.0"

    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        tenPctButton.isSelected = false
        fifteenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        let btnTitle = sender.currentTitle
        if btnTitle == "10%" {
            tip = 0.10
        } else if btnTitle == "15%" {
            tip = 0.15
        } else {
            tip = 0.20
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitBtwn = Int(sender.value)
        splitNumberButton.text = String(splitBtwn)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
        if bill != "" {
            billTotal = Double(bill)!

            let eachPersonPays = billTotal * (1 + tip) / Double(splitBtwn)
            finalResult = String(format: "%.2f", eachPersonPays)
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = splitBtwn
        }
    }
    
}

