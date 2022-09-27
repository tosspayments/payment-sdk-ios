//
//  ViewController+ViewHolder.swift
//  UIKitExample
//
//  Created by 김진규 on 2022/09/27.
//

import UIKit

extension ViewController {
    class ViewHolder {
        var 입력한결제수단레이블: UILabel!
        var 입력한결제정보레이블: UILabel!
        var pickerView: UIPickerView!
        var button: UIButton!
        
        func installViews(at view: UIView) {
            let 입력한결제수단레이블 = UILabel()
            입력한결제수단레이블.translatesAutoresizingMaskIntoConstraints = false
            입력한결제수단레이블.textColor = .cyan
            view.addSubview(입력한결제수단레이블)
            NSLayoutConstraint.activate([
                입력한결제수단레이블.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                입력한결제수단레이블.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                입력한결제수단레이블.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24)
            ])
            self.입력한결제수단레이블 = 입력한결제수단레이블
            
            
            let 입력한결제정보레이블 = UILabel()
            입력한결제정보레이블.translatesAutoresizingMaskIntoConstraints = false
            입력한결제정보레이블.textColor = .magenta
            입력한결제정보레이블.numberOfLines = 0
            view.addSubview(입력한결제정보레이블)
            NSLayoutConstraint.activate([
                입력한결제정보레이블.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                입력한결제정보레이블.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                입력한결제정보레이블.topAnchor.constraint(equalTo: 입력한결제수단레이블.bottomAnchor, constant: 8)
            ])
            self.입력한결제정보레이블 = 입력한결제정보레이블
            
            let pickerView = UIPickerView()
            view.addSubview(pickerView)
            pickerView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                입력한결제정보레이블.bottomAnchor.constraint(lessThanOrEqualTo: pickerView.topAnchor)
            ])
            self.pickerView = pickerView
            
            let button = UIButton(type: .system)
            button.backgroundColor = .blue
            button.setTitle("시작", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            button.titleLabel?.textColor = .white
            button.layer.cornerRadius = 16
            
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
                button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
                button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
                button.heightAnchor.constraint(equalToConstant: 56),
                pickerView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -24)
            ])
            self.button = button
        }
    }
}
