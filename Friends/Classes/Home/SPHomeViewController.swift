//
//  SPHomeViewController.swift
//  Friends
//
//  Created by Md. Mamun-Ur-Rashid on 5/21/21.
//

import UIKit

class SPHomeViewController: SPViewController {
    
    @IBOutlet weak var userContainer: SPUsersContainer!
    private let viewModel = SPHomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Friends"
        self.view.backgroundColor = UIColor.init(hexString: "F9F6F4", alpha: 1.0)
        self.updateColumnInformation()
        self.userContainer.detailsHandler = { [weak self] (information) in
            let profileController = SPProfileViewController.initWithUserInformation(information: information)
            self?.navigationController?.pushViewController(profileController, animated: true)
        }
        self.viewModel.fetchUserInformation { [weak self] (users) in
            DispatchQueue.main.async {
                self?.userContainer.addUserInformation(items: users)
            }
        }
    }
    
    /// Update display information for orientation change.
    override func updateLayoutForOrientation() {
        self.updateColumnInformation()
        self.userContainer.invalidateIntrinsicContentSize()
        self.userContainer.flowLayout?.invalidateLayout()
        self.userContainer.reloadData()
    }
    
    func updateColumnInformation() {
        var numberOfColumn: CGFloat = 0
        if UIDevice.current.userInterfaceIdiom == .pad {
            numberOfColumn = 4
        } else {
            if self.isLandScape == true {
                numberOfColumn = 4
            } else {
                numberOfColumn = 2
            }
        }
        self.userContainer.numberOfColumn = numberOfColumn
    }

}
