//
//  MovieViewController.swift
//  demo4
//
//  Created by MyMac on 2017/3/9.
//  Copyright © 2017年 Jack Lai. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    var name: String?
    @IBOutlet var textField: UITextField!
    @IBAction func back(_ sender: Any) {
        let notificationName = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.post(name: notificationName,
                                        object: nil, userInfo: ["name":self.textField.text!])
        self.dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = self.name
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
