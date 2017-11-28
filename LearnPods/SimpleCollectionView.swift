//
//  SimpleCollectionView.swift
//  LearnPods
//
//  Created by Deepesh Mehta on 2017-11-23.
//  Copyright © 2017 Yao Lu. All rights reserved.
//

import UIKit

class SimpleCollectionView: UIView {
    var baseCollectionView: UICollectionView!
    var userDetails: UserDetailsMap!
    var dataTitles = ["main","statistics","description","basic","match","attitude","gift","image"]
    var simpleStruct = ["main","statistics"]
    var doubleStruct = ["description","basic","match"]
    var imageStruct = ["image","gift"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func load(userDetails: UserDetailsMap){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: self.frame.size.width - 20, height: 40)
        layout.headerReferenceSize = CGSize(width: self.frame.size.width, height: 30)
        self.userDetails = userDetails
//        dump(userDetails)
        
        self.baseCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        self.baseCollectionView.delegate = self
        self.baseCollectionView.dataSource = self
        self.baseCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.baseCollectionView.register(SimpleCollectionViewCell.self, forCellWithReuseIdentifier: "SimpleCollectionViewCell")
        self.baseCollectionView.register(ImageViewCollectionViewCell.self, forCellWithReuseIdentifier: "ImageViewCollectionViewCell")
        self.baseCollectionView.register(HeaderCollectionViewCell.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
//        self.baseCollectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: "Header")
        self.baseCollectionView.backgroundColor = UIColor.clear
        
        let scrollView = UIScrollView(frame: self.frame)
        scrollView.contentSize = CGSize(width: self.frame.size.width, height: self.frame.size.height * 4)
        scrollView.addSubview(self.baseCollectionView)
        self.addSubview(scrollView)
    }
}

extension SimpleCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataTitles.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userDetails[dataTitles[section]].count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimpleCollectionViewCell", for: indexPath) as! SimpleCollectionViewCell
//        let cell = SimpleCollectionViewCell(frame: frame)
        if(indexPath.section % 2 == 0){
            cell.backgroundColor = #colorLiteral(red: 0.506552279, green: 0.5065647364, blue: 0.5065580606, alpha: 1)
        }else{
            cell.backgroundColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        }
        let data = userDetails[dataTitles[indexPath.section]]
        
        if(simpleStruct.contains(dataTitles[indexPath.section])){
            let keys = data.allKeys
            guard
                let keyElement = keys?[indexPath.row] as? String
                else{
                    return cell
            }
            cell.key.text =  keyElement + " : "
            
            guard
                let valueElement = data[keyElement] as? String
                else{
                    guard
                        let valueElement = data[keyElement] as? Int
                        else{
                            cell.attribute.text = String(describing: data[keyElement])
                            return cell
                    }
                    cell.attribute.text = String(valueElement)
                    return cell
            }
            
            cell.attribute.text = valueElement
            return cell
        }else if (doubleStruct.contains(dataTitles[indexPath.section])){
            guard
            let data2 = data as? [[String:String]]
            else{
//                print(dataTitles[indexPath.section])
//                print(indexPath.row)
                return cell
            }
            
            let array = (data2).map(){$0}
//            dump(array)
            
            for (key,value) in array[indexPath.row]{
                switch(key){
                case "title": cell.key.text = value + " : "
                case "content": cell.attribute.text = value
                default: break
                }
            }
            
//            cell.key.text = keys[indexPath.row]
//            cell.attribute.text = values[indexPath.row]
            return cell
        }else if dataTitles[indexPath.section] == "attitude"{
            guard
                let data2 = data as? [[String:Int32]]
                else{
//                    print(dataTitles[indexPath.section])
//                    print(indexPath.row)
                    return cell
            }
            
            let array = (data2).map(){$0}
            //            dump(array)
            
            for (key,value) in array[indexPath.row]{
                switch(key){
                case "title": cell.key.text = String(value) + " : "
                case "content": cell.attribute.text = String(value)
                default: break
                }
            }
            return cell
        }
        else if imageStruct.contains(dataTitles[indexPath.section]){
//            print("gift")
            guard
                let data2 = data as? [[String:String]]
                else{
                    print(dataTitles[indexPath.section])
                    print(indexPath.row)
                    return cell
            }
            let array = (data2).map(){$0}
            //            dump(array)
            
            let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageViewCollectionViewCell", for: indexPath) as? ImageViewCollectionViewCell
            var url:URL!
            for (key,value) in array[indexPath.row]{
                switch(key){
                case "imageUrl":
                    var mainImageUrl:String!
                    if(dataTitles[indexPath.row] == "gift"){
                         mainImageUrl = "http://eadate.com/images/gift/" + value
                        
                    }else{
                         mainImageUrl = "http://eadate.com/images/user/" + value
                    }
                    print(mainImageUrl)
                    url = URL(string: mainImageUrl)
                default: break
                }
            }
            
            
            
            imageCell?.mainImageView.kf.setImage(with: url, completionHandler: nil)
            
            return imageCell!
        }else{
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1
        switch kind {
        //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! HeaderCollectionViewCell
            
            headerView.backgroundColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            headerView.title.text = dataTitles[indexPath.section]
            
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("entered custom size")
        if imageStruct.contains(dataTitles[indexPath.section]){
            return CGSize(width: 50, height: 50)
            
        }else{
            return CGSize(width: self.frame.size.width - 20, height: 40)
        }
    }
    
    
}
