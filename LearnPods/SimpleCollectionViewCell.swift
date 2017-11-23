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
        
    static let cellHeight:CGFloat = 120
    
    let mainImageView = UIImageView()
    let firstLineLabel = UILabel()
    let secondLineLabel = UILabel()
    let thirdLineLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainImageView)
        mainImageView.clipsToBounds = true
        mainImageView.layer.cornerRadius = 10
        mainImageView.layer.borderWidth = 0
        mainImageView <- [
            Height(80),
            Width(80),
            CenterY(),
            Left(10)
        ]
        
        
        contentView.addSubview(firstLineLabel)
        firstLineLabel.text = "AAAAAAAA"
        firstLineLabel.font = UIFont.systemFont(ofSize: 15)
        firstLineLabel.textColor = UIColor.black
        firstLineLabel <- [
            Top().to(mainImageView, .top),
            Left(15).to(mainImageView, .right),
            Right()
        ]
        
        contentView.addSubview(secondLineLabel)
        secondLineLabel.text = "BBBBBBBB"
        secondLineLabel.font = UIFont.systemFont(ofSize: 15)
        secondLineLabel.textColor = #colorLiteral(red: 0.506552279, green: 0.5065647364, blue: 0.5065580606, alpha: 1)
        secondLineLabel <- [
            Top(10).to(firstLineLabel, .bottom),
            Left().to(firstLineLabel, .left)
        ]
        
        contentView.addSubview(thirdLineLabel)
        thirdLineLabel.text = "CCCCCCCCCCCCCCCCCCCCCCCCCCcascascascac"
        thirdLineLabel.font = UIFont.systemFont(ofSize: 15)
        thirdLineLabel.textColor = #colorLiteral(red: 0.506552279, green: 0.5065647364, blue: 0.5065580606, alpha: 1)
        thirdLineLabel.lineBreakMode = .byWordWrapping
        thirdLineLabel.numberOfLines = 2
        thirdLineLabel <- [
            Top(10).to(secondLineLabel, .bottom),
            Left().to(firstLineLabel, .left),
            Right(15)
        ]
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
