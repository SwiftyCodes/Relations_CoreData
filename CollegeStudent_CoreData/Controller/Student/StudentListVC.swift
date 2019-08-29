//
//  StudentListVC.swift
//  CollegeStudent_CoreData
//
//  Created by Anurag Kashyap on 29/08/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit
import CoreData

class StudentListVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var studentListArray : [NSManagedObject] = []
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = "Student's List"
        studentListArray = DatabaseHelper.sharedInstance.fetchDataFromEntity(fromEntity: "Student")
        tableView.reloadData()
    }
    
    @IBAction func addStudentBarButtonAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "StudentFormVC", sender: nil)
    }
    
}

extension StudentListVC : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentListArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for: indexPath) as! StudentTableViewCell
        cell.studentValue = (studentListArray[indexPath.row] as! Student)
        return cell
    }
}


extension StudentListVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            studentListArray = DatabaseHelper.sharedInstance.delete(atIndex: indexPath.row, fromEntity: "Student")
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let popOverVC = UIStoryboard(name: "Student", bundle: nil).instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        popOverVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        popOverVC.studentValue = studentListArray[indexPath.row] as? Student
        popOverVC.row = indexPath.row
        popOverVC.delegate = self
        self.present(popOverVC, animated: true)
    }
}

extension StudentListVC : PopUpViewControllerDelegate {
    func studentDataPassBack(studentData: Student, row: Int) {
        studentListArray.remove(at: row)
        studentListArray.insert(studentData, at: row)
        tableView.reloadData()
    }
}
