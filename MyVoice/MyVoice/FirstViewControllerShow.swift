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
        //largeText.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        largeText.text = labelText
        largeText.adjustsFontSizeToFitWidth = true
        //largeText.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        //let value = UIInterfaceOrientation.landscapeLeft.rawValue
        //UIDevice.current.setValue(value, forKey: "orientation")
    }
    
}
