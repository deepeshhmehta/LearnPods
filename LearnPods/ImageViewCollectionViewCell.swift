//
//  ImageViewCollectionViewCell.swift
//  LearnPods
//
//  Created by Deepesh Mehta on 2017-11-27.
//  Copyright © 2017 Yao Lu. All rights reserved.
//

import UIKit
import EasyPeasy

class ImageViewCollectionViewCell: UICollectionViewCell {
    let mainImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainImageView)
        mainImageView.layer.borderWidth = 0
        mainImageView <- [
            Height(80),
            Width(80),
            CenterY(),
            CenterX()
        ]
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
