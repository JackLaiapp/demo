//
//  ViewController.swift
//  demo2
//
//  Created by MyMac on 2017/3/2.
//  Copyright © 2017年 MyMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func showAboutTime(_ sender: Any) {
        let controller =
        self.storyboard?.instantiateViewController(withIdentifier:
                "MovieController")
        let navController = UINavigationController(rootViewController: controller!)
 //       self.navigationController?.pushViewController(controller!,
 //                                                     animated: true)
        self.present(navController, animated: true, completion:
            nil)
//        let storyboard = UIStoryboard(name: "AnotherStoryboard", bundle: nil
//        let controller = storyboard.instantiateInitialViewController(
//            self.present(controller!, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

