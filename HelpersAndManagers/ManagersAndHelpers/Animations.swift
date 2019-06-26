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
    
    public func rotateViewTo45Degree(viewToRotate view: UIView) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = NSNumber(value: 0.0)
        rotation.toValue = NSNumber(value: Double.pi / 4)
        rotation.duration = 4.0
        rotation.repeatCount = Float.greatestFiniteMagnitude
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
    
    public func translateAndThenScaleView(viewToAnimate: UIView, scaleX: CGFloat, scaleY: CGFloat, translationX: CGFloat, translationY: CGFloat, completion: (() -> Void)?){
        
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
    
    
    public func bounceAnimationToView(viewToAnimate: UIView, finalY: CGFloat, initalAnimationY: CGFloat, completion: (() -> Void)?){
        
        let originalTransform = viewToAnimate.transform
        var scaledTransform = originalTransform.translatedBy(x: 0.0, y: initalAnimationY)
        UIView.animate(withDuration: 0.2, animations: {
            viewToAnimate.transform = scaledTransform
        }) { (isSuccess) in
            scaledTransform = originalTransform.translatedBy(x: 0.0, y: finalY)
            UIView.animate(withDuration: 0.2, animations: {
                viewToAnimate.transform = scaledTransform
            }) { (isSuccess) in
                
                if completion != nil{
                    completion!()
                }
            }
        }
    }
    
    public func bounceAnimationToViewWithTransprancy(viewToAnimate: UIView, finalY: CGFloat, initalAnimationY: CGFloat, completion: (() -> Void)?){
        
        let originalTransform = viewToAnimate.transform
        var scaledTransform = originalTransform.translatedBy(x: 0.0, y: initalAnimationY)
        UIView.animate(withDuration: 0.2, animations: {
            viewToAnimate.transform = scaledTransform
            viewToAnimate.alpha = 0.5
        }) { (isSuccess) in
            scaledTransform = originalTransform.translatedBy(x: 0.0, y: finalY)
            UIView.animate(withDuration: 0.2, animations: {
                viewToAnimate.transform = scaledTransform
                viewToAnimate.alpha = 1.0
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
    public func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.7, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    
    /// FADE IN VIEW WITH ANIMATION
    ///
    /// - Parameter view: VIEW TO FADE
    /// - Returns: RETURN FINISHES COMPLETION
    public func fadeIn(view: UIView, duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
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
    public func fadeOut(view: UIView, duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        view.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            view.alpha = 0.0
        }) { (completed) in
            //            self.isHidden = true
            completion(true)
        }
    }
}
