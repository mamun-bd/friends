//
//  SPUserCell.swift
//  Friends
//
//  Created by Md. Mamun-Ur-Rashid on 5/21/21.
//

import UIKit

class SPUserCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var artworkContainer: UIImageView!
    
    var information : SPUserModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.artworkContainer.image = nil
    }
    
    func setInformation(information: SPUserModel?) {
        self.artworkContainer.image = nil
        self.artworkContainer.layer.cornerRadius = self.artworkContainer.frame.size.width/2.0
        self.information = information
        if let selectedInformation = self.information {
            self.lblName.text = selectedInformation.getUserName()
            self.lblCountry.text = selectedInformation.getCountry()
            SPFileManager.shared.getImage(withURL: selectedInformation.getUserArtwork()) { [weak self] (image) in
                self?.artworkContainer.image = image
            }
        }
    }

}
