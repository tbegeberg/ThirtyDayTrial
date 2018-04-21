//
//  CustomTrialViewController.swift
//  ThirtyDayTrial1.0
//
//  Created by TørK on 16/04/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit
import SnapKit

class CustomTrialViewController: UIViewController, UITextFieldDelegate {
    
    var trialNameTextfield = UITextField()
    var trialStartDateTextField = UITextField()
    var trialCancelDateTextField = UITextField()
    var trialDaysTextField = UITextField()
    var activeTextField = UITextField()
    var trialStartDate: Date?
    var trialCancelDate: Date?
    let datePicker = UIControlsFactory.buildDatePicer()
    var toolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    
        createToolBar()

        self.trialNameTextfield = UITextViewFactory.buildTextField(tag: 1, delegate: self)
        self.view.addSubview(trialNameTextfield)
        self.trialNameTextfield.placeholder = "Trial Name"
        self.trialNameTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(100)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
        }
        
        self.trialStartDateTextField = UITextViewFactory.buildTextFieldDatePicer(tag: 2, delegate: self, inputView: datePicker, inputAccessoryView: toolBar)
        self.view.addSubview(trialStartDateTextField)
        self.trialStartDateTextField.placeholder = "Start Date"
        self.trialStartDateTextField.snp.makeConstraints { (make) in
            make.top.equalTo(trialNameTextfield).offset(40)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
        }
        self.trialStartDateTextField.addTarget(self, action: #selector(setActiveTextfield), for: .editingDidBegin)
        
        self.trialCancelDateTextField = UITextViewFactory.buildTextFieldDatePicer(tag: 3, delegate: self, inputView: datePicker, inputAccessoryView: toolBar)
        self.view.addSubview(trialCancelDateTextField)
        self.trialCancelDateTextField.placeholder = "Cancel Date"
        self.trialCancelDateTextField.snp.makeConstraints { (make) in
            make.top.equalTo(trialStartDateTextField).offset(40)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
        }
        self.trialCancelDateTextField.addTarget(self, action: #selector(setActiveTextfield), for: .editingDidBegin)
        
        self.trialDaysTextField = UITextViewFactory.buildTextField(tag: 1, delegate: self)
        self.view.addSubview(trialDaysTextField)
        self.trialDaysTextField.placeholder = "Days in trial period"
        self.trialDaysTextField.keyboardType = .numberPad
        self.trialDaysTextField.snp.makeConstraints { (make) in
            make.top.equalTo(trialCancelDateTextField).offset(40)
            make.left.equalTo(self.view).offset(40)
            make.right.equalTo(self.view).offset(-40)
        }
        
        let saveButton = UIControlsFactory.buildButton(title: "Save")
        saveButton.addTarget(self, action: #selector(saveAction(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(saveButton)
        saveButton.snp.makeConstraints{(make) in
            make.top.equalTo(trialDaysTextField.snp.bottom).offset(20)
            make.left.equalTo(self.view).offset(60)
            make.right.equalTo(self.view).offset(-60)
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.gray.cgColor
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.dismissKeyboard()
        return true
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func createToolBar() {
        self.toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissKeyboard))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed(sender:)))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        label.sizeToFit()
        label.text = "Choose Date"
        let labelButton = UIBarButtonItem(customView:label)
        self.toolBar.setItems([cancelButton,flexibleSpace,labelButton,flexibleSpace,doneButton], animated: true)
    }
    
    @objc func doneButtonPressed(sender: UIBarButtonItem) {
      self.setDate()
    }
    
    @objc func setActiveTextfield(sender:UITextField!) {
        self.activeTextField = sender
    }
    
    func setDate() {
        let dateFormatter = DateFormatable()
        if self.activeTextField.tag == 2 {
            self.trialStartDateTextField.text = dateFormatter.string(from: datePicker.date)
            self.trialStartDate = datePicker.date
        }
        if self.activeTextField.tag == 3 {
            self.trialCancelDateTextField.text = dateFormatter.string(from: datePicker.date)
            self.trialCancelDate = datePicker.date
        }
        self.dismissKeyboard()
    }
    
    @objc func saveAction(sender:UIButton!) {
        let alert = AlertHelper()
        let nameHolder = StringHolder(textFieldID: "trial name", textField: trialNameTextfield)
        let cancelDayHolder = StringHolder(textFieldID: "cancel date", textField: trialCancelDateTextField)
        let startDateHolder = StringHolder(textFieldID: "start date", textField: trialStartDateTextField)
        let trialDaysHolder = StringHolder(textFieldID: "trial days", textField: trialDaysTextField)
        
        let validateIsText = StringValidator(rules: [IsNotEmptyRule()], subjects: [nameHolder, startDateHolder, cancelDayHolder, trialDaysHolder])
        let validateIsNumber = StringValidator(rules: [IsNotANumber()], subjects: [trialDaysHolder])
        
        do {
            try validateIsText.validate()
            try validateIsNumber.validate()
        } catch ValidatorError.StringWasEmpty(let description) {
            print(description)
            return
        }
        catch let error {
            print(error)
            return
        }
        
        guard let customStartDate = trialStartDate else {
            print("Error Custom Start date")
            return
        }
        
        guard let trialDays = trialDaysTextField.text else {
            print("Error Custom Trial days")
            return
        }
        
        guard let customTrialDays = Int(trialDays) else {
            print("Error in custom Trial Days")
            return
        }
        
        guard let customCancelDate = trialCancelDate else {
            print("Error Custom Cancel date")
            return
        }
        
        do {
            try TrialHandler.shared.setTrial(trialPeriod: TrialPeriod(trialName: trialNameTextfield.textVerifier, startDate: customStartDate, daysToEndDate: customTrialDays, cancellationTime: customCancelDate))
        }
        catch Error.TrialExcist(let description) {
            alert.showErrorAlert(fromController: self, error: description)
        }
        catch Error.NoTimeInterval(let description) {
            alert.showErrorAlert(fromController: self, error: description)
        }
        catch let error {
            alert.showErrorAlert(fromController: self, error: error.localizedDescription)
        }
        
        alert.showSuccessSave(fromController: self, message: "Trial: \(trialNameTextfield.textVerifier) has been saved")
    }
    
}

extension UITextField {
    var textVerifier:String {
        return self.text ?? ""
    }
}

