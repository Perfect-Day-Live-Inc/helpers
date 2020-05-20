//
//  MailComposer.swift
//  SafeSpaceHealth
//
//  Created by Muhammad Ahmed Baig on 31/12/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import Foundation
import Swift
import MessageUI

extension UIApplication {

    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {

        if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}

open class MailComposer : NSObject{
    
    private override init() {}
    static private let instance = MailComposer()
    static public func getInstance() -> MailComposer{ return instance }
    var barTintColor : UIColor = .white
    var itemsColor : UIColor = .black
    
    public func sendEmail(recipients: [String],
                          barTintColor: UIColor=UIColor.white,
                          itemsColor: UIColor=UIColor.black,
                          body: String) {
        if MFMailComposeViewController.canSendMail() {
            self.barTintColor = barTintColor
            self.itemsColor = itemsColor
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(recipients)
            mail.setMessageBody(body, isHTML: true)
            
//            if let window = UIApplication.shared.delegate?.window{
            if let rootV = UIApplication.getTopViewController(){
                rootV.present(mail, animated: true, completion: nil)
            }
//            }
        } else {
            // show failure alert
            Helper.getInstance.showAlert(title: "Alert", message: "Your device didn't configure email settings")
        }
    }
    
}

extension MailComposer: MFMailComposeViewControllerDelegate{
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}

extension MFMailComposeViewController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.isTranslucent = false
        navigationBar.isOpaque = false
        navigationBar.barTintColor = MailComposer.getInstance().barTintColor//UIColor.white
        navigationBar.tintColor = MailComposer.getInstance().itemsColor//UIColor.orange
    }
}
