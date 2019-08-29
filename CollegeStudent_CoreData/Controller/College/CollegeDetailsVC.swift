//
//  CollegeDetailsVC.swift
//  CollegeStudent_CoreData
//
//  Created by Anurag Kashyap on 29/08/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

protocol CollegeDetailsVCDelegate {
    func collegeDataPassBack(collegeData: College, row: Int)
}

class CollegeDetailsVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var universityTF: UITextField!
    
    var collegeValue : College?
    var delegate : CollegeDetailsVCDelegate?
    var row : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let collegeVal = collegeValue {
            nameTF.text = collegeVal.name
            addressTF.text = collegeVal.address
            cityTF.text = collegeVal.city
            universityTF.text = collegeVal.university
        }
    }
    
    @IBAction func UpdateButtonAction(_ sender: UIButton) {
        collegeValue?.name = nameTF.text
        collegeValue?.address = addressTF.text
        collegeValue?.city = cityTF.text
        collegeValue?.university = universityTF.text
        if let collegeVal = collegeValue, let rowValue = row{
            delegate?.collegeDataPassBack(collegeData: collegeVal, row: rowValue)
            DatabaseHelper.sharedInstance.updateCollege(objectOf: collegeVal, atIndex: rowValue)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
