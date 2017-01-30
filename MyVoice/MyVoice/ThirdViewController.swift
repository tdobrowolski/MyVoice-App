//
//  ThirdViewController.swift
//  MyVoice
//
//  Created by Tobiasz Dobrowolski on 07.11.2016.
//  Copyright © 2016 Infinite. All rights reserved.
//

import UIKit
import MessageUI
import ContactsUI
import Realm
import RealmSwift

class ThirdViewController: UIViewController, MFMessageComposeViewControllerDelegate, CNContactPickerDelegate {
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var firstCallButton: UIButton!
    @IBOutlet weak var firstSmsButton: UIButton!
    @IBOutlet weak var secondCallButton: UIButton!
    @IBOutlet weak var secondSmsButton: UIButton!
    @IBOutlet weak var FirstLabel: UILabel!
    @IBOutlet weak var SecondLabel: UILabel!
    
    var myContact = try! Realm().objects(Contacts.self).first
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert() {
        
        let alert = UIAlertController(title: "Uzupełnij dane kontaktowe", message: "Wygląda na to, że nie podałeś danych kontaktowych. Chcesz to zrobić teraz?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Kontynuuj", style: UIAlertActionStyle.default, handler: { action in
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "EditContacts") as! ThirdViewControllerEdit
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Anuluj", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func FirstCallAction(_ sender: Any) {
        
        let phoneNumber1 = myContact?.phoneNumberOne
        
        if phoneNumber1 != "0" {
            guard let number = URL(string: "telprompt://" + phoneNumber1!) else { return }
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        } else {
            showAlert()
        }
    }

    @IBAction func SecondCallAction(_ sender: Any) {
        
        let phoneNumber2 = myContact?.phoneNumberTwo
        
        if phoneNumber2 != "0" {
            guard let number = URL(string: "telprompt://" + phoneNumber2!) else { return }
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
        } else {
            showAlert()
        }
        
        /*let url2:NSURL = NSURL(string: "tel://" + phoneNumber2!)!
        UIApplication.shared.openURL(url2 as URL)*/
    }
    
    @IBAction func FirstSmsAction(_ sender: Any) {
        
        let phoneNumberOne = (myContact?.phoneNumberOne)! as String
        
        if phoneNumberOne != "0" {
            if MFMessageComposeViewController.canSendText() {
                
                MFMessageComposeViewController().body = "To jest wiadomość alarmowa. Mogę potrzebować pomocy."
                MFMessageComposeViewController().recipients = [phoneNumberOne]
                MFMessageComposeViewController().messageComposeDelegate = self
                
                present(MFMessageComposeViewController(), animated: true, completion: nil)
                
            }
        } else {
            showAlert()
        }
        
    }
    
    @IBAction func SecondSmsAction(_ sender: Any) {
        
        let phoneNumberTwo = (myContact?.phoneNumberTwo)! as String
        
        if phoneNumberTwo != "0" {
            if MFMessageComposeViewController.canSendText() {
                
                MFMessageComposeViewController().body = "To jest wiadomość alarmowa. Mogę potrzebować pomocy."
                MFMessageComposeViewController().recipients = [phoneNumberTwo]
                MFMessageComposeViewController().messageComposeDelegate = self
                
                present(MFMessageComposeViewController(), animated: true, completion: nil)
                
            }
        } else {
            showAlert()
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        FirstLabel.text = myContact?.NameOne
        SecondLabel.text = myContact?.NameTwo
    }

}
