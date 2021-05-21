//
//  SPViewController.swift
//  Friends
//
//  Created by Md. Mamun-Ur-Rashid on 5/21/21.
//

import UIKit

class SPViewController: UIViewController {
    
   var isLandScape = UIWindow.isLandscape

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateOrientation), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    /// Update layout based on current orientation
    @objc func updateOrientation() {
        if self.isLandScape != UIWindow.isLandscape {
            self.isLandScape = UIWindow.isLandscape
            self.updateLayoutForOrientation()
        }
    }

    func updateLayoutForOrientation() {
        // Override at child controller
    }

}

extension SPViewController {
    
    func showAlert(withMessage text:String)  {
        
        let alertController = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        alertController.modalPresentationCapturesStatusBarAppearance = true
        alertController.view.tintColor = UIColor.blue
        let cancelAction = UIAlertAction(title: "Okay", style: .default) { (action:UIAlertAction) in }
        alertController.addAction(cancelAction)
        DispatchQueue.main.async {
           self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
}
