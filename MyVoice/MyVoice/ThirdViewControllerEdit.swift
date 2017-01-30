//
//  ThirdViewControllerEdit.swift
//  MyVoice
//
//  Created by Tobiasz Dobrowolski on 28.01.2017.
//  Copyright © 2017 Infinite. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class ThirdViewControllerEdit: UIViewController {
    
    @IBOutlet weak var FirstEditName: UITextField!
    @IBOutlet weak var FirstEditNumber: CustomTextField!
    @IBOutlet weak var SecondEditName: CustomTextField!
    @IBOutlet weak var SecondEditNumber: CustomTextField!
    @IBOutlet weak var SaveButton: UIButton!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        
        FirstEditName.placeholder = "Imię i Nazwisko"
        FirstEditNumber.placeholder = "Numer telefonu"
        
        SecondEditName.placeholder = "Imię i Nazwisko"
        SecondEditNumber.placeholder = "Numer telefonu"
        
        let orange = hexStringToUIColor(hex: "#EF5B24")
        
        SaveButton.layer.borderWidth = 2
        SaveButton.layer.borderColor = orange.cgColor
        SaveButton.layer.cornerRadius = 26
        
    }
    
    func showAlertOk() {
        let alert = UIAlertController(title: "Niepoprawne dane", message: "Wprowadź prawidłowe dane", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func SaveContacts(_ sender: Any) {
        
        if FirstEditName.text == "" || SecondEditName.text == "" || FirstEditNumber.text == "" || SecondEditNumber.text == "" {
            showAlertOk()
        } else {
            let realm = try! Realm()
            
            let myContact = Contacts()
            
            myContact.id = 1
            
            myContact.NameOne = FirstEditName.text!
            myContact.phoneNumberOne = FirstEditNumber.text!
            
            myContact.NameTwo = SecondEditName.text!
            myContact.phoneNumberTwo = SecondEditNumber.text!
            // You only need to do this once (per thread)
            
            // Add to the Realm inside a transaction
            try! realm.write {
                realm.add(myContact, update: true)
            }
            
            _ = navigationController?.popToRootViewController(animated: true)
        }
        
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

