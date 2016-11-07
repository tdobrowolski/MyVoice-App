//
//  FirstViewController.swift
//  MyVoice
//
//  Created by Tobiasz Dobrowolski on 06.11.2016.
//  Copyright © 2016 Infinite. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {
    
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var sayButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    let synth = AVSpeechSynthesizer() //przechowywanie odniesienia
    var myTxtToSpeech = AVSpeechUtterance(string: "") //przechowywanie tekstu do odczytu
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let orange = UIColor(red: 255.0/255.0, green: 123.0/255.0, blue: 105.0/255.0, alpha: 1.0);
        let red = UIColor(red: 229.0/255.0, green: 57.0/255.0, blue: 53.0/255.0, alpha: 1.0);
        
        myTextView.layer.borderWidth = 1.0; //formatowanie wygladu pola tekstowego
        myTextView.layer.cornerRadius = 5.0;
        myTextView.layer.borderColor = orange.cgColor;
        
        sayButton.backgroundColor = orange; //formatowanie przycisku "Powiedz"
        sayButton.layer.cornerRadius = 5.0;
        
        showButton.backgroundColor = orange; //formatowanie przycisku "Pokaz"
        showButton.layer.cornerRadius = 5.0;
        
        deleteButton.backgroundColor = red; //formatowanie przycisku "Wyczysc pole tekstowe"
        deleteButton.layer.cornerRadius = 5.0;
        
        self.hideKeyboardWhenTappedAround()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func txtToSpeech(_ sender: UIButton) {
        myTxtToSpeech = AVSpeechUtterance(string: myTextView.text);
        myTxtToSpeech.rate = 0.5;
        synth.speak(myTxtToSpeech);
    }
    
    @IBAction func deleteText(_ sender: UIButton) {
        myTextView.text = "";
    }


}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

