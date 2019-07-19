//
//  Utility.swift
//  Scholarship
//
//  Created by MacBook Retina on 9/15/17.
//  Copyright © 2017 PNC. All rights reserved.
//

import Foundation
import UIKit
import Swift
import SafariServices
import MapKit
import CoreLocation
import MobileCoreServices
import AVKit

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///This class contains small tasks which are repeatadly use in the application
///It contians ui settings task
///some api tasks
///and many libraries properties settings

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

open class Helper{
    static public let getInstance = Helper()
    private init(){}
    
    public var controlTintColor : UIColor = .black
    
    
    /// SETTING NAVIGATION WITH OPTIONS
    ///
    /// - Parameters:
    ///   - leftBarItem: LEFT BAR ITEM TO SET
    ///   - rightBarItem: RIGHT BAR ITEM TO SET
    ///   - title: TITLE OF NAV BAR
    ///   - isTransparent: IS NAV BAR TRANSPARENT 'DEFAULT = FALSE'
    ///   - isBottomLine: IS BOTTOM BLACK LINE ON NAVIGATION REQUIRED 'DEFAULT = FALSE'
    ///   - titleView: CUSTOM VIEW ON TITLE IF ANY
    ///   - itemsColor: COLORS OF BAR ITEMS SUCH AS 'TITLE, BARITEMS'
    ///   - titleFontStyle: TITLE FONT STYLE
    ///   - itemsFontStyle: ITEMS FONT STYLE
    ///   - titlesFontSize: FONT SIZE OF TITLE
    ///   - itemsFontSize: FONT SIZE OF ITEMS
    ///   - vc: INSTANCE OF VIEWCONTROLLER WHERE NAVIGATION EXISTS
    public func setNavigationBar(leftBarItem: UIBarButtonItem?=nil,
                                  rightBarItem: UIBarButtonItem?=nil,
                                  title: String,
                                  isTransparent: Bool=false,
                                  isBottomLine: Bool=false,
                                  titleView: UIView?=nil,
                                  itemsColor: UIColor=UIColor.white,
                                  titleFontStyle: UIFont?=nil,
                                  itemsFontStyle: UIFont?=nil,
                                  titlesFontSize: CGFloat=17,
                                  itemsFontSize: CGFloat=17,
                                  vc: UIViewController){
        
        var font = UIFont.systemFont(ofSize: 17)
        if titleFontStyle == nil{
            font = titleFontStyle!
        }
        
        var itemsFont = UIFont.systemFont(ofSize: 17)
        if itemsFontStyle == nil{
            itemsFont = itemsFontStyle!
        }
        
        if(rightBarItem != nil){
            rightBarItem?.setTitleTextAttributes([NSAttributedString.Key.font : itemsFont], for: .normal)
            vc.navigationItem.rightBarButtonItem = rightBarItem
        }
        
        if(leftBarItem != nil){
            leftBarItem?.setTitleTextAttributes([NSAttributedString.Key.font : itemsFont], for: .normal)
            vc.navigationItem.leftBarButtonItem = leftBarItem
        }
        
        if (titleView == nil){
            vc.navigationItem.title = title
        }else{
            vc.navigationItem.titleView = titleView!
        }
        
        if !isTransparent{
            //
            vc.navigationController?.navigationBar.barTintColor = UIColor.white//color
            vc.navigationController?.navigationBar.backgroundColor = UIColor.white//.getDarkBlueColor//color
            vc.navigationController?.navigationBar.isTranslucent = false
            if !isBottomLine{
                vc.navigationController?.navigationBar.shadowImage = UIImage()
            }else{
                vc.navigationController?.navigationBar.shadowImage = UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1.0).as1ptImage()
            }
        }else{
            vc.navigationController?.navigationBar.barTintColor = UIColor.clear//color
            vc.navigationController?.navigationBar.backgroundColor = UIColor.clear//.getDarkBlueColor//color
            vc.navigationController?.navigationBar.isTranslucent = true
            vc.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            vc.navigationController?.navigationBar.shadowImage = UIImage()
        }
        
