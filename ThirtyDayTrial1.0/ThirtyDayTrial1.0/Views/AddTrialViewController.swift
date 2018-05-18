//
//  CustomTrialViewController.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 16/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit
import SnapKit

protocol AddTrialViewResponder:AnyObject,ButtonClickedResponder {
    
}

class AddTrialViewController: UIViewController, UITextFieldDelegate {
    
    var trialName = UserInput()
    var trialStartDate = UserInput()
    var trialCancelDate = UserInput()
    var trialDays = UserInput()
    let datePicker = UIControlsFactory.buildDatePicer()
    var toolBar = UIToolbar()
    weak var responder: AddTrialViewResponder?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        createToolBar()
        
        self.view.addSubview(trialName.textField)
        self.trialName.textField.placeholder = "Enter Trial Name"
        self.trialName.textField.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(100)
            make.left.equalTo(self.view).offset(80)
            make.right.equalTo(self.view).offset(-80)
        }
        
        let trialNameLabel = TextViewFactory.buildUILabel(text: "Name")
        self.view.addSubview(trialNameLabel)
        trialNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(trialName.textField).offset(-23)
            make.left.equalTo(trialName.textField)
        }
        
        self.trialStartDate.textField.inputView = datePicker
        self.trialStartDate.textField.inputAccessoryView = toolBar
        self.view.addSubview(trialStartDate.textField)
        self.trialStartDate.textField.tag = 1
        self.trialStartDate.textField.placeholder = "Pick Start Date"
        self.trialStartDate.textField.snp.makeConstraints { (make) in
            make.top.equalTo(trialName.textField).offset(45)
            make.left.equalTo(trialName.textField)
            make.right.equalTo(trialName.textField)
        }
        self.trialStartDate.textField.addTarget(self, action: #selector(setUserInput), for: .editingDidEnd)
        
        let trialStartDateLabel = TextViewFactory.buildUILabel(text: "Start")
        self.view.addSubview(trialStartDateLabel)
        trialStartDateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(trialStartDate.textField).offset(-23)
            make.left.equalTo(trialStartDate.textField)
        }
        
        self.trialCancelDate.textField.inputView = datePicker
        self.trialCancelDate.textField.inputAccessoryView = toolBar
        self.view.addSubview(trialCancelDate.textField)
        self.trialCancelDate.textField.tag = 2
        self.trialCancelDate.textField.placeholder = "Pick A Cancel Date"
        self.trialCancelDate.textField.snp.makeConstraints { (make) in
            make.top.equalTo(trialStartDate.textField).offset(45)
            make.left.equalTo(trialName.textField)
            make.right.equalTo(trialName.textField)
        }
        self.trialCancelDate.textField.addTarget(self, action: #selector(setUserInput), for: .editingDidEnd)
        
        let trialCancelDateLabel = TextViewFactory.buildUILabel(text: "Cancel")
        self.view.addSubview(trialCancelDateLabel)
        trialCancelDateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(trialCancelDate.textField).offset(-23)
            make.left.equalTo(trialCancelDate.textField)
        }
        
        self.view.addSubview(trialDays.textField)
        self.trialDays.textField.placeholder = "Enter Number Of Days"
        self.trialDays.textField.keyboardType = .numberPad
        self.trialDays.textField.snp.makeConstraints { (make) in
            make.top.equalTo(trialCancelDate.textField).offset(45)
            make.left.equalTo(trialName.textField)
            make.right.equalTo(trialName.textField)
        }
        self.trialDays.textField.addTarget(self, action: #selector(setUserInput), for: .editingDidEnd)
        
        let trialDaysLabel = TextViewFactory.buildUILabel(text: "Days before cancel time")
        self.view.addSubview(trialDaysLabel)
        trialDaysLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(trialDays.textField).offset(-23)
            make.left.equalTo(trialDays.textField)
        }
        
        let saveButton = UIControlsFactory.buildButton(title: "Save")
        saveButton.addTarget(self, action: #selector(saveTrial(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(saveButton)
        saveButton.snp.makeConstraints{(make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(trialDays.textField).offset(60)
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
    
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.changeBorderColerTextField(textfield: textField)
        self.validateUserInputs(textfield: textField)
        self.dismissKeyboard()
    }
    
    func changeBorderColerTextField(textfield: UITextField) {
        textfield.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
    
    func createToolBar() {
        self.toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        label.sizeToFit()
        label.text = "Choose Date"
        let labelButton = UIBarButtonItem(customView:label)
        self.toolBar.setItems([flexibleSpace,flexibleSpace,labelButton,flexibleSpace,doneButton], animated: true)
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    @objc func setUserInput(sender:UITextField) {
        let dateFormatter = DateFormatable()
        if sender.tag == 1 {
            self.trialStartDate.textField.text = dateFormatter.string(from: datePicker.date)
            self.trialStartDate.date = datePicker.date
        }
        if sender.tag == 2 {
            self.trialCancelDate.textField.text = dateFormatter.string(from: datePicker.date)
            self.trialCancelDate.date = datePicker.date
        }
    }
    
    func validateUserInputs(textfield: UITextField) {
        if let textFieldID = textfield.placeholder {
            let stringHolder =  StringHolder(textFieldID: textFieldID, textField: textfield)
            let validateIsText = StringValidator(rules: [IsNotEmptyRule()], subjects: [stringHolder])
            do {
                try validateIsText.validate()
            } catch ValidatorError.StringWasEmpty() {
                return
            }
            catch let error {
                return
            }
        }
    }
    
    @objc func saveTrial(sender:UIButton!) {
        
        guard let trialDays = trialDays.textField.text else {
            print("Error Custom Trial days")
            return
        }
        guard let customTrialDays = Int(trialDays) else {
            print("Error in custom Trial Days")
            return
        }
        
        let trialToSave = Trial(trialName: trialName.textField.textVerifier, startDate: trialStartDate.date, daysBeforeCancelTime: customTrialDays, cancellationTime: trialCancelDate.date)
        let trialToSaveAndSender = TrialAndSender(trial: trialToSave, sender: self)
        self.responder?.buttomClicked(trialAndSender: trialToSaveAndSender)
    }
    
}

extension UITextField {
    var textVerifier:String {
        return self.text ?? ""
    }
}



