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
    
    var trialName = dateTextField()
    var trialStartDate = dateTextField()
    var trialCancelDate = dateTextField()
    var trialDays = dateTextField()
    let datePicker = UIControlsFactory.buildDatePicer()
    var toolBar = UIToolbar()
    weak var responder: AddTrialViewResponder?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        createToolBar()
        
        self.trialName.delegate = self
        self.view.addSubview(trialName)
        self.trialName.placeholder = "Enter Trial Name"
        self.trialName.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(100)
            make.left.equalTo(self.view).offset(80)
            make.right.equalTo(self.view).offset(-80)
        }
        
        let trialNameLabel = TextViewFactory.buildUILabel(text: "Name")
        self.view.addSubview(trialNameLabel)
        trialNameLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(trialName).offset(-23)
            make.left.equalTo(trialName)
        }
        
        self.trialStartDate.inputView = datePicker
        self.trialStartDate.inputAccessoryView = toolBar
        self.trialStartDate.delegate = self
        self.view.addSubview(trialStartDate)
        self.trialStartDate.tag = 1
        self.trialStartDate.placeholder = "Pick Start Date"
        self.trialStartDate.snp.makeConstraints { (make) in
            make.top.equalTo(trialName).offset(45)
            make.left.equalTo(trialName)
            make.right.equalTo(trialName)
        }
        self.trialStartDate.addTarget(self, action: #selector(setUserInput), for: .editingDidEnd)
        
        let trialStartDateLabel = TextViewFactory.buildUILabel(text: "Start")
        self.view.addSubview(trialStartDateLabel)
        trialStartDateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(trialStartDate).offset(-23)
            make.left.equalTo(trialStartDate)
        }
        
        self.trialCancelDate.inputView = datePicker
        self.trialCancelDate.inputAccessoryView = toolBar
        self.trialCancelDate.delegate = self
        self.view.addSubview(trialCancelDate)
        self.trialCancelDate.tag = 2
        self.trialCancelDate.placeholder = "Pick A Cancel Date"
        self.trialCancelDate.snp.makeConstraints { (make) in
            make.top.equalTo(trialStartDate).offset(45)
            make.left.equalTo(trialName)
            make.right.equalTo(trialName)
        }
        self.trialCancelDate.addTarget(self, action: #selector(setUserInput), for: .editingDidEnd)
        
        let trialCancelDateLabel = TextViewFactory.buildUILabel(text: "Cancel")
        self.view.addSubview(trialCancelDateLabel)
        trialCancelDateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(trialCancelDate).offset(-23)
            make.left.equalTo(trialCancelDate)
        }
        
        self.trialDays.textField.delegate = self
        self.view.addSubview(trialDays.textField)
        self.trialDays.textField.placeholder = "Enter Number Of Days"
        self.trialDays.textField.keyboardType = .numberPad
        self.trialDays.textField.snp.makeConstraints { (make) in
            make.top.equalTo(trialCancelDate).offset(45)
            make.left.equalTo(trialName)
            make.right.equalTo(trialName)
        }
    
        
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
    
    func fillTextFields(trial: Trial) {
        let dateFormatter = DateFormatable()
        self.trialName.text = trial.trialName
        self.trialStartDate.text = dateFormatter.string(from: trial.startDate)
        self.trialCancelDate.text = dateFormatter.string(from: trial.cancellationTime)
        self.trialDays.textField.text = String(trial.daysBeforeCancelTime)
    }
    
    func setDates(trial: Trial) {
        self.trialStartDate.date = trial.startDate
        self.trialCancelDate.date = trial.cancellationTime
    }

    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }

    @objc func setUserInput(sender:dateTextField) {
        let dateFormatter = DateFormatable()
        sender.date = datePicker.date
        sender.text = dateFormatter.string(from: datePicker.date)
    }
    
    func validateUserInputs(textfield: UITextField) {
        let validateIsText = Validator(rules: [IsNotEmptyRule()], subjects: [textfield])
        do {
            try validateIsText.validate()
        } catch ValidatorError.StringWasEmpty(let validated) {
            validated.textField.layer.shadowColor = UIColor.red.cgColor
            validated.textField.placeholder = textfield.placeholder
        }
        catch let error {
            return
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
        
        let trialToSave = Trial(trialName: trialName.textVerifier, startDate: trialStartDate.date, daysBeforeCancelTime: customTrialDays, cancellationTime: trialCancelDate.date)
        self.responder?.buttonClicked(trial: trialToSave, view: self)
    }
    
}

extension UITextField {
    var textVerifier:String {
        return self.text ?? ""
    }
}



