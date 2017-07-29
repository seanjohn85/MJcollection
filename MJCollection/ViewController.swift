//
//  ViewController.swift
//  MJCollection
//
//  Created by JOHN KENNY on 28/07/2017.
//  Copyright © 2017 JOHN KENNY. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    //objects for list 
    var objs : [MJ] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    //whe the page appers, get ctc from the delegate, fetch all the MJ core data objects and store them in the objs array
    override func viewWillAppear(_ animated: Bool) {
        //get the context
        let ctx = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            
            objs = try ctx.fetch(MJ.fetchRequest())
            print(objs)
        }catch{
            
        }
        tableView.reloadData()
        
    }
    
    //sets the number of rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let mj = objs[indexPath.row]
        cell.textLabel?.text = mj.name
        cell.imageView?.image = UIImage(data: mj.image as! Data)
        return cell
    }

}

