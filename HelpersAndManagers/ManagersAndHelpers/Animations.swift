//
//  Animations.swift
//  InventoryMeApp
//
//  Created by Muhammad Ahmed Baig on 02/01/2019.
//  Copyright © 2019 Appiskey. All rights reserved.
//

import Foundation
import UIKit
import Swift

open class Animations {
    private init() {}
    private static let instanceOfClass = Animations()
    static public func shared() -> Animations { return instanceOfClass  }
    
    public enum RotationAngle{
        case Deg45
        case Deg90
        case Deg135
        case Deg180
    }
    
    public func animateViewToAngle(viewToRotate view: UIView,
                                   angle: RotationAngle,
                                   repeated: Bool) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = NSNumber(value: 0.0)
        let piFactor = Double.pi / 180
        switch angle {
        case .Deg45:
            rotation.toValue = NSNumber(value: piFactor * 45)
        case .Deg90:
            rotation.toValue = NSNumber(value: piFactor * 95)
        case .Deg135:
            rotation.toValue = NSNumber(value: piFactor * 135)
        default:
            rotation.toValue = NSNumber(value: piFactor * 180)
        }
        rotation.duration = 4.0
        rotation.repeatCount = (repeated) ? Float.greatestFiniteMagnitude : 0
        view.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    public func tanslateViewAnimation(view: UIView,
                                      finalFrame: CGRect,
                                      initalFrame: CGRect,
                                      initalAlpha: CGFloat,
                                      finalAlpha: CGFloat,
                                      duration: TimeInterval)
    {
        view.alpha = initalAlpha
        view.frame = initalFrame
        
        UIView.animate(withDuration: duration, animations: {
            view.alpha = finalAlpha
            view.frame = finalFrame
        }) { _ in
            view.frame = finalFrame
        }
    }
    
    public func scaleViewAnimation(view: UIView,
                                   scaleInitialX: CGFloat,
                                   scaleFinalX: CGFloat,
                                   scaleInitialY: CGFloat,
                                   scaleFinalY: CGFloat,
                                   initalAlpha: CGFloat,
                                   finalAlpha: CGFloat,
                                   duration: TimeInterval)
    {
        view.alpha = initalAlpha
        let initalScale = CGAffineTransform(scaleX: scaleInitialX, y: scaleInitialY)
        view.transform = initalScale
        
        UIView.animate(withDuration: duration) {
            view.alpha = finalAlpha
            view.transform = CGAffineTransform(scaleX: scaleFinalX, y: scaleFinalY)
        }
    }
    
    public func translateAndScaleView(viewToAnimate: UIView, scaleX: CGFloat, scaleY: CGFloat, translationX: CGFloat, translationY: CGFloat, completion: (() -> Void)?){
        
        let originalTransform = viewToAnimate.transform
        let scaledTransform = originalTransform.translatedBy(x: translationX, y: translationY)
        let scaledAndTranslatedTransform = scaledTransform.scaledBy(x: scaleX, y: scaleY)
        UIView.animate(withDuration: 0.7, animations: {
            viewToAnimate.transform = scaledAndTranslatedTransform
        }) { (isSuccess) in
            if completion != nil{
                completion!()
            }
        }
    }
    
    public func bounceAnimationToView(viewToAnimate: UIView,
                                      bouncingY: CGFloat,
                                      initialAlpha: CGFloat=1.0,
                                      finalAlpha: CGFloat=1.0,
                                      completion: (() -> Void)?){
        
        let originalTransform = viewToAnimate.transform
        var scaledTransform = originalTransform.translatedBy(x: 0.0, y: bouncingY)
        UIView.animate(withDuration: 0.2, animations: {
            viewToAnimate.transform = scaledTransform
            viewToAnimate.alpha = initialAlpha
        }) { (isSuccess) in
            scaledTransform = originalTransform.translatedBy(x: 0.0, y: 0.0)
            UIView.animate(withDuration: 0.2, animations: {
                viewToAnimate.transform = scaledTransform
                viewToAnimate.alpha = finalAlpha
            }) { (isSuccess) in
                
                if completion != nil{
                    completion!()
                }
            }
        }
    }
    
    
    /// THIS WILL HIDE/ UNHIDE VIEW WITH ANIMATION
    ///
    /// - Parameter view: VIEW TO HIDE
    /// - Parameter hidden: HIDDEN STATUS BOOL
    public func setHideProperty(view: UIView,
                                hidden: Bool) {
        UIView.transition(with: view, duration: 0.7, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    /// FADE IN VIEW WITH ANIMATION
    ///
    /// - Parameter view: VIEW TO FADE
    /// - Returns: RETURN FINISHES COMPLETION
    public func fadeIn(view: UIView,
                       duration: TimeInterval = 0.5,
                       delay: TimeInterval = 0.0,
                       completion: @escaping ((Bool) -> Void)) {
        view.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            //            self.isHidden = false
            view.alpha = 1.0
        }, completion: completion)
    }
    
    /// FADE OUT VIEW WITH ANIMATION
    ///
    /// - Parameter view: VIEW TO FADE
    /// - Returns: RETURN FINISHES COMPLETION
    public func fadeOut(view: UIView,
                        duration: TimeInterval = 0.5,
                        delay: TimeInterval = 0.0,
                        completion: @escaping ((Bool) -> Void)) {
        view.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            view.alpha = 0.0
        }) { (completed) in
            //            self.isHidden = true
            completion(true)
        }
    }
}
