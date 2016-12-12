//
//  FirstViewController.swift
//  MyVoice
//
//  Created by Tobiasz Dobrowolski on 06.11.2016.
//  Copyright © 2016 Infinite. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var noweSzybkieZdanie: UIView! // PopUp
    @IBOutlet weak var popTextField: UITextField! // PopUp
    
    @IBOutlet weak var speakTableView: UITableView!
    @IBOutlet weak var myTextView: UITextView!
    @IBOutlet weak var sayButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    let synth = AVSpeechSynthesizer() //przechowywanie odniesienia
    var myTxtToSpeech = AVSpeechUtterance(string: "") //przechowywanie tekstu do odczytu
    
    var zdania = ["Poproszę 3 kilo cebuli.", "Reszty nie trzeba.", "Kiedy będzie obiad?.", "Ta aplikacja jest super.", "Co to za ulica?", "Gdzie znajdę dobrą restaurację?"]
    
    var isPop = false
    
    var effectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let orange = UIColor(red: 255.0/255.0, green: 123.0/255.0, blue: 105.0/255.0, alpha: 1.0)
        let red = UIColor(red: 229.0/255.0, green: 57.0/255.0, blue: 53.0/255.0, alpha: 1.0)
        
        noweSzybkieZdanie.layer.cornerRadius = 5
        
        

        self.speakTableView.delegate = self
        self.speakTableView.dataSource = self
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        speakTableView.separatorStyle = .none
        
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
    
    func animateIn() { // PopUp
        
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.width, height: self.view.bounds.height))
        
        let effect = UIBlurEffect(style: UIBlurEffectStyle.light)
        
        effectView = UIVisualEffectView(effect: effect)
        effectView.frame = rect
        
        self.view.addSubview(effectView)
        
        self.view.addSubview(noweSzybkieZdanie)
        noweSzybkieZdanie.center = self.view.center
        
        noweSzybkieZdanie.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
        noweSzybkieZdanie.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            self.noweSzybkieZdanie.alpha = 1
            self.noweSzybkieZdanie.transform = CGAffineTransform.identity
        }
        
        isPop = true
    }
    
    func animateOut() { // PopUp
        UIView.animate(withDuration: 0.2, animations: {
            self.noweSzybkieZdanie.transform = CGAffineTransform.init(scaleX: 1.1, y: 1.1)
            self.noweSzybkieZdanie.alpha = 0
            
        }) { (success:Bool) in
            self.effectView.removeFromSuperview()
            self.noweSzybkieZdanie.removeFromSuperview()
        }
        
        isPop = false
    }
    
    @IBAction func addItem(_ sender: Any) { // PopUp
        if isPop == false
        {
            animateIn()
        }
    }

    @IBAction func dodajZdanie(_ sender: Any) {
        zdania.append(popTextField.text!)
        speakTableView.reloadData()
        popTextField.text = ""
        animateOut()
    }
    
    @IBAction func dismissPopUp(_ sender: Any) { // PopUp
        animateOut()
    }
    
    class ViewController: UIViewController, UINavigationControllerDelegate {
        func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
            return UIInterfaceOrientationMask.portrait
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var DestViewController : FirstViewControllerShow = segue.destination as! FirstViewControllerShow
        
        DestViewController.labelText = myTextView.text
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return zdania.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SpeakCell", for: indexPath) as! FirstViewControllerTableViewCell
        
        cell.myLabel.text = zdania[indexPath.row]
        
        cell.myBackground.layer.cornerRadius = 5
        cell.myBackground.clipsToBounds = true
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 54.0;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        myTxtToSpeech = AVSpeechUtterance(string: zdania[indexPath.row]);
        myTxtToSpeech.rate = 0.5;
        synth.speak(myTxtToSpeech);

        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "     ") { (action, indexPath) in
            self.zdania.remove(at: indexPath.row)
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

