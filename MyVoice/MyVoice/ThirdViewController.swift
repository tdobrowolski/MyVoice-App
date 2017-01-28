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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myContact = try! Realm().objects(Contacts.self).first
        FirstLabel.text = myContact?.NameOne
        SecondLabel.text = myContact?.NameTwo

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func FirstCallAction(_ sender: Any) {
        let url:NSURL = NSURL(string: "tel://123456789")!
        UIApplication.shared.openURL(url as URL)
    }

    @IBAction func SecondCallAction(_ sender: Any) {
        let url2:NSURL = NSURL(string: "tel://123456789")!
        UIApplication.shared.openURL(url2 as URL)
    }
    
    @IBAction func FirstSmsAction(_ sender: Any) {
        let firstMessage = MFMessageComposeViewController()
        firstMessage.body = "To jest wiadomość alarmowa. Mogę potrzebować pomocy."
        firstMessage.recipients = ["694595123"]
        firstMessage.messageComposeDelegate = self
        
        present(firstMessage, animated: true, completion: nil)
    }
    
    @IBAction func SecondSmsAction(_ sender: Any) {
        let secondMessage = MFMessageComposeViewController()
        secondMessage.body = "To jest wiadomość alarmowa. Mogę potrzebować pomocy."
        secondMessage.recipients = ["694595123"]
        secondMessage.messageComposeDelegate = self
        
        present(secondMessage, animated: true, completion: nil)
    }
    
    func reloadData() {
        
        self.view.setNeedsDisplay()
        
    }
    
    @IBAction func EditContacts(_ sender: Any) {
        
        let controller = CNContactPickerViewController()
        
        controller.delegate = self
        
        navigationController?.present(controller, animated: true, completion: nil)
        
    }
    
    

}
