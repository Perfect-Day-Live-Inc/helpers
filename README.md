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

for more features explore more...

3. **DateTimePicker** 

    This component is use to pick and time using default UIPickerView.
    
    Usage:

                          
                                                      