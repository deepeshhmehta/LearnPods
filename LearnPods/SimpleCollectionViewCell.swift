//
//  SimpleCollectionViewCell.swift
//  LearnPods
//
//  Created by Deepesh Mehta on 2017-11-23.
//  Copyright © 2017 Yao Lu. All rights reserved.
//

import UIKit
import EasyPeasy

class SimpleCollectionViewCell: UICollectionViewCell {
        
    static let cellHeight:CGFloat = 40
    static let cellWidth:CGFloat = 200
    
    let key = UILabel()
    let attribute = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(key)
        key.text = "AAAAAAAA"
        key.font = UIFont.systemFont(ofSize: 15)
        key.textColor = UIColor.black
        key <- [
            Top(10),
            Left(10)
        ]
        
        contentView.addSubview(attribute)
        attribute.text = "BBBBBBBB"
        attribute.font = UIFont.systemFont(ofSize: 15)
        attribute.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        attribute <- [
            Top().to(key, .top),
            Left().to(key, .right)
        ]
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
