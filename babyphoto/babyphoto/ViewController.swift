//
//  ViewController.swift
//  babyphoto
//
//  Created by MyMac on 2017/4/10.
//  Copyright © 2017年 Jack Lai. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var info:[Info] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getdata()
        
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // 有幾個 section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    // 必須實作的方法：每一組有幾個 cell
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return info.count
    }
    // 必須實作的方法：每個 cell 要顯示的內容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! InfoCollectionViewCell
        let data = info[indexPath.row]
        if data.image != nil{
        cell.babyImageView.image = UIImage(data: data.image as! Data)

        }
        
        cell.babyTitleLabel.text = data.title

        return cell
    }
    // 點選 cell 後執行的動作
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let data = info[indexPath.row]
        context.delete(data)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do{
            info = try context.fetch(Info.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
        self.collectionView.reloadData()

    }
    
    func getdata(){
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            info = try context.fetch(Info.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
        
    }

}


