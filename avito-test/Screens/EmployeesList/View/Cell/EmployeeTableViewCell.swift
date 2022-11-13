//
//  EmployeeTableViewCell.swift
//  avito-test
//
//  Created by Антон Чушъялов on 13.11.2022.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var phoneNumberLabel: UILabel?
    @IBOutlet weak var skillsLabel: UILabel?
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: EmployeeCellViewModel? {
        didSet {
            nameLabel?.text = cellViewModel!.name
            phoneNumberLabel?.text = cellViewModel!.phoneNumber
            
            var skills = ""
            let skillsCount = (cellViewModel!.skills.count)
            for i in 0..<skillsCount {
                skills = skills + cellViewModel!.skills[i]
                if i != skillsCount - 1 {
                    skills = skills + ", "
                }
            }
            skillsLabel?.text = skills
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
