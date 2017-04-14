//
//  AddViewController.swift
//  babyphoto
//
//  Created by MyMac on 2017/4/13.
//  Copyright © 2017年 Jack Lai. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var location: UITextField!
    
    @IBAction func selectImage(_ sender: Any) {
/*        //建立一個ImagePickerController
        let imagePicker = UIImagePickerController()
        //實作UIImagePickerControllerDelegate的物件
        imagePicker.delegate = self
        //不允許使用者在UIImagePickerController的畫面中編輯、修改相片
        imagePicker.allowsEditing = false
        //指定從相簿中挑選相片
        imagePicker.sourceType = .photoLibrary
        //顯示UIImagePickerController

        self.present(imagePicker, animated: true, completion: nil)
*/
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //取得由相簿中所選擇的相片
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //結束UIImagePickerController
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func savebtn(_ sender: Any) {
        if imageView.image != nil{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let info = Info(context: context)

        info.image = UIImagePNGRepresentation(imageView.image!)! as NSData?
        info.title = textField.text!
        info.location = location.text!
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
        }else{
         noselectImage()   
        }
    }
    
    func noselectImage(){
        let alertVC = UIAlertController(
            title: "No Select Photo",
            message: "Sorry, Please Select Photo",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
