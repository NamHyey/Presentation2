//
//  MyCactusViewController.swift
//  Today's cactus
//
//  Created by SWUCOMPUTER on 2018. 5. 24..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class MyCactusViewController: UIViewController, UITextFieldDelegate {

  
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func buttonLogout(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title:"로그아웃 하시겠습니까?",message: "",preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in let urlString: String = "http://localhost:8888/catusLogin/logout.php"
            guard let requestURL = URL(string: urlString) else { return }
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (responseData, response, responseError) in
                guard responseError == nil else { return } }
            task.resume()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginView = storyboard.instantiateViewController(withIdentifier: "LoginView")
            self.present(loginView, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    @IBAction func buttonList(_ sender: UIButton) {
        self.performSegue(withIdentifier: "toList", sender: self)
    }
    

    

}