        vc.navigationController?.navigationBar.tintColor = itemsColor
        
        vc.navigationItem.backBarButtonItem?.tintColor = itemsColor
        
        vc.navigationItem.rightBarButtonItem?.tintColor = itemsColor
        vc.navigationItem.leftBarButtonItem?.tintColor = itemsColor
        vc.navigationItem.setHidesBackButton(true, animated: false)
        
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor : itemsColor,
                                       NSAttributedString.Key.font : font]
        vc.navigationController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]
        
    }
    
    
    ///set specific view controller as root
    public func makeSpecificViewRoot(vc: UIViewController){
        var snapshot:UIView!
        let rootVC : UIViewController!
        
        rootVC = vc
        DispatchQueue.main.async {
            snapshot = (UIApplication.shared.keyWindow?.snapshotView(afterScreenUpdates: true))!
            rootVC.view.addSubview(snapshot);
            
            UIApplication.shared.keyWindow?.rootViewController = rootVC;
            UIView.transition(with: snapshot, duration: 0.4, options: .transitionCrossDissolve, animations: {
                snapshot.layer.opacity = 0;
            }, completion: { (status) in
                snapshot.removeFromSuperview()
            })
        }
    }
    
    
    /// THIS WILL SHOW ALERT CONTROLLER
    ///
    /// - Parameters:
    ///   - title: TITLE OF ALERT
    ///   - message: DESCRIPTION OF ALERT
    ///   - actions: ACTIONS TO SHOW
    ///   - defaultActionTitle: DEFAULT ACTION TITLE
    ///   - isDefaultActionReq: IS DEFAULT ACTION VISIBLE OR NOT
    ///   - vc: PRESENT FROM WHICH VIEW CONTROLLER
    public func showAlert(title : String ,
                          message : String,
                          actions: [UIAlertAction]?=nil,
                          defaultActionTitle: String?="Ok",
                          isDefaultActionReq: Bool?=true,
                          vc: UIViewController?=nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions != nil {
            for action in actions!{
                alertController.addAction(action)
            }
        }
        if isDefaultActionReq!{
            let alertAction = UIAlertAction(title: defaultActionTitle, style: .default, handler: nil)
            alertController.addAction(alertAction)
        }
        DispatchQueue.main.async {
            if let rootWindow = UIApplication.shared.keyWindow?.rootViewController{
                rootWindow.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    ///set nav bar clear color
    public func setNavBarClearColor(vc: UIViewController){
        vc.navigationController?.navigationBar.barTintColor = UIColor.clear//color
        vc.navigationController?.navigationBar.backgroundColor = UIColor.clear//.getDarkBlueColor//color
    }
    
    ///add underline to attributed string
    public func addUnderLine(attStr: NSMutableAttributedString,
                             range: NSRange,
                             url : URL!) -> NSMutableAttributedString{
        attStr.addAttribute(NSAttributedString.Key.link, value: url!, range: range)
        attStr.addAttribute(NSAttributedString.Key.underlineStyle, value: NSNumber(value: 1), range: range)
        attStr.addAttribute(NSAttributedString.Key.underlineColor, value: UIColor.black, range: range)
        return attStr
    }
    
    ///add shadow at bottom
    public func showShadowAtBottom(view: UIView){
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 50)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 1.0
    }
    
    ///present view controller with model presentation style
    public func presentModally(vc: UIViewController,
                               fromVC : UIViewController){
        vc.providesPresentationContextTransitionStyle = true
        vc.definesPresentationContext = true
        vc.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            fromVC.present(vc, animated: true, completion: nil)
        }
    }
    
    ///present view controller with model presentation style
    public func presentModallyOnRoot(vc: UIViewController){
        vc.providesPresentationContextTransitionStyle = true
        vc.definesPresentationContext = true
        vc.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            if let rootWindow = UIApplication.shared.keyWindow?.rootViewController{
                rootWindow.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    ///create center label
    public func createCenterLblForTitle(titleTxt: NSString) -> UILabel{
        let label = UILabel(frame: CGRect(x:0, y:0, width:100, height:40))
        label.backgroundColor = .clear
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.center = CGPoint(x: 22, y: UIScreen.main.bounds.width / 2)
        
        //getting the range to separate the button title strings
        let newlineRange: NSRange = titleTxt.range(of: "\n")
        
        //getting both substrings
        var substring1: NSString = ""
        var substring2: NSString = ""
        
        if(newlineRange.location != NSNotFound) {
            substring1 = titleTxt.substring(to: newlineRange.location) as NSString
            substring2 = titleTxt.substring(from: newlineRange.location) as NSString
        }
        
        //assigning diffrent fonts to both substrings
        let font:UIFont? = UIFont.boldSystemFont(ofSize: 14)
        let attrString =  NSMutableAttributedString(string: substring1 as String, attributes: [NSAttributedString.Key.font: font!])
        
        let font1:UIFont? = UIFont.systemFont(ofSize: 11)
        let attrString1 =  NSMutableAttributedString(string: substring2 as String, attributes: [NSAttributedString.Key.font: font1!])
        
        //appending both attributed strings
        attrString.append(attrString1)
        
        //assigning the resultant attributed strings to the button
        label.attributedText = attrString
        return label
    }
    
    ///check if any field is empty or not
    public func checkWeatherTextFieldEmpty(textFieldWithErrorMsg: [UITextField: String]) -> String{
        for (textField, msg) in textFieldWithErrorMsg{
            if textField.text == ""{
                return msg
            }
        }
        return ""
    }
    
    ///make call
    public func makeCall(number: String){
        if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    ///open website on SF Safari
    public func openWeb(link: String,
                         isLocal: Bool=false,
                         tintColor: UIColor?=nil,
                         vc: UIViewController){
        
        var urlToShow : URL!
        if isLocal{
            urlToShow = URL(fileURLWithPath: link)
        }else{
            urlToShow = URL(string: link)
        }
        let svc = SFSafariViewController(url: urlToShow)
        svc.preferredControlTintColor = (tintColor == nil) ? self.controlTintColor : tintColor!
        svc.preferredBarTintColor = UIColor.white
        DispatchQueue.main.async {
            vc.present(svc, animated: true, completion: nil)
        }
    }
    
    ///get string presentation of integer value
    public func getStringOfInteger(value: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .spellOut
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
    
    ///get date ago in yesterday, today, tomorrow
    public func getDateOrAgoFrom(date: Date) -> String{
        let calendar = Calendar.current
        if calendar.isDateInYesterday(date){
            return "Yesterday"
        }else if calendar.isDateInToday(date){
            return "Today"
        }else if calendar.isDateInTomorrow(date){
            return "Tomorrow"
        }else{
            return Formatter.getInstance.dateTimeFormatterWithDay().string(from: date)
        }
    }
    
    ///round off to point .2f
    public func roundOfPoint25Of(num: Double) -> Double{
        
        let floorInt : Int = Int(floor(num))
        var afterDecimalFinal = 0.0
        let remainderDecimal = num.truncatingRemainder(dividingBy: 1)
        let twoDigitsDecimal : Double = Double(String(format: "%.2f", arguments: [remainderDecimal]))!
        
        if twoDigitsDecimal != 0.00{
            if twoDigitsDecimal <= 0.25{
                afterDecimalFinal = 0.25
            }else if twoDigitsDecimal <= 0.50{
                afterDecimalFinal = 0.50
            }else if twoDigitsDecimal <= 0.75{
                afterDecimalFinal = 0.75
            }else if twoDigitsDecimal > 0.75{
                afterDecimalFinal = 1.0
            }
        }
        let returnDouble : Double = Double(Double(floorInt) + afterDecimalFinal)
        return returnDouble
        
    }
    
    ///make glow on view
    public func makeGlowOnView(view: UIView){
        let color = UIColor.red
        view.layer.shadowColor = color.cgColor
        view.layer.shadowRadius = 4.0
        view.layer.shadowOpacity = 0.9
        view.layer.shadowOffset = CGSize.zero
        view.layer.masksToBounds = false
    }
    
    ///remove flow on view
    public func removeGlowFromView(view: UIView){
        let color = UIColor.clear
        view.layer.shadowColor = color.cgColor
        view.layer.shadowRadius = 0.0
        view.layer.shadowOpacity = 0.0
        view.layer.shadowOffset = CGSize.zero
        view.layer.masksToBounds = true
    }
    
    ///show location disable alert
    public func showLocationSettingsAlert(){
        let appDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
        let alert = UIAlertController(title: "Alert", message: "\"\(appDisplayName)\" Detect that your application's location setting is disable, Please enable location service for better results.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Go to settings", style: .default) { (action) in
            Helper.getInstance.openAppSettings()
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        DispatchQueue.main.async{
            if let rootWindow = UIApplication.shared.keyWindow?.rootViewController{
                rootWindow.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    ///show contact disable alert
    public func showContactSettingsAlert(){
        let appDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
        let alert = UIAlertController(title: "Alert", message: "\"\(appDisplayName)\" Detect that your application's contact permission is disable. Kindly enable permission to find your friends.", preferredStyle: .alert)
        let cancelaction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        let action = UIAlertAction(title: "Go to settings", style: .default) { (action) in
            Helper.getInstance.openAppSettings()
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelaction)
        alert.addAction(action)
        DispatchQueue.main.async{
            if let rootWindow = UIApplication.shared.keyWindow?.rootViewController{
                rootWindow.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    ///open application settings
    public func openAppSettings(){
        DispatchQueue.main.async {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                } else {
                    UIApplication.shared.openURL(settingsUrl as URL)
                }
            }
        }
    }
    
    ///convert string to dictionary
    public func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    //Email Validation
    public func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    //Password Validation
    public func isValidPassword(testStr:String) -> Bool {
        let passRegEx = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[-_!?/<>;:{}()*@#$%^&+=])(?=\\S+$).{4,}$"
        
        let passTest = NSPredicate(format:"SELF MATCHES %@", passRegEx)
        return passTest.evaluate(with: testStr)
    }
    
    public func getMimeTypeForPath(path: String) -> String {
        let url = NSURL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    
    public func playVideo(path: URL,
                          sourceVC: UIViewController) {
        let player = AVPlayer(url: path)
        let playerController = AVPlayerViewController()
        playerController.player = player
        DispatchQueue.main.async {
            sourceVC.present(playerController, animated: true) {
                player.play()
            }
        }
    }
    
    public func getPercentageFromCountString(resultCount: Int, totalCount: Int) -> String{
        if (Double(Double(resultCount)/Double(totalCount)) * 100) == 0.0{
            return "0%"
        }
        if String(format: "%.1f", Double(Double(resultCount)/Double(totalCount)) * 100).contains(".0") {
            return String(format: "%.0f", Double(Double(resultCount)/Double(totalCount)) * 100) + "%"
        }else{
            return String(format: "%.1f", Double(Double(resultCount)/Double(totalCount)) * 100) + "%"
        }
    }
    
    public func getPercentageFromCount(resultCount: Int, totalCount: Int) -> Double{
        return Double(Double(resultCount)/Double(totalCount)) * 100
    }
    
    public func setRememberMeIDPass(idStr: String, passStr: String){
        UserDefaults.standard.setValue(idStr, forKey: "RememberID")
        UserDefaults.standard.setValue(passStr, forKey: "RememberPass")
    }
    
    public func removeRememberMeIDPass(){
        UserDefaults.standard.setValue("", forKey: "RememberID")
        UserDefaults.standard.setValue("", forKey: "RememberPass")
    }
    
    public func getRememberMeIDPass() -> Dictionary<String, String>?{
        var dic : [String: String]? = nil
        if let num = UserDefaults.standard.string(forKey: "RememberID") {
            dic = [:]
            dic!["Id"] = num
            if let pass = UserDefaults.standard.string(forKey: "RememberPass") {
                dic!["pass"] = pass
                return dic!
            }
        }
        return nil
    }
    
}
