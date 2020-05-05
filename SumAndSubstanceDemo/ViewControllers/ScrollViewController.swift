//
//  ScrollViewController.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit

class ScrollViewController: BasicViewController {
    
    lazy private(set) var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.view.bounds)
        scrollView.delaysContentTouches = false
        self.contentView.addSubview(scrollView)
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupConstraints()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
}
