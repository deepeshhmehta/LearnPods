//
//  SimpleTableView.swift
//  LearnPods
//
//  Created by MacStudent on 2017-05-31.
//  Copyright © 2017 Yao Lu. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON
import SVProgressHUD
import ObjectMapper
import CoreData

class SimpleTableView: UIView, UITableViewDataSource, UITableViewDelegate {
    var baseTableView : UITableView!
    //var swiftyJsonVar :JSON!
    var userInfoArray: Array<UserInfo> = []
    @objc var users: Array<USERS> = []
    @objc var managedContext:NSManagedObjectContext!
    @objc var fetchRequest: NSFetchRequest<USERS>!
    @objc var storyboard: UIStoryboard!
    @objc var navigationController: UINavigationController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SVProgressHUD.show(withStatus: "Loading...")
        SVProgressHUD.setDefaultMaskType(.black)
        
    }
    
    @objc func setData (managedContext: NSManagedObjectContext,storyboard: UIStoryboard, navigationController: UINavigationController){
        self.managedContext = managedContext
        self.storyboard = storyboard
        self.navigationController = navigationController
    }
    
    @objc func load(){
        if (checkCoreData()){
            getData()
        }else{
            sendRequest()
        }
    }
    
    
    @objc func checkCoreData() -> Bool{
        guard let model =
            self.managedContext
                .persistentStoreCoordinator?.managedObjectModel,
            let fetchRequest = model
                .fetchRequestTemplate(forName: "FetchRequestUsers")
                as? NSFetchRequest<USERS> else {
                    return false
        }
        self.fetchRequest = fetchRequest
        do{
            self.users = try managedContext.fetch(self.fetchRequest)
        }catch let error as NSError{
            print("Could not fetch \(error), \(error.userInfo)")
        }
        if self.users.count > 0{
            return true;
        }
        else{
            return false
            
        }
    }
    
    @objc func getData(){
        print("fetch list from coreData");
        for user in users {
            userInfoArray.append((UserInfo(user: user))!)
        }
        
        if self.userInfoArray.count > 0 {
            self.addTableView()
            SVProgressHUD.dismiss()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sendRequest() {
        print("fetch list from api")
        Alamofire.request("http://eadate.com/api/userInfo")
            .responseJSON { (responseData) -> Void in
                guard let responseJSON = responseData.result.value as? [String: Any],
                    let results = responseJSON["data"] as? [[String: Any]]
                    else {
                        return
                }
                
                self.userInfoArray = Mapper<UserInfo>().mapArray(JSONArray: results )
                self.addUsersToCoreData()
                if self.userInfoArray.count > 0 {
                    self.addTableView()
                    SVProgressHUD.dismiss()
                }
        }
        
    }
    
    @objc func addUsersToCoreData(){
        for userInfo in userInfoArray {
            let entity = NSEntityDescription.entity(
                forEntityName: "USERS",
                in: managedContext)!
            let user = USERS(entity: entity,
                             insertInto: managedContext)
            
            //assign values
            user.displayName = userInfo.displayName
            user.birthday = userInfo.birthday
            user.id = userInfo.id
            user.mainImage = userInfo.mainImage
            user.signature = userInfo.signature
        }
        try! managedContext.save()
    }
    
    func addTableView() {
        baseTableView = UITableView(frame: self.frame, style: .plain)
        baseTableView.delegate = self
        baseTableView.dataSource = self
        baseTableView.register(SimpleTableViewCell.self, forCellReuseIdentifier:"SimpleTableViewCell")
        self.addSubview(baseTableView)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userInfoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleTableViewCell", for: indexPath) as! SimpleTableViewCell
    
        let rowNumber = (indexPath as NSIndexPath).row
        
        let userInfo = self.userInfoArray[rowNumber]
        cell.firstLineLabel.text = userInfo.displayName
        cell.secondLineLabel.text = userInfo.signature
        cell.thirdLineLabel.text = userInfo.birthday
        
        cell.mainImageView.image = nil
        cell.mainImageView.layer.cornerRadius = 40
        let mainImage = userInfo.mainImage
        let mainImageUrl = "http://eadate.com/images/user/" + mainImage! + "_size_80.png"
        let url = URL(string: mainImageUrl)
        cell.mainImageView.kf.setImage(with: url, completionHandler: nil)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}


//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        if offsetY > contentHeight - scrollView.frame.size.height {
//            loadMore()
//        }
//    }
