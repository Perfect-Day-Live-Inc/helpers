This library contains 10 helpers and extensions files which are can reduce alot of your efforts below are the helpers and extensions files names, their descriptions and usage.

* CommonAnimations (some common animations)
* AudioManager (to record, play and download)
* DatePickerManager (to show date picker in alert)
* Formatter (Custom date formatter which we use frequently)
* Helper (All Utilities methods)
* HelpfulExtensions (extension which contains many useful functions)
* LocationManager (to get and track user current location)
* MailComposer (to compose mail)
* PhoneContacts (to fetch and return all contacts from phone)
* TextfieldManager (to manager next, return keys for all textfields and textviews)


1. **CommonAnimations** 
    This file contains simple animations which can use on any view to animate.
*  `rotateViewTo45Degree`
            This function is used to rotate view to from left to right 45 degrees.
            Usage:
```
                    Animations.shared().rotateViewTo45Degree(viewToRotate: self.viewToAnimate, repeated: false)
```
* `tanslateViewAnimation`
            This function is used to translate view with animation.
            Usage:
```
                    let finalFrame = CGRect.init(x: self.viewToAnimate.frame.origin.x,
                                         y: self.viewToAnimate.frame.origin.y - 50,
                                         width: self.viewToAnimate.frame.width,
                                         height: self.viewToAnimate.frame.height)
                Animations.shared().tanslateViewAnimation(view: self.viewToAnimate,
                                                      finalFrame: finalFrame,
                                                      initalFrame: self.viewToAnimate.frame,
                                                      initalAlpha: 1.0,
                                                      finalAlpha: 0.5,
                                                      duration: 3.0) 
```
*  `rotateViewTo45Degree`
            This function is used to scale view, note: x, y = 1 is equals to your current size of width, height and for final if you enter 2 then it will be multiple of your current width hieght scale.
            Usage:
```
            Animations.shared().scaleViewAnimation(view: self.viewToAnimate,
                                                   scaleInitialX: 1,
                                                   scaleFinalX: 2,
                                                   scaleInitialY: 1,
                                                   scaleFinalY: 2,
                                                   initalAlpha: 1.0,
                                                   finalAlpha: 0.5,
                                                   duration: 4.0)
```
                                                      