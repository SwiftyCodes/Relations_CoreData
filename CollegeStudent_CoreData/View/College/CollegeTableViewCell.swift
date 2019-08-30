//
//  CollegeTableViewCell.swift
//  CollegeStudent_CoreData
//
//  Created by Anurag Kashyap on 29/08/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

protocol CollegeTableViewCellDelegate: AnyObject {
    func studentButtonTapped(cell: CollegeTableViewCell)
}

class CollegeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var universityLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    weak var delegate: CollegeTableViewCellDelegate?
    
    var collegeValue : College? {
        didSet{
            configureCell()
        }
    }
    
    func configureCell() {
        nameLabel.text = collegeValue?.name
        addressLabel.text = collegeValue?.address
        cityLabel.text = collegeValue?.city
        universityLabel.text = collegeValue?.university
        if let studentsCount =  collegeValue?.students?.allObjects.count{
            countLabel.text = "\(studentsCount)" 
        }
        
    }
    
    @IBAction func studentListAction(_ sender: UIButton) {
        delegate?.studentButtonTapped(cell: self)
    }
    
}
