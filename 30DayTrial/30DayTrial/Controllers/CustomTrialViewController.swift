//
//  AddViewController.swift
//  ThirtyDayTrial
//
//  Created by TørK on 01/03/2018.
//  Copyright © 2018 Tørk Egeberg. All rights reserved.
//

import UIKit
import SnapKit

class CustomTrialViewController: UIViewController {

    let alert = AlertHelper()
    let trialNameTextfield = CustomUITextField()
    let trialStartDateTextField = CustomUITextField()
    let trialCancelDateTextField = CustomUITextField()
    let trialDaysTextField = CustomUITextField()
    
    var trialStartDate: Date?
    var trialCancelDate: Date?
    var activeTextfield: String?
    let trialDate = CustomUIDatePicker()
    let toolBar = CustomToolBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ownTrialUILabel = CustomUILabel(labelText: "Custom Trial")
        self.view.addSubview(ownTrialUILabel)
        ownTrialUILabel.font = ownTrialUILabel.font.withSize(20)
        ownTrialUILabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(100)
            make.centerX.equalTo(self.view.frame.width / 2)
        }
        
        self.view.addSubview(trialNameTextfield)
        trialNameTextfield.placeholder = "Trial Name"
        trialNameTextfield.snp.makeConstraints { (make) in
            make.top.equalTo(ownTrialUILabel).offset(40)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
        }
        
        self.view.addSubview(trialStartDateTextField)
        trialStartDateTextField.placeholder = "Start Date"
        trialStartDateTextField.snp.makeConstraints { (make) in
            make.top.equalTo(trialNameTextfield).offset(40)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
        }
        trialStartDateTextField.addTarget(self, action: #selector(dateAction(sender:)), for: .editingDidBegin)
        
        self.view.addSubview(trialCancelDateTextField)
        trialCancelDateTextField.placeholder = "Cancel Date"
        trialCancelDateTextField.snp.makeConstraints { (make) in
            make.top.equalTo(trialStartDateTextField).offset(40)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
        }
        trialCancelDateTextField.addTarget(self, action: #selector(dateAction(sender:)), for: .editingDidBegin)
        
        self.view.addSubview(trialDaysTextField)
        trialDaysTextField.placeholder = "Days in trial period"
        trialDaysTextField.keyboardType = .numberPad
        trialDaysTextField.snp.makeConstraints { (make) in
            make.top.equalTo(trialCancelDateTextField).offset(40)
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
        }
        
        let saveButton = CustomUIButton(title: "Save")
        saveButton.addTarget(self, action: #selector(saveAction(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(saveButton)
        saveButton.snp.makeConstraints{(make) in
            make.top.equalTo(trialDaysTextField.snp.bottom).offset(20)
            make.left.equalTo(self.view).offset(60)
            make.right.equalTo(self.view).offset(-60)
        }
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func dateAction(sender:UITextField!) {
        self.view.addSubview(trialDate)
        trialDate.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view).offset(-60)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            //make.size.height.equalTo(self.view.frame.height / 5)
        }
        trialDate.isHidden = false
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
        self.toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        self.toolBar.isUserInteractionEnabled = true
        
        self.view.addSubview(toolBar)
        toolBar.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
        }
        self.toolBar.isHidden = false
        
        if sender == trialStartDateTextField {
            self.activeTextfield = "startDate"
        } else {
            self.activeTextfield = "cancelDate"
        }
    }
    
    @objc func doneClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        if activeTextfield == "startDate" {
            self.trialStartDateTextField.text = dateFormatter.string(from: trialDate.date)
            self.trialStartDate = trialDate.date
        } else {
            self.trialCancelDateTextField.text = dateFormatter.string(from: trialDate.date)
            self.trialCancelDate = trialDate.date
        }
        trialDate.isHidden = true
        self.toolBar.isHidden = true
    }
    
    @objc func cancelClick() {
        trialDate.isHidden = true
        self.toolBar.isHidden = true
    }
    
    
    @objc func saveAction(sender:UIButton!) {
    
        let nameHolder = StringHolder(textFieldID: "Trial Name", textField: trialNameTextfield)
        let cancelDayHolder = StringHolder(textFieldID: "Cancel Date", textField: trialCancelDateTextField)
        let startDateHolder = StringHolder(textFieldID: "Start Date", textField: trialStartDateTextField)
        let trialDaysHolder = StringHolder(textFieldID: "Trial Days", textField: trialDaysTextField)
        
        let validateIsText = StringValidator(rules: [IsNotEmptyRule()], subjects: [nameHolder, startDateHolder, cancelDayHolder, trialDaysHolder])
        let validateIsNumber = StringValidator(rules: [IsNotANumber()], subjects: [trialDaysHolder])
        
        do {
            try validateIsText.validate()
            try validateIsNumber.validate()
        } catch ValidatorError.StringWasEmpty(let description) {
            alert.showErrorAlert(fromController: self, error: description)
            return
        }
        catch let error {
            alert.showErrorAlert(fromController: self, error: error.localizedDescription)
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
            try TrialHandler.shared.setTrial(trialName: trialNameTextfield.textVerifier, startdate: customStartDate, endDate: customTrialDays, cancellationTime: customCancelDate)
        }
        catch Error.TrialExcist(let description) {
            alert.showErrorAlert(fromController: self, error: description)
        } catch let error {
            alert.showErrorAlert(fromController: self, error: error.localizedDescription)
        }
        
        TrialHandler.shared.saveTrials()
    
        print("saved")
        
    }

 
}
