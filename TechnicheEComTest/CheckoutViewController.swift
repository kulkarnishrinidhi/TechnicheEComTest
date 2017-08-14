//
//  CheckoutViewController.swift
//  TechnicheEComTest
//
//  Created by Kulkarni on 14/08/17.
//  Copyright © 2017 Shrilakshmi Kulkarni. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
