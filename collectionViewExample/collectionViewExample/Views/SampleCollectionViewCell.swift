//
//  SampleCollectionViewCell.swift
//  collectionViewExample
//
//  Created by Halil Ibrahim Andic on 10.01.2023.
//

import UIKit

class SampleCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
    }

}
