//
//  LocationManager.swift
//  Scholarship
//
//  Created by Muhammad Ahmed Baig on 12/22/17.
//  Copyright © 2017 PNC. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit


public enum LocationAuthorization{
    case requestWhenInUse
    case requestAlways
}

///This Protocol is an delegation pattren implementation of "LocationManager" class
public protocol LocationManagerDelegate {
    ///If location updates occurs this delegate will call
    /// - parameter latitude:   latitude of user's current locations coordinate will pass in this parameter.
    /// - parameter longitude:   longitude of user's current locations coordinate will pass in this parameter.
    /// - parameter address:   user's current locations address will pass in this parameter.
    func locationUpdate(latitude: Double, longitude: Double, address: String?)
    
    /// if location updates fails this delegate will call
    /// - Parameter msg: error message
    func locationUpdateFailed(withError msg: String)
}

///This class is use to get and manage user current location
open class LocationManager : NSObject, CLLocationManagerDelegate {
    
    //----------------------------------------------------------//
    ///To achieve Singleton approch make init method "private"
    override private init() { super.init(); self.settingDelegateToSelf()}
    public static let getInstance = LocationManager()
    //----------------------------------------------------------//
    
    private static let manager = CLLocationManager()
    public var delegate : LocationManagerDelegate?
    
    public var managerStatus : LocationAuthorization = .requestWhenInUse
    
    private static var currentLocation : CLLocation?
    private static var currentLocationAddress = ""
    
    ///"private" function to get Permissions of locations from user
    private func settingDelegateToSelf(){
        LocationManager.manager.delegate = self
    }
    
    public func settingLocation(authorizationStatus: LocationAuthorization){
        if authorizationStatus == .requestWhenInUse{
            // Request when-in-use authorization initially
            managerStatus = .requestWhenInUse
        }else if authorizationStatus == .requestAlways{
            // Request always-use authorization initially
            managerStatus = .requestAlways
        }
    }
    
    /**
     This function is use to get current Location of user
    **/
    public func gettingLocation(delegateVC: LocationManagerDelegate?=nil){
        LocationManager.currentLocation = LocationManager.manager.location
        self.delegate = delegateVC
        
        let authorizationStatus = CLLocationManager.authorizationStatus()
        switch authorizationStatus {
        case .denied:
            self.showLocationSettingsAlert()
            return
        case .notDetermined:
            if managerStatus == .requestAlways{
                LocationManager.manager.requestAlwaysAuthorization()
            }else{
                LocationManager.manager.requestWhenInUseAuthorization()
            }
            break
        case .restricted:
            self.showLocationSettingsAlert()
            return
        default:
            break
        }
        
        LocationManager.manager.startUpdatingLocation()
    }
    
    
    ///show location disable alert
    func showLocationSettingsAlert(){
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
    
    //------------------------------------------------------------------------------------------------------//
    //------------------------------------------ LOCATION MANAGER ------------------------------------------//
    //------------------------------------------------------------------------------------------------------//
    // MARK: Location Manager's Delegate.
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse && status != .authorizedAlways{
            self.settingLocation(authorizationStatus: self.managerStatus)
        }else{
            LocationManager.manager.startUpdatingLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if managerStatus != .requestAlways{
            LocationManager.manager.stopUpdatingLocation()
        }
        if locations.count != 0{
            let location = locations.last
            LocationManager.currentLocation = location
            self.getAddressFromLatLong(location: location!)
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if error.localizedDescription == "The operation couldn’t be completed. (kCLErrorDomain error 1.)"{
            self.showLocationSettingsAlert()
        }else{
            if managerStatus != .requestAlways{
                LocationManager.manager.stopUpdatingLocation()
            }
            if self.delegate != nil{
                delegate!.locationUpdateFailed(withError: error.localizedDescription)
            }
        }
    }
    //------------------------------------------------------------------------------------------------------//
    //------------------------------------------------------------------------------------------------------//
    //------------------------------------------------------------------------------------------------------//
    
    ///This function will get address from location
    /// - parameter location: pass the location by which you want to get address
    func getAddressFromLatLong(location: CLLocation){
        
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil{
                LocationManager.currentLocationAddress = ""
                if self.delegate != nil{
                    self.delegate!.locationUpdate(latitude: location.coordinate.latitude,
                                                  longitude: location.coordinate.longitude,
                                                  address: "")
                }
            }else {
                
                let place = placemark! as [CLPlacemark]
                if place.count > 0 {
                    let place = placemark![0]
                    let adressString : String = place.compactAddress ?? ""
                    LocationManager.currentLocationAddress = adressString
                    if self.delegate != nil{
                        self.delegate!.locationUpdate(latitude: location.coordinate.latitude,
                                                      longitude: location.coordinate.longitude,
                                                      address: adressString)
                    }
                }
            }
        }
    }
}

///Extension of CLPlacemark to add some important objects which we need
extension CLPlacemark {
    
    ///this string will contains street name city name and country name in a single string
    var compactAddress: String? {
        if let name = name {
            var result = name
            
            if let street = thoroughfare {
                result += ", \(street)"
            }
            
            if let city = locality {
                result += ", \(city)"
            }
            
            if let country = country {
                result += ", \(country)"
            }
            
            return result
        }
        
        return nil
    }
    
}

extension CLLocation{
    
    func DegreesToRadians(_ degrees: Double ) -> Double {
        return degrees * Double.pi / 180
    }
    
    func RadiansToDegrees(_ radians: Double) -> Double {
        return radians * 180 / Double.pi
    }
    
    
    func bearingToLocationRadian(_ destinationLocation:CLLocation) -> Double {
        
        let lat1 = DegreesToRadians(self.coordinate.latitude)
        let lon1 = DegreesToRadians(self.coordinate.longitude)
        
        let lat2 = DegreesToRadians(destinationLocation.coordinate.latitude);
        let lon2 = DegreesToRadians(destinationLocation.coordinate.longitude);
        
        let dLon = lon2 - lon1
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        let radiansBearing = atan2(y, x)
        
        return radiansBearing
    }
    
    func bearingToLocationDegrees(destinationLocation:CLLocation) -> Double{
        return   RadiansToDegrees(bearingToLocationRadian(destinationLocation))
    }
}

