//
//  AudioManager.swift
//  SafeSpaceHealth
//
//  Created by Muhammad Ahmed Baig on 29/10/2018.
//  Copyright © 2018 Appiskey. All rights reserved.
//

import Foundation
import AVFoundation


enum AudioPlayingStatus{
    case playing
    case downloading
    case none
}

public protocol AudioManagerDelegate {
    func audioFinishPlaying()
}

open class AudioManager : NSObject{
    
    private override init() { super.init(); NotificationCenter.default.addObserver(self, selector: #selector(handleRouteChange(_:)), name: AVAudioSession.routeChangeNotification, object: nil) }
    static private let instance = AudioManager()
    static public func getInstance() -> AudioManager{ return instance }
    
    private var recordingSession : AVAudioSession!
    private var audioRecorder    : AVAudioRecorder!
    private var settings         = [String : Int]()
    private var audioPlayer: AVAudioPlayer? = nil
    
    public var delegate: AudioManagerDelegate? = nil
    var currentDownloadTask: URLSessionDataTask? = nil
    
    public func recordAudio(){
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(AVAudioSession.Category.playAndRecord,
                                             mode: AVAudioSession.Mode.default,
                                             options: AVAudioSession.CategoryOptions.defaultToSpeaker)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.startRecording()
                    } else {
                        print("Dont Allow")
                    }
                }
            }
        } catch {
            print("failed to record!")
        }
        
        // Audio Settings
        settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
    }
    
    func directoryURL() -> URL? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        var randomString = UUID().uuidString
        randomString = randomString.replacingOccurrences(of: "-", with: "")
        let soundURL = documentDirectory.appendingPathComponent("\(randomString).aac")
        print(soundURL ?? "")
        return soundURL
    }
    
    public func stopAndClearSession(){
        if self.audioPlayer != nil{
            self.audioPlayer!.stop()
        }
        self.recordingSession = nil
        self.audioRecorder = nil
        self.audioPlayer = nil
        
    }
    
    public func pauseSession(){
        if self.audioPlayer != nil{
            self.audioPlayer!.pause()
        }
    }
    
    private func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            audioRecorder = try AVAudioRecorder(url: self.directoryURL()!,
                                                settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            self.finishRecording(completion: { (url) in })
        }
        do {
            try audioSession.setActive(true)
            audioRecorder.record()
        } catch {
        }
    }
    
    public func finishRecording(completion: @escaping (URL?)->Void) {
        if audioRecorder != nil{
            audioRecorder.stop()
        }
        if audioRecorder != nil{
            completion(audioRecorder.url)
        }
        audioRecorder = nil
    }
    
    public func playAudioFromLocal(url: URL){
        if self.audioPlayer == nil || self.audioPlayer?.url != url{
            self.stopAndClearSession()
            do {
                self.audioPlayer = try AVAudioPlayer(contentsOf: url)
                if self.recordingSession == nil{
                    recordingSession = AVAudioSession.sharedInstance()
                }
                try recordingSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
                try recordingSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                try recordingSession.setActive(false)
                
                if self.audioPlayer != nil{
                    self.audioPlayer!.prepareToPlay()
                    self.audioPlayer!.delegate = self
                    self.audioPlayer!.play()
                }
            } catch {
                print("failed to record!")
            }
            
        }else{
            self.audioPlayer!.play()
        }
    }
    
    public func playAudioFromData(data: Data){
        if self.audioPlayer == nil {
            self.stopAndClearSession()
            do {
                self.audioPlayer = try AVAudioPlayer(data: data)
                if self.recordingSession == nil{
                    recordingSession = AVAudioSession.sharedInstance()
                }
                try recordingSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
                try recordingSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                try recordingSession.setActive(false)
            } catch {
                print("failed to play!")
                if delegate != nil{
                    delegate!.audioFinishPlaying()
                }
            }
            if self.audioPlayer != nil{
                self.audioPlayer!.prepareToPlay()
                self.audioPlayer!.delegate = self
                self.audioPlayer!.play()
            }
        }else{
            self.audioPlayer!.play()
        }
    }
    
    public func downloadFile(from urlString: URL, completion: @escaping (Bool, Data?) -> ()) {
        
        if currentDownloadTask != nil{
            currentDownloadTask!.cancel()
        }
        // if the file doesn't exist than downloading
        currentDownloadTask = URLSession.shared.dataTask(with: urlString, completionHandler: { (data, response, error) in
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            // you can use the data! here
            completion(true, data)
            
        })
        currentDownloadTask?.resume()
    }
    
    public func downloadAndPlayAudio(url: URL){
        DispatchQueue.global(qos: .background).async {
            self.downloadFile(from: url, completion: { (isSuccess, data) in
                if isSuccess{
                    if data != nil{
                        DispatchQueue.main.async {
                            self.playAudioFromData(data: data!)
                        }
                    }
                }
            })
        }
    }
    
    private func IsHeadSetConnected() -> Bool{
        let route  = AVAudioSession.sharedInstance().currentRoute;
        for desc   in route.outputs
        {
            let portType = desc.portType;
            if (portType == AVAudioSession.Port.headphones)
            {
                return true;
            }
            
        }
        
        return false;
    }
    
    @objc private func handleRouteChange(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let reasonRaw = userInfo[AVAudioSessionRouteChangeReasonKey] as? NSNumber,
            let reason = AVAudioSession.RouteChangeReason(rawValue: reasonRaw.uintValue)
            else { fatalError("Strange... could not get routeChange") }
        switch reason {
        case .oldDeviceUnavailable:
            print("oldDeviceUnavailable")
        case .newDeviceAvailable:
            print("headset/line plugged in")
            if recordingSession == nil{
                recordingSession = AVAudioSession.sharedInstance()
            }
            do {
                try recordingSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
                try recordingSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                try recordingSession.setActive(true)
            } catch {
                print("failed to record!")
            }
        case .routeConfigurationChange:
            print("headset pulled out")
            if recordingSession == nil{
                recordingSession = AVAudioSession.sharedInstance()
            }
            do {
                try recordingSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
                try recordingSession.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
                try recordingSession.setActive(true)
            } catch {
                print("failed to record!")
            }
        case .categoryChange:
            print("Just category change")
        default:
            print("not handling reason")
        }
    }
}

extension AudioManager : AVAudioRecorderDelegate{
    public func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            self.finishRecording { (url) in
            }
        }
    }
}

extension AudioManager : AVAudioPlayerDelegate{
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print(flag)
        if delegate != nil{
            delegate!.audioFinishPlaying()
        }
    }
    public func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?){
        print(error.debugDescription)
    }
    public func audioPlayerBeginInterruption(_ player: AVAudioPlayer){
        print(player.debugDescription)
    }
}
