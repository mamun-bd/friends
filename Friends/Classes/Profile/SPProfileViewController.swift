//
//  SPProfileViewController.swift
//  Friends
//
//  Created by Md. Mamun-Ur-Rashid on 5/21/21.
//

import UIKit
import MessageUI

class SPProfileViewController: SPViewController {
    
    @IBOutlet weak var profileContainer: UITableView!
    
    var information: SPUserModel?
    
    class func initWithUserInformation(information: SPUserModel?) -> SPProfileViewController {

        let storyboard  = UIStoryboard(name: SPConstants.kMainStoryboard, bundle: Bundle.main)
        if let controller = storyboard.instantiateViewController(withIdentifier: SPProfileViewController.className) as? SPProfileViewController {
            controller.information = information
            return controller
        } else {
            return SPProfileViewController()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hexString: "F9F6F4", alpha: 1.0)
        self.title = self.information?.getUserName()
        self.initializeContainer()
    }
    
    /// Container Initialization
    func initializeContainer() {
        self.profileContainer.dataSource = self
        self.profileContainer.delegate = self
        self.profileContainer.rowHeight = UITableView.automaticDimension
        self.profileContainer.estimatedRowHeight = UITableView.automaticDimension
        self.profileContainer.register(UINib(nibName: SPProfileCell.className, bundle: Bundle.main), forCellReuseIdentifier: SPProfileCell.className)
        self.profileContainer.separatorStyle = .none
        self.profileContainer.reloadData()
    }
    
    
    func sendEmail() {
      
        if( MFMailComposeViewController.canSendMail()) , let user = self.information {
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.modalPresentationCapturesStatusBarAppearance = true
            mailComposer.mailComposeDelegate = self
            let mailAddress = user.getUserEmailID()
            let subject = "How are you?"
            mailComposer.setSubject(subject)
            mailComposer.setToRecipients([mailAddress])
            self.present(mailComposer, animated: true, completion: nil)
            return
        }
        
        self.showAlert(withMessage: "Please Configure Your Email Account !!!")
        
    }
}

// MARK: ---------- EXTENSION : SPProfileViewController(UITableViewDataSource) ----------
extension SPProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: SPProfileCell.className, for: indexPath) as? SPProfileCell {
            cell.setInformation(information: self.information)
            cell.emailHandler = { [weak  self] (isShow) in
                if isShow == true {
                    self?.sendEmail()
                }
            }
            return cell
        } else {
            return UITableViewCell()
        }

    }

}

// MARK: ---------- EXTENSION : SPProfileViewController(UITableViewDelegate) ----------
extension SPProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

// MARK: ---------- EXTENSION : SPProfileViewController(MFMailComposeViewControllerDelegate) ----------
extension SPProfileViewController: MFMailComposeViewControllerDelegate {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true) { [weak self] in
            self?.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
}
