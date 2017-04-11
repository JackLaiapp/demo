//
//  ViewController.swift
//  demo4
//
//  Created by MyMac on 2017/3/9.
//  Copyright © 2017年 Jack Lai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var button: UIButton!
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        let button = sender as! UIButton
        let controller = segue.destination as!
        MovieViewController
        controller.name = button.currentTitle
    }
    
    func getUpdateNoti(noti:Notification) {
        let name = noti.userInfo!["name"] as! String
        self.button.setTitle(name, for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let notificationName = Notification.Name("GetUpdateNoti")
        NotificationCenter.default.addObserver(self, selector:
            #selector(ViewController.getUpdateNoti(noti:)), name: notificationName,
                                                            object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

