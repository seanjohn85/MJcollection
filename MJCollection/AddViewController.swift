//
//  AddViewController.swift
//  MJCollection
//
//  Created by JOHN KENNY on 29/07/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var mj : MJ? = nil
    
    
    @IBOutlet var deletebut: UIButton!
    
    @IBOutlet var addbut: UIButton!
    
    @IBOutlet var image: UIImageView!
    
    @IBOutlet var name: UITextField!
    
    //allows selected image
    var picker = UIImagePickerController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (mj != nil){
           
            print("edit screen")
            image.image = UIImage(data: mj?.image as! Data)
            name.text = mj?.name
            addbut.setTitle("Update", for: .normal)
        }else{
            deletebut.isHidden = true
    
        }

        picker.delegate = self
    }

    //add the element
    @IBAction func addMJ(_ sender: Any) {
        if (mj == nil){
            let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let mj = MJ(context: ctx)
            mj.name = name.text
            mj.image = UIImagePNGRepresentation(image.image!) as! NSData
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
        }else{
            mj!.name = name.text
            mj!.image = UIImagePNGRepresentation(image.image!) as! NSData
            
        }
        
        
        
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func camerbtn(_ sender: Any) {
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
        
    }

    
    
    @IBAction func photos(_ sender: Any) {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            let img = info[UIImagePickerControllerOriginalImage] as! UIImage
            image.image = img
            picker.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func deletebtn(_ sender: Any) {
        let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        ctx.delete(mj!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
    }
    
    
}
