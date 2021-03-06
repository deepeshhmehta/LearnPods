//
//  DetailsViewController.swift
//  LearnPods
//
//  Created by Deepesh Mehta on 2017-11-21.
//  Copyright © 2017 Yao Lu. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import Alamofire
import SVProgressHUD
import ObjectMapper
import EasyPeasy

class DetailsViewController: UIViewController {
    //MARK: - Properties
    @objc var idToSearch: String!
    var userDetails: UserDetailsMap!
    @objc var userData: [UserData]!
    @objc var userDataSections : [String] = []
    @objc var managedContext:NSManagedObjectContext!
    @objc var fetchRequest: NSFetchRequest<UserData>!
    var dataSet:Bool = false //indicator if data is set
    
    // MARK: - Objects
    
    @IBOutlet weak var displayImage: UIImageView!
    @IBOutlet weak var signatureLabel: UILabel!
    @IBOutlet weak var orientationLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var viewForCollection: UIView!
    
    override func viewDidLoad() {
        self.title = "User Details"
        let coreDataStack = CoreDataStack(modelName: "LearnPodsData")
        self.managedContext = coreDataStack.managedContext
        print(idToSearch)
        SVProgressHUD.show(withStatus: "Loading...")
        SVProgressHUD.setDefaultMaskType(.black)
        
        self.alignAndStyle()
        load()
        
       
//        self.view.addSubview(collectionView)
        
    }
    
    func alignAndStyle(){
        self.displayImage.clipsToBounds = true
        self.displayImage.layer.cornerRadius = 40
        self.displayImage.layer.borderWidth = 0
    }
    
    @objc func load(){
        if (checkCoreData()){
            getData()
        }else{
            sendRequest()
        }
        
    }
    
    @objc func checkCoreData() -> Bool{
       
        let fetchRequest = NSFetchRequest<UserData>(entityName: "UserData") as NSFetchRequest<UserData>
        guard
            let id = self.idToSearch
            else{
                print("id core data guard failed")
                return false
        }
        
        let predicate = NSPredicate(format: "userid == %@", id)
        fetchRequest.predicate = predicate
        self.fetchRequest = fetchRequest
        do{
            self.userData = try managedContext.fetch(self.fetchRequest)
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
        if self.userData.count > 0{
            return true;
        }
        else{
            print("no results found so going for api")
            return false

        }
    }
    
    @objc func sendRequest() {
        print("fetch details from api")
        guard
            let id = self.idToSearch
            else{
                print("id api guard failed")
            return
        }
        
        let url = "http://eadate.com/api/userInfo/" + id
        print(url)
        Alamofire.request(url).responseJSON { (responseData) -> Void in
            guard
                let responseJSON = responseData.result.value as? [String: Any]
                else{
                    print("responseJSON failed")
                    return
            }

            guard
                let results = responseJSON["data"] as? [String: Any]
                else {
                    print("results failed")
                    return
            }

            self.userDetails = Mapper<UserDetailsMap>().map(JSONObject: results)
        
            //Manipulate Data as Per requirements
            self.userDetails.main["gender"] = self.userDetails.main["gender"] as! Int == 0 ? "Female": "Male"
            self.userDetails.main["sexualOrientation"] = self.userDetails.main["sexualOrientation"] as! Int == 1 ? "Straight": "Gay"
            
            self.dataSet = true
//                if self.userInfoArray.count > 0 {
//                    self.addTableView()
//                }
                
            //add to core data
            for (title,_) in (responseJSON["data"] as? [String: Any])!{
                if (title == "option"){}
                else{
                    self.userDataSections.append(title)
                    let rawData = self.userDetails[title]
                    let binData = NSKeyedArchiver.archivedData(withRootObject: rawData) as NSData
                    
                    let entity = NSEntityDescription.entity(forEntityName: "UserData",in: self.managedContext)!
                    let userData = UserData(entity: entity,insertInto: self.managedContext)
                    
                    //assign values
                    userData.userid = id
                    userData.title = title
                    userData.data = binData
                    try! self.managedContext.save()
                    
                }
                
            }
            SVProgressHUD.dismiss()
            self.loadScreen()
        }
        
    }
    @objc func getData(){
        print("fetch details from coreData");
        var DataObj:[String: Any] = [:]
        for data in userData {
            guard
                let title = data.title,
                let dataArr = data.data
            else{
                    print("error assigning")
                    continue
            }
            
            let unBinData = try! NSKeyedUnarchiver.unarchiveObject(with: dataArr as Data)
//            dump(unBinData);
            
//            let unBinData = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(dataArr)!
            DataObj[title] = unBinData
            
        }
        
        self.userDetails = Mapper<UserDetailsMap>().map(JSON: DataObj)
        self.dataSet = true
        SVProgressHUD.dismiss()
        self.loadScreen()
        
    }
    
    func loadScreen(){
        self.loadDataOnScreen()
        let collectionView = SimpleCollectionView(frame: self.view.frame)
        collectionView.load(userDetails: self.userDetails)
        self.viewForCollection.addSubview(collectionView)
    }
    
    func loadDataOnScreen(){
        guard
            let main = self.userDetails.main
            else{
                print("guard main failed")
                return
        }
        for (key,value) in main{
            switch key{
            case "displayName": self.title = value as? String
            case "mainImage" :
                    let mainImage = value as? String
                    let mainImageUrl = "http://eadate.com/images/user/" + mainImage! + "_size_80.png"
                    let url = URL(string: mainImageUrl)
                    self.displayImage.kf.setImage(with: url, completionHandler: nil)
            case "signature": self.signatureLabel.text = value as? String
            case "sexualOrientation": self.orientationLabel.text = value as? String
            case "gender": self.genderLabel.text = value as? String
            case "city" :
                guard
                    let val = value as? String
                else{
                    continue
                }
                let text = "from " + val
                self.cityLabel.text = text
                
            default: continue
            }
        }
    }
}

