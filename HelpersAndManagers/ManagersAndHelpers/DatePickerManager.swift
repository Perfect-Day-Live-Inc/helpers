//
//  DatePickerManager.swift
//  CommonComponents
//
//  Created by Muhammad Ahmed Baig on 27/05/2019.
//

import Foundation
import UIKit


public protocol DatePickerDelegate {
    func timePicked(time: Date, index: Int, isDatePicker: Bool)
}

class DatePickerManager{
    static public let getInstance = DatePickerManager()
    private init(){}
    public var datePickerDelegate : DatePickerDelegate?
    
    ///show date time picker
    public func showDateTimePicker(fromVC : UIViewController,
                                    index: Int,
                                    isDatePicker: Bool?=false,
                                    tintColor: UIColor,
                                    minimumDate : Date?=Date(),
                                    selectedDateTime: Date?=nil){
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 150)
        let pickerView = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 250, height: 150))
        
        var alertCont = UIAlertController(title: "Choose Time",
                                          message: "",
                                          preferredStyle: UIAlertController.Style.alert)
        pickerView.datePickerMode = .time
        if selectedDateTime != nil{
            pickerView.date = selectedDateTime!
        }
        if isDatePicker!{
            pickerView.datePickerMode = .date
            pickerView.minimumDate = minimumDate
            alertCont = UIAlertController(title: "Choose Date",
                                          message: "",
                                          preferredStyle: UIAlertController.Style.alert)
        }
        pickerView.locale = NSLocale(localeIdentifier: "\(Formatter.getInstance.getAppTimeFormat().rawValue)") as Locale
        
        vc.view.addSubview(pickerView)
        alertCont.setValue(vc, forKey: "contentViewController")
        let setAction = UIAlertAction(title: "Select", style: .default) { (action) in
            if self.datePickerDelegate != nil{
                self.datePickerDelegate!.timePicked(time: pickerView.date, index: index, isDatePicker: isDatePicker!)
            }
        }
        alertCont.addAction(setAction)
        alertCont.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alertCont.view.tintColor = tintColor
        fromVC.present(alertCont, animated: true)
    }
    
}
