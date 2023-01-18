//
//  ViewController+UIPickerView.swift
//  UIKitExample
//
//  Created by 김진규 on 2022/09/27.
//

#if canImport(UIKit)
import UIKit
import TossPayments

extension PaymentsViewController: UIPickerViewDelegate {
    func title(for row: Int) -> String {
        if row >= PaymentMethod.allCases.count {
            return "새로운 결제수단"
        } else {
            return PaymentMethod.allCases[row].rawValue
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        title(for: row)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row >= PaymentMethod.allCases.count {
            showAlertForInputCustomMethod()
        } else {
            입력한결제수단 = PaymentMethod.allCases[row]
        }
    }
}

extension PaymentsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PaymentMethod.allCases.count + 1
    }
}

#endif
