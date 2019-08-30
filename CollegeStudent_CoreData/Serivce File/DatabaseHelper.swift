//
//  DatabaseHelper.swift
//  CoreDataProject
//
//  Created by Anurag Kashyap on 29/08/19.
//  Copyright © 2019 Anurag Kashyap. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DatabaseHelper : NSObject {
    
    static let sharedInstance = DatabaseHelper()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    private override init(){}
    
    //MARK: Fetch - Generic
    func fetchDataFromEntity(fromEntity entity: String) -> [NSManagedObject] {
        var allData = [NSManagedObject]()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        do {
            allData = try (context?.fetch(fetchRequest))!
        }catch {
            print("Not able to fetch data from store")
        }
        return allData
    }
    
    //MARK: Create - College
    func createCollege(objectOf object: [String:Any]) -> Bool {
        let collegeObject = NSEntityDescription.insertNewObject(forEntityName: "College", into: context!) as! College
        collegeObject.name = object["name"] as? String
        collegeObject.address = object["address"] as? String
        collegeObject.city = object["city"] as? String
        collegeObject.university = object["university"] as? String
        
        do{
            try context?.save()
            print("College Data Saved Successfully")
            return true
        }catch{
            print("Error saving data at College")
            return false
        }
    }
    
    //MARK: Delete - College
    func delete(atIndex index: Int, fromEntity entity: String) -> [NSManagedObject] {
        
        var allData = fetchDataFromEntity(fromEntity: entity)
        context?.delete(allData[index]) // Remove data from Entity
        allData.remove(at: index) // Remove data from Array
        
        do{
            try context?.save()
            print("Data Deleted Successfully")
        }catch{
            print("Error Deleting data")
        }
        
        return allData
    }
    
    //MARK: Update - College
    func updateCollege(objectOf object: College, atIndex i: Int) {
        var allCollege = fetchDataFromEntity(fromEntity: "College") as! [College]
        allCollege[i] = object
        do{
            try context?.save()
            print("College Data Edited Successfully")
        }catch{
            print("Error Editing data at College")
        }
    }
    
    //MARK: Update - Student
    func createStudent(objectOf object: [String:Any], toCollege college: College) -> Bool {
        let studentObject = NSEntityDescription.insertNewObject(forEntityName: "Student", into: context!) as! Student
        studentObject.name = object["name"] as? String
        studentObject.age = Int16(object["age"] as! Int)
        studentObject.number = object["number"] as? String
        studentObject.city = object["city"] as? String
        studentObject.universities = college
        do{
            try context?.save()
            print("Data Saved Successfully")
            return true
        }catch{
            print("Error saving data")
            return false
        }
    }
    
    //MARK: Delete - Student
    func deleteStudent(atIndex index: Int, fromEntity entity: String, fromCollege thisCollege:College) -> [NSManagedObject] {
        
        var allData = thisCollege.students?.allObjects as! [NSManagedObject]
        context?.delete(allData[index]) // Remove data from Entity
        allData.remove(at: index) // Remove data from Array
        
        do{
            try context?.save()
            print("Data Deleted Successfully")
        }catch{
            print("Error Deleting data")
        }
        
        return allData
    }
    
    //MARK: Update - Student
    func updateStudent(objectOf object: Student, atIndex i: Int) {
        var allStudent = fetchDataFromEntity(fromEntity: "Student") as! [Student]
        allStudent[i] = object
        do{
            try context?.save()
            print("Data Edited Successfully")
        }catch{
            print("Error Editing data")
        }
    }
}
