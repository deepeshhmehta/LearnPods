//
//  ViewController.swift
//  LearnPods
//
//  Created by Yao Lu on 2017-05-29.
//  Copyright © 2017 Yao Lu. All rights reserved.
//

import UIKit
import EasyPeasy
import CoreData

class ViewController: UIViewController {

    @objc var managedContext:NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tableView = SimpleTableView(frame: self.view.frame)
        tableView.setData(managedContext: managedContext, storyboard: storyboard!, navigationController: navigationController!)
        
        tableView.load()
        self.view .addSubview(tableView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}


