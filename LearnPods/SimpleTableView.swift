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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        SVProgressHUD.show(withStatus: "Loading...")
        SVProgressHUD.setDefaultMaskType(.black)
        
        sendRequest()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func sendRequest() {
        Alamofire.request("http://eadate.com/api/userInfo")
            .responseJSON { (responseData) -> Void in
                
                
                guard let responseJSON = responseData.result.value as? [String: Any],
                    let results = responseJSON["data"] as? [[String: Any]]
                     //let userInfoArray1 = Mapper<UserInfo>().mapArray(JSONArray: results )
                    else {
                        return
                }
                
                
                self.userInfoArray = Mapper<UserInfo>().mapArray(JSONArray: results )
                
                
//                for one in results{
////                    let displayName = one["displayName"] as? String
////                    let signature = one["signature"] as? String
////                    let birthday = one["birthday"] as? String
////                    let mainImage = one["mainImage"] as? String
////      
////                    
////                    let user = UserInfo(displayName: displayName!,signature: signature!,birthday: birthday!,mainImage: mainImage! )
////                    
////                    
//                    let user2 = Mapper<UserInfo>().map(JSON: one)
//                    self.userInfoArray.append(user2!)
//                }
                
//                userInfoArray = userInfoArray1
                if self.userInfoArray.count > 0 {
                    self.addTableView()
                    SVProgressHUD.dismiss()
                }

                
//            if((responseData.result.value) != nil) {
//                
//                self.userInfoArray = Mapper<UserInfo>().mapArray(JSONArray: responseData.result.value! as! [[String : Any]] )
//                
//                if self.userInfoArray.count > 0 {
//                    self.addTableView()
//                    SVProgressHUD.dismiss()
//                }
//            }
        }

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
