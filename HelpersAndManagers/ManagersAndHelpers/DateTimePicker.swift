//
//  DatePickerManager.swift
//  CommonComponents
//
//  Created by Muhammad Ahmed Baig on 27/05/2019.
//

import Foundation
import UIKit


@objc public protocol DateTimePickerDelegate {
    @objc optional func datePicked(date: Date)
    @objc optional func timePicked(time: Date)
}

open class DateTimePicker{
    static public let getInstance = DateTimePicker()
    private init(){}
    public var datePickerDelegate : DateTimePickerDelegate?
    
    private enum PickerType{
        case Time
        case Date
    }
    
    ///show date time picker
    public func showDatePicker(fromVC : UIViewController,
                               tintColor: UIColor,
                               minimumDate : Date,
                               maximumDate : Date?=Date(),
                               selectedDate: Date?=nil,
                               completion: ((Date?)->Void)?){
        
        self.settingAndShowPicker(fromVC: fromVC,
                                  pickerType: .Date,
                                  tintColor: tintColor,
                                  minimumDate: minimumDate,
                                  maximumDate: maximumDate,
                                  selectedDateTime: selectedDate) { (date) in
                                    if completion != nil{
                                        completion!(date)
                                    }
        }
    }
    
    
    ///show date time picker
    public func showTimePicker(fromVC : UIViewController,
                               tintColor: UIColor,
                               minimumTime : Date,
                               maximumTime : Date?=Date(),
                               selectedTime: Date?=nil,
                               completion: ((Date?)->Void)?){
        
        self.settingAndShowPicker(fromVC: fromVC,
                                  pickerType: .Time,
                                  tintColor: tintColor,
                                  minimumDate: minimumTime,
                                  maximumDate: maximumTime,
                                  selectedDateTime: selectedTime) { (date) in
                                    if completion != nil{
                                        completion!(date)
                                    }
        }
    }
    
    
    ///show date time picker
    private func settingAndShowPicker(fromVC : UIViewController,
                                      pickerType: PickerType=PickerType.Date,
                                      tintColor: UIColor,
                                      minimumDate : Date,
                                      maximumDate : Date?=Date(),
                                      selectedDateTime: Date?=nil,
                                      completion: ((Date?)->Void)?){
        
        
        var alertCont = UIAlertController(title: "Choose Time",
                                          message: "",
                                          preferredStyle: UIAlertController.Style.actionSheet)
        
        let pickerView = UIDatePicker()
        let vc = UIViewController()
        
        pickerView.datePickerMode = .time
        if selectedDateTime != nil{
            pickerView.date = selectedDateTime!
        }
        if pickerType == .Date{
            pickerView.datePickerMode = .date
            alertCont = UIAlertController(title: "Choose Date",
                                          message: "",
                                          preferredStyle: UIAlertController.Style.actionSheet)
        }
        pickerView.minimumDate = minimumDate
        pickerView.maximumDate = maximumDate
        
        if #available(iOS 13.4, *) {
            pickerView.preferredDatePickerStyle = UIDatePickerStyle.wheels
        }
        
        pickerView.locale = NSLocale(localeIdentifier: "\(DateFormatterHelper.getInstance.getAppTimeFormat().rawValue)") as Locale
        
        vc.view.addSubview(pickerView)
        pickerView.frame = CGRect.init(x: 0, y: 0, width: alertCont.view.bounds.width, height: 100)
        
        alertCont.setValue(vc, forKey: "contentViewController")
        let setAction = UIAlertAction(title: "Select", style: .default) { (action) in
            if self.datePickerDelegate != nil{
                if pickerType == .Date {
                    self.datePickerDelegate!.datePicked!(date: pickerView.date)
                }else{
                    self.datePickerDelegate!.timePicked!(time: pickerView.date)
                }
            }
            if completion != nil {
                completion!(pickerView.date)
            }
        }
        alertCont.addAction(setAction)
        alertCont.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertCont.view.tintColor = tintColor
        fromVC.present(alertCont, animated: true)
    }
    
}
