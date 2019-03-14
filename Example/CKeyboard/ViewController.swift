//
//  ViewController.swift
//  CKeyboard
//
//  Created by srqa3h.com@gmail.com on 03/14/2019.
//  Copyright (c) 2019 srqa3h.com@gmail.com. All rights reserved.
//

import UIKit
import CKeyboard

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        default keyboard
        CKeyboard.create(textFileds: [textField], characters: CKeyboard.defulteAlphabet)
        
//        Custom keyboard
//        default height = 200
//        default alphabetInLine = 6
//        default isHeaderHidden = false
//        default doneButton = (title = Done)

//        if you want to set any default value for parameter pass nil
        
        CKeyboard.create(textFileds: [textField], characters: ["A","B","C"] , height: 210, alphabetInLine: 7, backgroundColor: nil, isHeaderHidden: false, headerBackroundColor: nil, doneButton: nil)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


