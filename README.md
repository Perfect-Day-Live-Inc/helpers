This library contains 10 helpers and extensions files which are can reduce alot of your efforts below are the helpers and extensions files names, their descriptions and usage.

* CommonAnimations (some common animations)
* AudioManager (to record, play and download)
* DatePickerManager (to show date picker in alert)
* TextfieldManager (to manager next, return keys for all textfields and textviews)
* MailComposer (to compose mail)
* LocationManager (to get and track user current location)
* PhoneContacts (to fetch and return all contacts from phone)
* Formatter (Custom date formatter which we use frequently)
* Helper (All Utilities methods)
* HelpfulExtensions (extension which contains many useful functions)


1. **CommonAnimations** 
 
    This file contains simple animations which can use on any view to animate.
*  `animateViewToAngle`

    This function is used to rotate view to from left to right in 45, 90, 135 or 180 degrees.
    
    Usage:
```
    Animations.shared().animateViewToAngle(viewToRotate: self.viewToAnimate,
                                                   angle: .Deg135,
                                                   repeated: false)
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
*  `scaleViewAnimation`

    This function is used to scale view, 
    
    here x, y = 1 is equals to your current size of width, height and for final if you enter 2 then it will be multiple of your current width height scale.
    
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

*  `translateAndScaleView`

    This function is used to translate and scale view, 
    
    here scale is multiple of view's existing widht/ height. You can use completion handler if you want to do some work after completions.
    
    Usage:
```
    Animations.shared().translateAndScaleView(viewToAnimate: self.viewToAnimate,
                                              scaleX: 1.2,
                                              scaleY: 1.2,
                                              translationX: 0,
                                              translationY: self.viewToAnimate.frame.origin.y - 50,
                                              completion: nil)
```
*  `bounceAnimationToView`

    This function is will bounce view and also allow to change view transparency during bouncing. 
    
    here in bouncingY's negative value will bounce view in upward direction and positive value will bounce view in downward direction.
    
    Usage:
```
    Animations.shared().bounceAnimationToView(viewToAnimate: self.viewToAnimate,
                                             bouncingY: -50,
                                             initialAlpha: 0.2,
                                             finalAlpha: 1.0,
                                             completion: nil)
```
*  `setHideProperty`

    This function is will hide view with smothe animation.
    
    Usage:
```
    Animations.shared().setHideProperty(view: self.viewToAnimate,
                                        hidden: true)

```
*  `fadeOut/fadeIn`

    This function is use to fadeIn or fadeOut animation for view hide and show.
    
    Usage:
```
    Animations.shared().fadeOut(view: self.viewToAnimate,
                                duration: 2,
                                delay: 0.4,
                                completion: { (success) in })
                                
                                
    Animations.shared().fadeIn(view: self.viewToAnimate,
                               duration: 2,
                               delay: 0.4,
                               completion: { (success) in })
```

2. **AudioManager** 

    This Manager contains all common audio operations which any will require in any app. such as: Audio Recording, Audio Downloading, Play Audio from URL, Play Audio from Local.
    
    Usage:
    
*   `To record audio`
```
    AudioManager.getInstance().recordAudio()
```

*   `To stop recording`
```
    AudioManager.getInstance().finishRecording { (url) in
        //this is the local url where your app's audio is record.
    }
```

*   `To download audio`
```
    AudioManager.getInstance().downloadFile(from: url, completion: { (isSuccess, data) in
        if isSuccess{
            //data of downloaded audio
        }
    })
```

*   `Play audio from local URL`
```
    AudioManager.getInstance().playAudioFromLocal(url: url)
```

*   `Play audio from URL`
```
    AudioManager.getInstance().downloadAndPlayAudio(url: url)
```

*    `Play audio from data`
```
    AudioManager.getInstance().playAudioFromData(data: data!)
```

*    `Stop audio and clear cache`
```
    AudioManager.getInstance().stopAndClearSession()
```

for more features explore more...

3. **DateTimePicker** 

    This component is use to pick and time using default UIPickerView.
    
*   `show DatePicker`

    if maximumDate is not given in argument than it will consider as current date.
    
    Usage:
```
    guard let minimumDate = Calendar.current.date(byAdding: .year, value: -18, to: Date()) else{
        return
    }
    guard let maximumDate = Calendar.current.date(byAdding: .year, value: -4, to: Date()) else{
        return
    }
    DateTimePicker.getInstance.showDatePicker(fromVC: self,
                                              tintColor: .blue,
                                              minimumDate: minimumDate,
                                              maximumDate: maximumDate,
                                              selectedDate: nil) { (date) in
                                                if date != nil{
                                                    print(date)
                                                }
    }
```

*   `show TimePicker`

    if maximumTime is not given in argument than it will consider as current time.
    
    Usage:
```
    guard let minimumDate = Calendar.current.date(bySettingHour: 00, minute: 00, second: 00, of: Date()) else{
        return
    }
        
    let maximumDate = Date()
        
    DateTimePicker.getInstance.showTimePicker(fromVC: self,
                                              tintColor: .blue,
                                              minimumTime: minimumDate,
                                              maximumTime: maximumDate,
                                              selectedTime: nil) { (date) in
                                                if date != nil{
                                                    print(date)
                                                }
    }
        
```

4. **TextfieldManager** 

    This is really helpful manager, we always need to make delegate of textfields and textviews so we will move to next or previous textfield on responder button. Even if you use great library IQKeyBoardManager (https://github.com/hackiftekhar/IQKeyboardManager), you need to make delegates and do some stuff on it to make those responder buttons usable.
    This Manager helps you to automatically detect your next textfield and make 'Next', 'Done' button bydefault.
    
*   `Setup TextFeilds and TextViews Responders`

    to enable this helpful feature only call this function which takes two parameters 'textInputViewsArr' and 'isToolBarRequired'. 'textInputViewsArr' takes array of textfields and textviews orderwise (which should respond first then next til last). 'isToolBarRequired' if you want to show toolbar for on top of keyboard then make this 'true'.
    
    
    Usage:
```
    TextFieldManager.instance.setupTextFieldsAndTextViews(textInputViewsArr: [YOUR_TEXTFIELD_NO_1,
                                                                             YOUR_TEXTFIELD_NO_2,
                                                                             YOUR_TEXTVIEW],
                                                          isToolBarRequired:  true)
```
    That's all, now this TextfeildManager class will manage all of the stuff.


4. **MailComposer** 

      This Simple Component is use to send email to single or multiple receipt.
    
*   `Send Email`

    In this function there are 4 parameters:
    'recipients': recipients to send email.
    'barTintColor': MailComposerViewController's NavigaitonBar tint Color.
    'itemsColor': MailComposerViewController's items color.
    'body': Body or Message which you want to share on email.
    
    Usage:
```
    
    MailComposer.getInstance().sendEmail(recipients: ["alimaniar@gmail.com",
                                                     "msalmanraza@gmail.com",
                                                     "ashirjavedvayani@gmail.com",
                                                     "ahmedcs@live.com"],
                                         barTintColor: .blue,
                                         itemsColor: .white,
                                         body: "WRTIE EMAIL BODY MESSAGE HERE...")
```
    
                 
                                                      