//
//  ViewController.swift
//  WSHelper
//
//  Created by Sogo Computers on 4/5/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import UIKit
import CoreData
//import Firebase

class ViewController: UIViewController {

    var imageView1: UIImageView!
    private let dataModel = DataModels()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getDataUpdate), name: NSNotification.Name(rawValue: "dataModelDidUpdateNotification"), object: nil)

        // To use this callback in ViewController class, we simply assign an appropriate method to it (again using weak self):
        

        dataModel.requestData(completion: {(data: String) in
            self.useData(data: data)
        })

        // For Protocols
        dataModel.delegate=self
        dataModel.requestPostData()
       
        
        //requestMultiForm()
        WSHelpers.requestGetMethod()
        
        // Do any additional setup after loading the view, typically from a nib.
        /*Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(title!)",
            AnalyticsParameterItemName: title!,
            AnalyticsParameterContentType: "cont"
            ])*/
        
    }

    //MARK: -- Notification Using
    @objc func getDataUpdate(){
        
        if let dataModel = SingletonDataModels.sharedInstance.data{
            print("getDataUpdate \(dataModel)")
            
        }
    }
    
  
    private func useData(data: String){
        print("useData \(data)")
    }
    // MARK:  --- Core DATA
    func insertDataInUsers(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "UsersDetails", in: managedContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue("John", forKeyPath: "name")
        user.setValue("john@test.com", forKey: "emailId")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: "1990/10/08")
        user.setValue(date, forKey: "dateOfBirth")
        user.setValue(0, forKey: "numberOfChildren")

        
        let carEntity = NSEntityDescription.entity(forEntityName: "Cars", in: managedContext)!
        let car1 = NSManagedObject(entity: carEntity, insertInto: managedContext)
        car1.setValue("Audi TT", forKey: "model")
        car1.setValue(2010, forKey: "year")
        car1.setValue(user, forKey: "usersdetails")
        
        let car2 = NSManagedObject(entity: carEntity, insertInto: managedContext)
        car2.setValue("BMW X6", forKey: "model")
        car2.setValue(2014, forKey: "year")
        car2.setValue(user, forKey: "usersdetails")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print("Insert completed")
        readDataFromUsers()
    }
    
    func readDataFromUsers(){
        
        print("Reads Start")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UsersDetails")
        userFetch.fetchLimit = 1
        userFetch.predicate = NSPredicate(format: "name = %@", "John")
        userFetch.sortDescriptors = [NSSortDescriptor.init(key: "emailId", ascending: true)]
        let users = try! managedContext.fetch(userFetch)
        let john: UsersDetails = users.first as! UsersDetails
        print("Email: \(String(describing: john.emailId))")
        let johnCars = john.cars?.usersdetails?.allObjects as! [Cars]
        print("has \(johnCars.count)")
        
        
    }
    
    // MARK:  --- Core DATA
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: METHOD ------ POST NSURLSession: dataTaskWithUrl example
    // Let's start this example  with the dataTaskWithUrl function.
}

extension UIViewController: DataModelsDelegate{
    
    func didRecieveDataUpdate(data: String) {
        print("didRecieveDataUpdate \(data)")
    }
}
