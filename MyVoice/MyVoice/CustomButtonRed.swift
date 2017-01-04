//
//  CustomButtonRed.swift
//  MyVoice
//
//  Created by Tobiasz Dobrowolski on 03.01.2017.
//  Copyright © 2017 Infinite. All rights reserved.
//

import UIKit

class CustomButtonRed: UIButton {

    var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        func hexStringToUIColor (hex:String) -> UIColor {
            var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
            
            if (cString.hasPrefix("#")) {
                cString.remove(at: cString.startIndex)
            }
            
            if ((cString.characters.count) != 6) {
                return UIColor.gray
            }
            
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            
            return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        }
        
        let red = hexStringToUIColor(hex: "#E62622")
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath
            shadowLayer.fillColor = red.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 0, height: 1)
            shadowLayer.shadowOpacity = 0.4
            shadowLayer.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
}
