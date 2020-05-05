//
//  ViewController.swift
//  SumAndSubstanceDemo
//
//  Created by Andrey Krasivichev on 05.05.2020.
//  Copyright © 2020 Andrey Krasivichev. All rights reserved.
//

import UIKit
import SnapKit

class BasicViewController: UIViewController, ServicesProviderUsage {

    unowned var servicesProvider: ServicesProvider
    
    init(servicesProvider: ServicesProvider) {
        self.servicesProvider = servicesProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }

    func setupConstraints() {
        
    }
}

