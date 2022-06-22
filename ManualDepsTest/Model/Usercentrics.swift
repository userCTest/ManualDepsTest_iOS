//
//  Usercentrics.swift
//  testApp
//
//  Created by Hugo Silva on 12/01/2022.
//

import Foundation
import Usercentrics
import UsercentricsUI
import UIKit

struct Usercentrics {

    private let sdkDefaults = SDKDefaults()
    
    func appInit(){
        /// Initialize Usercentrics with your configuration
        let options = UsercentricsOptions(settingsId: sdkDefaults.settingsId)
        options.loggerLevel = .debug
        UsercentricsCore.configure(options: options)
    }
    
    func applyConsent(with consents: [UsercentricsServiceConsent]) {
        self.getCMPData(consents: consents)
    }
    
    private func getCMPData(consents: [UsercentricsServiceConsent]){
        UsercentricsCore.isReady { status in

            // CMP Data
            //let data = UsercentricsCore.shared.getCMPData()
            //let settings = data.settings
            //let tcfSettings = settings.tcf2
            // Non-TCF Data - if you have services not included in IAB
            //let services = data.services
            //let categories = data.categories
            //print("-- CMP DATA --")
            //print("Categories: \(categories)")
            
            print("-- BANNER MESSAGE --")
            print(UsercentricsCore.shared.getCMPData().settings.firstLayerDescription.string)
            
            print("-- GET CONSENTS -- ")
            for consent in consents {
                print("\(String(describing: consent.dataProcessor).padding(toLength: 40, withPad: " ", startingAt: 0)) | TemplateId: \(String(describing: consent.templateId).padding(toLength: 10, withPad: " ", startingAt: 0)) | Consent Status: \(String(describing: consent.status).padding(toLength: 10, withPad: " ", startingAt: 0)) ")
            }
            
            // TCF Data
            UsercentricsCore.shared.getTCFData{ tcfData in
                //let tcfData = UsercentricsCore.shared.getTCFData()
                let purposes = tcfData.purposes
                //let specialPurposes = tcfData.specialPurposes
                //let features = tcfData.features
                //let specialFeatures = tcfData.specialFeatures
                //let stacks = tcfData.stacks
                let vendors = tcfData.vendors

                // TCString
                print("-- TCSTRING --")
                //let tcString = UsercentricsCore.shared.getTCString()
                let tcString = tcfData.tcString
                print("TCString: \(tcString)")

                print("-- PURPOSES --")
                let purposesList = purposes.sorted(by: { tcfVendor1, tcfVendor2 in
                    tcfVendor1.id < tcfVendor2.id })
                
                for purpose in purposesList {
                    print("\(String(describing: purpose.name).padding(toLength: 40, withPad: " ", startingAt: 0)) | Id: \(String(describing: purpose.id).padding(toLength: 10, withPad: " ", startingAt: 0)) | LI Toggle: \(String(describing: purpose.showLegitimateInterestToggle).padding(toLength: 10, withPad: " ", startingAt: 0)) | LI Value: \(String(describing: purpose.legitimateInterestConsent).padding(toLength: 10, withPad: " ", startingAt: 0))")
                }

                print("-- VENDORS WITH CONSENT TRUE--")
                var vendorsList = vendors.filter { tcfVendor in tcfVendor.consent == true }
                vendorsList = vendorsList.sorted(by: { tcfVendor1, tcfVendor2 in
                    tcfVendor1.id < tcfVendor2.id })

                for vendor in vendorsList {
                    print("\(String(describing: vendor.name).padding(toLength: 40, withPad: " ", startingAt: 0)) | Id: \(String(describing: vendor.id).padding(toLength: 7, withPad: " ", startingAt: 0))")
                }
                
                print("-- PURPOSES WITH LI TRUE--")
                var vendorsListLI = vendors.filter { tcfVendor in tcfVendor.legitimateInterestConsent == true }
                vendorsListLI = vendorsList.sorted(by: { tcfVendor1, tcfVendor2 in
                    tcfVendor1.id < tcfVendor2.id })

                for vendor in vendorsListLI {
                    print("\(String(describing: vendor.name).padding(toLength: 40, withPad: " ", startingAt: 0)) | Id: \(String(describing: vendor.id).padding(toLength: 7, withPad: " ", startingAt: 0))")
                    print("--\(vendor.name) LI Purposes --")
                    for vendor in vendor.legitimateInterestPurposes {
                        print("|$| \(String(describing: vendor.name).padding(toLength: 40, withPad: " ", startingAt: 0)) | Id: \(String(describing: vendor.id).padding(toLength: 7, withPad: " ", startingAt: 0)) |$|")
                    }
                }
            }

        } onFailure: { error in
            print("Error on initialization: \(error.localizedDescription)")
        }
    }
}
