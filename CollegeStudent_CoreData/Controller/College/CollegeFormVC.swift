//
//  CollegeFormVC.swift
//  CollegeStudent_CoreData
//
//  Created by Anurag Kashyap on 29/08/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit

class CollegeFormVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var cityTF: UITextField!
    @IBOutlet weak var universityTF: UITextField!
    
    //MARK: View life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: Button Action
    @IBAction func saveButtonAction(_ sender: UIButton) {
        saveCollegeData()
    }
}

extension CollegeFormVC {
    
    func saveCollegeData(){
        guard let collegeName = nameTF.text, let collegeAddress = addressTF.text, let collegeCity = cityTF.text, let collegeUniversity = universityTF.text else {print("Please fill all the details"); return }
        let collegeDict = ["name":collegeName,"address":collegeAddress,"city":collegeCity,"university":collegeUniversity]
        if DatabaseHelper.sharedInstance.createCollege(objectOf: collegeDict){
            print("College Created")
            self.navigationController?.popViewController(animated: true)
        }
    }
}
