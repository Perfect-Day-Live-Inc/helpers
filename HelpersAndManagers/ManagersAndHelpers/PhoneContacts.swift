//
//  AlertView.swift
//  InvisibleGuardian
//
//  Created by MacBook Retina on 10/13/17.
//  Copyright © 2017 M. Arqam Owais. All rights reserved.
//


import Foundation
import ContactsUI

public enum ContactsFilter {
    case none
    case mail
    case message
}


open class PhoneContacts {
    
    class public func getContacts(filter: ContactsFilter = .none) -> [CNContact] { //  ContactsFilter is Enum find it below
        
        let contactStore = CNContactStore()
        let keysToFetch = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey] as [Any]
        
        var allContainers: [CNContainer] = []
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch (let error){
            print(error.localizedDescription)
            if error.localizedDescription == "Access Denied"{
                Helper.getInstance.showContactSettingsAlert()
            }
            //Debug.Log(message: "Error fetching containers") // you can use print()
        }
        
        var results: [CNContact] = []
        
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
            } catch {
                //Debug.Log(message: "Error fetching containers")
            }
        }
        return results
    }
}
