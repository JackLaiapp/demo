//
//  LoversTableViewController.swift
//  TableView
//
//  Created by MyMac on 2017/3/9.
//  Copyright © 2017年 Jack Lai. All rights reserved.
//

import UIKit

class LoversTableViewController: UITableViewController {

    var lovers = [[String:String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lovers = [["name":"angelababy", "star":"牡羊座"], ["name":"penny", "star":"雙魚座"], ["name":"vivian", "star":"巨蟹座"], ["name":"vivian", "star":"巨蟹座"]]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return  lovers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell:UITableViewCell
        //if indexPath.row % 2 == 0 {
        //    cell = tableView.dequeueReusableCell(withIdentifier: "LoverCell", for: indexPath)
        //}else {
        //    cell = tableView.dequeueReusableCell(withIdentifier: "Lover1Cell",for: indexPath)
        //}
        //let cell = tableView.dequeueReusableCell(withIdentifier: "LoverCell", for: indexPath)
        let cell =
            tableView.dequeueReusableCell(withIdentifier: "LoverCell", for:
                indexPath) as! LoverTableViewCell
        // Configure the cell...
        let dic = lovers[indexPath.row]
        cell.nameLabel.text = dic["name"]
        cell.photoImageView.image = UIImage(named: "小丸子.jpg")
        //cell.starView.image = UIImage(named: dic["star"]!)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let indexPath = tableView.indexPathForSelectedRow
        let controller = segue.destination as!
        LoverDetailViewController
        controller.loverDic = [lovers[indexPath!.row]]
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
