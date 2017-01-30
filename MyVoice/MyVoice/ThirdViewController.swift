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
    
    @IBAction func FirstCallAction(_ sender: Any) {
        
        let phoneNumber1 = myContact?.phoneNumberOne
        
        guard let number = URL(string: "telprompt://" + phoneNumber1!) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
        
        /*let url:NSURL = NSURL(string: "tel://" + phoneNumber1!)!
        UIApplication.shared.openURL(url as URL)*/
        }

    @IBAction func SecondCallAction(_ sender: Any) {
        
        let phoneNumber2 = myContact?.phoneNumberTwo
        
        guard let number = URL(string: "telprompt://" + phoneNumber2!) else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
        
        /*let url2:NSURL = NSURL(string: "tel://" + phoneNumber2!)!
        UIApplication.shared.openURL(url2 as URL)*/
    }
    
    @IBAction func FirstSmsAction(_ sender: Any) {
        
        if MFMessageComposeViewController.canSendText() {
        
            let phoneNumberOne = (myContact?.phoneNumberOne)! as String
        
            MFMessageComposeViewController().body = "To jest wiadomość alarmowa. Mogę potrzebować pomocy."
            MFMessageComposeViewController().recipients = [phoneNumberOne]
            MFMessageComposeViewController().messageComposeDelegate = self
        
            present(MFMessageComposeViewController(), animated: true, completion: nil)
            
        } else {
            
            print("Twój telefon jest zjebany i nie umie wysyłać SMS'ów")
            
        }
    }
    
    @IBAction func SecondSmsAction(_ sender: Any) {
        
        if MFMessageComposeViewController.canSendText() {
            
            let phoneNumberTwo = (myContact?.phoneNumberTwo)! as String
            
            MFMessageComposeViewController().body = "To jest wiadomość alarmowa. Mogę potrzebować pomocy."
            MFMessageComposeViewController().recipients = [phoneNumberTwo]
            MFMessageComposeViewController().messageComposeDelegate = self
            
            present(MFMessageComposeViewController(), animated: true, completion: nil)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        FirstLabel.text = myContact?.NameOne
        SecondLabel.text = myContact?.NameTwo
    }
    
    @IBAction func EditContacts(_ sender: Any) {
        
        let controller = CNContactPickerViewController()
        
        controller.delegate = self
        
        navigationController?.present(controller, animated: true, completion: nil)
        
    }
    
    

}
