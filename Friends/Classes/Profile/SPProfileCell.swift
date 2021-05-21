//
//  SPProfileCell.swift
//  Friends
//
//  Created by Md. Mamun-Ur-Rashid on 5/21/21.
//

import UIKit

class SPProfileCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblContact: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var artworkContainer: UIImageView!
    
    var information : SPUserModel?
    var emailHandler: ((Bool) -> Void)?
    var tapGesture : UITapGestureRecognizer!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handlePress(_:)))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.artworkContainer.image = nil
        self.lblEmail.removeGestureRecognizer(self.tapGesture)
    }

    func setInformation(information: SPUserModel?) {
        self.artworkContainer.image = nil
        self.artworkContainer.layer.cornerRadius = self.artworkContainer.frame.size.width/2.0
        self.information = information
        if let selectedInformation = self.information {
            self.lblName.text = selectedInformation.getUserName()
            self.lblAddress.text = selectedInformation.getAddress()
            self.lblContact.text = selectedInformation.getPhoneNumber()
            self.lblEmail.text = selectedInformation.getUserEmailID()
            SPFileManager.shared.getImage(withURL: selectedInformation.getUserArtwork()) { [weak self] (image) in
                self?.artworkContainer.image = image
            }
            self.lblEmail.addGestureRecognizer(self.tapGesture)
        }

    }
    
    /// Tap management
    /// - Parameter sender: Tap gesture
    @objc func handlePress(_ sender: UITapGestureRecognizer) {
        self.emailHandler?(true)
    }

    
}
