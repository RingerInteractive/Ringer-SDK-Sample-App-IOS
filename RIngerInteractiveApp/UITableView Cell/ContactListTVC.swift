//
//  ContactListTVC.swift
//  RingerTest
//
//  Created by eSparkBiz on 31/12/21.
//

import UIKit

class ContactListTVC: UITableViewCell {

    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnAction(_ sender: Any) {
    }
}
