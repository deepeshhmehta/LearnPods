//
//  HeaderCollectionViewCell.swift
//  LearnPods
//
//  Created by Deepesh Mehta on 2017-11-27.
//  Copyright © 2017 Yao Lu. All rights reserved.
//

import UIKit
import EasyPeasy

class HeaderCollectionViewCell: UICollectionReusableView {
    static let cellHeight:CGFloat = 40
    static let cellWidth:CGFloat = 200
    
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(title)
        title.textAlignment = NSTextAlignment.center
        title.frame = CGRect(x: 20, y: 0, width: 70, height: 30)
        title.font = UIFont(name: "Arial", size: 15)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
