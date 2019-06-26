//
//  HelpfulExtensions.swift
//  CommonComponents
//
//  Created by Muhammad Ahmed Baig on 27/05/2019.
//

import Foundation
import Swift
import UIKit



extension UIColor {
    
    /// THIS FUNCTION CAN RETURN A TRANSPARENT IMAGE OF 1 POINT HEIGHT.
    ///
    /// - Returns: IMAGE TO RETURN
    public func as1ptImage() -> UIImage {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        let ctx = UIGraphicsGetCurrentContext()
        self.setFill()
        ctx!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///This Extension is use to get version number and build number of application

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

extension Bundle {
    
    /// APP VERSION NUMBER
    public var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    /// APP BUILD NUMBER
    public var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}


//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

///This extension contains some important functions which are using in approximately whole applications screen
///this contains back button code
///menu btn code
///their actions

//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//
//------------------------------------------------------------------------------------------------------//

extension UIViewController : UIGestureRecognizerDelegate{
    
    /// THIS FUNCTION WILL SET STATUS BAR BACKGROUND COLOR
    ///
    /// - Parameter color: STATUS BAR BACKGROUND COLOR
    public func setStatusBarColor(color: UIColor?=UIColor.clear){
        let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
            statusBar.backgroundColor = color
        }
    }
    
    ///return back bar button which are using in whole app
    public func backBarButton(image: UIImage) -> UIBarButtonItem {
        self.swipeToPopEnable()
        let backButtonItem = UIBarButtonItem(image: image,
                                             style: .plain,
                                             target: self,
                                             action: #selector(BackButtonTapped))
        return backButtonItem
    }
    
    ///Back Btn Action
    @objc public func BackButtonTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    /// THIS FUNCTION WILL REMOVE DEFAULT BACK GESTURE
    public func swipeToPopDisable() {
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    /// THIS GESTURE WILL ENABLE / ADD DEFAULT BACK GESTURE
    public func swipeToPopEnable() {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
    }
    
    /// GESTURE RECOGNIZER DELEGATE
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.navigationController?.interactivePopGestureRecognizer {
            return false
        }
        return true
    }
    
}


///Extension of string to perform multiple dunctions
extension String {
    
    ///get height from constant width font of string
    ///    width: width size
    ///    font: font size to use
    public func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    ///convert html to attributed string.
    public var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    
    public var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    //Email Validation
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
}



///Extension to change size and quality of image
extension UIImage {
    
    public enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    public func jpeg(_ quality: JPEGQuality) -> Data? {
        
        return self.jpegData(compressionQuality: quality.rawValue)
    }
    
    public func createSelectionIndicator(color: UIColor, size: CGSize, lineWidth: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint(x: 0,y :(size.height - lineWidth) - 2), size: CGSize(width: size.width, height: lineWidth)))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}

///extension of view to make dropshadow
extension UIView {
    
    /// ADD DROP SHADOW TO VIEW
    public func dropShadow(scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    /// ADD DROPSHADOW WITH OPTIONS TO VIEW
    ///
    /// - Parameters:
    ///   - color: COLOR OF SHADOW
    ///   - opacity: OPACITY OF SHADOW
    ///   - offSet: DISTANCE OF SHADOW FROM OUTPUT IN CGSIZE
    ///   - radius: ROUND FROM CORNERS
    ///   - scale: SCALE OF SHADOW
    public func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    /// ADD GREDIENT TO VIEW
    ///
    /// - Parameters:
    ///   - color1: COLOR ONE
    ///   - color2: COLOR TWO
    public func addGradient(color1: UIColor=UIColor.clear, color2: UIColor=UIColor.black){
        
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0, 0.8, 0.8, 1]
        self.layer.mask = gradient
    }
    
    /// MAKE CURVE CORNERS ONLY
    ///
    /// - Parameters:
    ///   - corners: CORNERS TO CURVE
    ///   - size: SIZE OF CURVE
    public func curveCorners(_ corners: UIRectCorner, size: CGSize) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: size)
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
