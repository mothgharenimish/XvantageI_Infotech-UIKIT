//
//  UserTableVC.swift
//  XvantageI_Infotech-UIKIT
//
//  Created by Nimish Mothghare on 21/05/25.
//

import UIKit

class UserTableVC: UITableViewCell {
    
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phonenoLbl: UILabel!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.profileImg.layer.cornerRadius = self.profileImg.frame.size.height / 2

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
