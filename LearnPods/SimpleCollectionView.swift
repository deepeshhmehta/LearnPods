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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func load(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 120)
        
        self.baseCollectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        self.baseCollectionView.delegate = self
        self.baseCollectionView.dataSource = self
        self.baseCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.addSubview(self.baseCollectionView)
    }
}
extension SimpleCollectionView: UICollectionViewDelegate{
    
}

extension SimpleCollectionView: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor.orange
        return cell
    }
    
    
}
