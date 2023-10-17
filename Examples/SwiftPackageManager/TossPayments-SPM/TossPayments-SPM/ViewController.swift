//
//  ViewController.swift
//  TossPayments-SPM
//
//  Created by 김 진규 on 2023/10/17.
//

import UIKit
import TossPayments

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let widget = PaymentWidget(clientKey: "", customerKey: "")
        let method = widget.renderPaymentMethods(amount: 1000)
    }


}

