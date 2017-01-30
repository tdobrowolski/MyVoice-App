//
//  FirstViewController.swift
//  MyVoice
//
//  Created by Tobiasz Dobrowolski on 06.11.2016.
//  Copyright © 2016 Infinite. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift
import Realm

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var speakTableView: UITableView!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var sayButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    let synth = AVSpeechSynthesizer() //przechowywanie odniesienia
    var myTxtToSpeech = AVSpeechUtterance(string: "") //przechowywanie tekstu do odczytu
    
    let QuickTexts = try! Realm().objects(QuickText.self).sorted(byKeyPath: "text")

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default) // przezroczysty navbar
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        
        self.speakTableView.delegate = self
        self.speakTableView.dataSource = self
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        speakTableView.separatorStyle = .none
        
        myTextView.layer.cornerRadius = 5.0;
        
        myTextView.layer.masksToBounds = false
        myTextView.layer.shadowRadius = 5.0
        myTextView.layer.shadowColor = UIColor.darkGray.cgColor
        myTextView.layer.shadowOffset = CGSize(width: 0, height: 2)
        myTextView.layer.shadowOpacity = 0.2
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
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
        
    @IBAction func addItem(_ sender: Any) {
        
        if myTextView.text != ""
        {
            let realm = try! Realm()
            
            //let QuickTexts = realm.objects(QuickText.self)
            
            let myQuickText = QuickText(value: [myTextView.text])
            // You only need to do this once (per thread)
            
            // Add to the Realm inside a transaction
            try! realm.write {
                realm.add(myQuickText)
            }
            
            speakTableView.reloadData()
        }
        
    }
    
    /*class ViewController: UIViewController, UINavigationControllerDelegate {
        func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
            return UIInterfaceOrientationMask.portrait
        }
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController : FirstViewControllerShow = segue.destination as! FirstViewControllerShow
        
        DestViewController.labelText = myTextView.text
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuickTexts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpeakCell", for: indexPath) as! FirstViewControllerTableViewCell
        
        let QuickTextsTable = QuickTexts[indexPath.row]
        
        cell.myLabel.text = QuickTextsTable.text
        
        cell.myBackground.layer.cornerRadius = 20
        cell.myBackground.clipsToBounds = true
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 54.0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let QuickTextsTable = QuickTexts[indexPath.row]
        
        myTxtToSpeech = AVSpeechUtterance(string: QuickTextsTable.text);
        myTxtToSpeech.rate = 0.5;
        synth.speak(myTxtToSpeech);
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "     ") { (action, indexPath) in
            
            let objectToDelete = self.QuickTexts[indexPath.row] as QuickText
            
            let realm = try! Realm()
            
            try! realm.write {
                realm.delete(objectToDelete)
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        if let image = UIImage(named: "x.png"){
            
            delete.backgroundColor = UIColor(patternImage: image)
            
        }
        
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // the cells you would like the actions to appear needs to be editable
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // you need to implement this method too or you can't swipe to display the actions
    }
    
    //
    
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
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

