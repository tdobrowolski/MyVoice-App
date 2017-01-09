//
//  FirstViewControllerShow.swift
//  MyVoice
//
//  Created by Tobiasz Dobrowolski on 10.12.2016.
//  Copyright © 2016 Infinite. All rights reserved.
//

import Foundation
import UIKit

class FirstViewControllerShow: UIViewController {
    
    @IBOutlet weak var largeText: UILabel!
    
    var labelText = String()
    
    override func viewDidLoad() {
        largeText.text = labelText
        largeText.textColor = UIColor(red: 0.94, green: 0.29, blue: 0.05, alpha: 1.0)
        largeText.adjustsFontSizeToFitWidth = true
        
        navigationController?.navigationBar.tintColor = UIColor(red: 0.94, green: 0.29, blue: 0.05, alpha: 1.0)
        
    }
    
}
