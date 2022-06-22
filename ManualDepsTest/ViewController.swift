//
//  ViewController.swift
//  Test App
//
//  Created by Rui Reis on 05/03/2021.
//

import UIKit
import Usercentrics
import UsercentricsUI

class ViewController: UIViewController {
    
    // Usercentrics
    let uc = Usercentrics()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UsercentricsCore.isReady { status in
            
            print("Show CMP")
            self.showCMP(self, buttonIdentifier: "3")
        } onFailure: { error in
            // Handle non-localized error
        }
    }
    
    func showCMP(_ vc: UIViewController, buttonIdentifier: String?) {
        UsercentricsCore.isReady { [weak self] status in
            let ui = UsercentricsBanner()

            guard let self = self else { return }
                // Show First Layer and handle result
            ui.showFirstLayer(hostView: self, layout: UsercentricsLayout.sheet) { userResponse in
                        // Apply Consent
                self.uc.applyConsent(with: userResponse.consents)
                        // Track User Interaction with userResponse.userInteraction (Only if and until your tracking service has consent)
                        // Save controllerID in your own database with userResponse.controllerId (Needed for Cross-Device Consent Sharing)
                }
        } onFailure: { error in
            // Handle non-localized error
        }
    }
    
}
