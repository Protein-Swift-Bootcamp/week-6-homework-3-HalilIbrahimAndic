//
//  ViewController.swift
//  collectionViewExample
//
//  Created by Halil Ibrahim Andic on 10.01.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonTapped(_ sender: Any) {
        if let collectionVC = storyboard?.instantiateViewController(identifier: "collection") as? CollectionViewController {
            collectionVC.modalPresentationStyle = .fullScreen
            present(collectionVC, animated: true, completion: nil)
        }
    }
}

