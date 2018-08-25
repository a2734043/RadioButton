//
//  ViewController.swift
//  RadioButton
//
//  Created by 陳鍵群 on 2018/8/25.
//  Copyright © 2018年 陳鍵群. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RadioButtonControllerDelegate {
    @IBOutlet weak var button1: RadioButton!
    @IBOutlet weak var button2: RadioButton!
    @IBOutlet weak var button3: RadioButton!
    var radioButtonController: RadioButtonController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        radioButtonController = RadioButtonController.init(buttons: [button1,button2,button3])
        radioButtonController?.delegate = self
        radioButtonController?.canDeSelect = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    func didSelectedButton(_ radioButtonController: RadioButtonController, _ currentSelectedButton: RadioButton?) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

