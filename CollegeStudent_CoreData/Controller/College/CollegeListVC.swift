//
//  ViewController.swift
//  CollegeStudent_CoreData
//
//  Created by Anurag Kashyap on 29/08/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import UIKit
import CoreData

class CollegeListVC: UIViewController {
    
    @IBOutlet weak var collegeTableView: UITableView!
    
    var collegeListArray : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCollegeData()
        collegeTableView.reloadData()
    }
    
    @IBAction func addBarButonAction(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toCollegeFormVC", sender: nil)
    }
}

extension CollegeListVC {
    func fetchCollegeData(){
        collegeListArray = DatabaseHelper.sharedInstance.fetchDataFromEntity(fromEntity: "College")
    }
}


//MARK : Tableview Datasource
extension CollegeListVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collegeListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollegeTableViewCell", for: indexPath) as! CollegeTableViewCell
        cell.collegeValue = collegeListArray[indexPath.row] as? College
        cell.delegate = self
        return cell
    }
}

//MARK : Tableview Delegate
extension CollegeListVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            collegeListArray = DatabaseHelper.sharedInstance.delete(atIndex: indexPath.row, fromEntity: "College")
            collegeTableView.deleteRows(at: [indexPath], with: .automatic)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let collegeDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollegeDetailsVC") as! CollegeDetailsVC
        collegeDetailsVC.collegeValue = collegeListArray[indexPath.row] as? College
        collegeDetailsVC.row = indexPath.row
        collegeDetailsVC.delegate = self
        self.navigationController?.pushViewController(collegeDetailsVC, animated: true)
    }
}

extension CollegeListVC : CollegeDetailsVCDelegate {
    func collegeDataPassBack(collegeData: College, row: Int) {
        collegeListArray.remove(at: row)
        collegeListArray.insert(collegeData, at: row)
        collegeTableView.reloadData()
    }
}

extension CollegeListVC : CollegeTableViewCellDelegate {
    func studentButtonTapped(cell: CollegeTableViewCell) {
        if let indexPath = self.collegeTableView.indexPath(for: cell){
            let studentListVC = UIStoryboard(name: "Student", bundle: nil).instantiateViewController(withIdentifier: "StudentListVC") as! StudentListVC
            studentListVC.college = collegeListArray[indexPath.row] as? College // Sending College object
            self.navigationController?.pushViewController(studentListVC, animated: true)
        }
    }
}
