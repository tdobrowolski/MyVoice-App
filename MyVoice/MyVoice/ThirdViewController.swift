//
//  ThirdViewController.swift
//  MyVoice
//
//  Created by Tobiasz Dobrowolski on 07.11.2016.
//  Copyright © 2016 Infinite. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet weak var firstCallButton: UIButton!
    @IBOutlet weak var firstSmsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let orange = UIColor(red: 255.0/255.0, green: 123.0/255.0, blue: 105.0/255.0, alpha: 1.0);
        
        firstCallButton.backgroundColor = orange; //formatowanie przycisku "Zadzwon"
        firstCallButton.layer.cornerRadius = 5.0;
        
        firstSmsButton.backgroundColor = orange; //formatowanie przycisku "Wyslij alarmowego SMS'a"
        firstSmsButton.layer.cornerRadius = 5.0;

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
