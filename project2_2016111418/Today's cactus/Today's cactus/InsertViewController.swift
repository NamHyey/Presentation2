//
//  InsertViewController.swift
//  Today's cactus
//
//  Created by SWUCOMPUTER on 2018. 5. 29..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController,UITextFieldDelegate{

    @IBOutlet var importantCheck: UISlider!
    @IBOutlet var TextTitle: UITextField!
    @IBOutlet var pickerDateTime: UIDatePicker!
    @IBOutlet var alarmPickerDate: UIDatePicker!
    @IBOutlet var alarmView: UIView!
    @IBOutlet var textDescription: UITextView!
    
    var alarmOnoff: Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        alarmView.isHidden=true
        alarmOnoff=false

    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
        textDescription.becomeFirstResponder()
        return true
    }

    @IBAction func saveButton() {

        

        
        let name = TextTitle.text!
        let description = textDescription.text!
        if (name == "" || description == "") {
            let alert = UIAlertController(title: "제목/설명을 입력하세요",
                                          message: "Save Failed!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                alert.dismiss(animated: true, completion: nil) }))
            self.present(alert, animated: true)
            return }
        
        let urlString: String = "http://localhost:8888/catusLogin/insertDays.php"
        guard let requestURL = URL(string: urlString) else { return }
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let userID = appDelegate.ID else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        let myDate = dateFormatter.string(from: self.pickerDateTime.date)
        
        
        let alarmDateFormatter = DateFormatter()
        alarmDateFormatter.dateStyle = .long
        alarmDateFormatter.timeStyle = .medium
        let alarm = alarmDateFormatter.string(from: self.alarmPickerDate.date)
        
        
        var restString: String = "id=" + userID + "&title=" + name
        restString += "&memo=" + description
        restString += "&date=" + myDate
        restString += "&alarmDate=" + alarm
        request.httpBody = restString.data(using: .utf8)
        let session2 = URLSession.shared
        let task2 = session2.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else { return }
            guard let receivedData = responseData else { return }
            if let utf8Data = String(data: receivedData, encoding: .utf8) { print(utf8Data) }
        }
        task2.resume()
        _ = self.navigationController?.popViewController(animated: true)
    }
       
        
        
    
    
    @IBAction func showAlarm(_ sender: Any) {
        alarmView.isHidden=false
    }
    
    @IBAction func alarmSet(_ sender: UIButton) {
         alarmView.isHidden=true
        alarmOnoff=true
    }
    

}
