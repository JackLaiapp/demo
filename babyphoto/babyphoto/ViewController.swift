//
//  ViewController.swift
//  babyphoto
//
//  Created by MyMac on 2017/4/10.
//  Copyright © 2017年 Jack Lai. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var info:[Info] = []
    var searchController : UISearchController!
    var searchResults : [Info] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.rightBarButtonItem! = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.deleteBtn(_:)))
        
        //Search at the top
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.searchResultsUpdater = self
        //self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        
        searchController.searchBar.becomeFirstResponder()
        
        self.navigationItem.titleView = searchController.searchBar
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
        if searchController.isActive {
            return searchResults.count
        } else {
            return info.count
        }
        
    }
    // 必須實作的方法：每個 cell 要顯示的內容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! InfoCollectionViewCell
        
        let data = (searchController.isActive) ? searchResults[indexPath.row]
            : info[indexPath.row]

        if data.image != nil {
        cell.babyImageView.image = UIImage(data: data.image as! Data)
        cell.babyTitleLabel.text = data.date! + "\n" + data.title!
        }
        if self.navigationItem.rightBarButtonItem?.title == "Edit" {
            cell.deleteButton.isHidden = true
        }
        else {
            cell.deleteButton.isHidden = false
        }
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(ViewController.deletePhoto(sender:)), for: .touchUpInside)
        
        return cell
    }
    // 點選 cell 後執行的動作
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let myView = storyboard?.instantiateViewController(withIdentifier: "Showdetail") as! DetailViewController
        myView.myData = self.info[indexPath.item]
        navigationController?.pushViewController(myView, animated: true)
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

    @IBAction func deleteBtn(_ sender: UIBarButtonItem) {
        
        if self.navigationItem.rightBarButtonItem!.title == "Edit"
        {
            for item in collectionView.visibleCells as! [InfoCollectionViewCell] {
                
                let indexpath : NSIndexPath = collectionView!.indexPath(for: item as InfoCollectionViewCell)! as NSIndexPath
                let cell : InfoCollectionViewCell = collectionView!.cellForItem(at: indexpath as IndexPath) as!InfoCollectionViewCell
                
                //Close Button
                let close : UIButton = cell.deleteButton
                close.isHidden = false

            }
            self.navigationItem.rightBarButtonItem! = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.deleteBtn(_:)))

        }
        else
        {
            self.navigationItem.rightBarButtonItem! = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.done, target: self, action: #selector(ViewController.deleteBtn(_:)))
            collectionView.reloadData()
        }
    }
    
    func deletePhoto(sender: UIButton!){

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let data = info[sender.tag]
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }

    func filterContent(for searchText: String) {
        searchResults = info.filter({ (title) -> Bool in
            if let name = title.title {
                let isMatch = name.localizedCaseInsensitiveContains(searchText)
                return isMatch
            }
            return false
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            collectionView.reloadData()
        }
    }
    
}


