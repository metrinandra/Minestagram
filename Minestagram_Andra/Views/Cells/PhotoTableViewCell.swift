//
//  PhotoTableViewCell.swift
//  Minestagram_Andra
//
//  Created by Andra Metrina on 30/05/2021.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    static let identifier = "PhotoCollectionViewCell"
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(){
        // cell config
    }
    
    override func layoutSubviews() {
        //
    }
}
