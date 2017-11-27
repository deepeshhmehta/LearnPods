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
    var dataTitles = ["main","statistics","description","basic","match","attitude"]
    var simpleStruct = ["main","statistics"]
    var doubleStruct = ["description","basic","match","attitude"]
    
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
        self.baseCollectionView.register(SimpleCollectionViewCell.self, forCellWithReuseIdentifier: "SimpleCollectionViewCell")
        self.baseCollectionView.register(HeaderCollectionViewCell.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
//        self.baseCollectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: "Header")
        self.baseCollectionView.backgroundColor = UIColor.clear
        self.addSubview(self.baseCollectionView)
    }
}

extension SimpleCollectionView: UICollectionViewDataSource, UICollectionViewDelegate{
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
                print(dataTitles[indexPath.section])
                print(indexPath.row)
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
    
    
}
