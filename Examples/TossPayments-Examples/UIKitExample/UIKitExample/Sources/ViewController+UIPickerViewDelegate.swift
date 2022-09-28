//
//  ViewController+UIPickerView.swift
//  UIKitExample
//
//  Created by 김진규 on 2022/09/27.
//

#if canImport(UIKit)
import UIKit
import TossPayments

extension ViewController: UIPickerViewDelegate {
    func title(for row: Int) -> String {
        if row >= 결제수단.allCases.count {
            return "새로운 결제수단"
        } else {
            return 결제수단.allCases[row].rawValue
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        title(for: row)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row >= 결제수단.allCases.count {
            showAlertForInputCustomMethod()
        } else {
            입력한결제수단 = 결제수단.allCases[row]
        }
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 결제수단.allCases.count + 1
    }
}

#endif
