//
//  DetailViewController.swift
//  Contacts.
//
//  Created by wahid tariq on 15/08/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    var name:String = ""
    var phone:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        numberLabel.text = phone
        nameLabel.text = name
        title = name
        

        navigationItem.largeTitleDisplayMode = .never
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.hidesBarsOnTap = true
//        navigationItem.hidesBackButton = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        navigationController?.hidesBarsOnTap = false
        navigationController?.hidesBarsOnTap = false
       
    }


}
