//
//  ContactCell.swift
//  LBTAUITableview2-swift
//
//  Created by Victor Hugo Benitez Bosques on 07/10/18.
//  Copyright © 2018 Victor Hugo Benitez Bosques. All rights reserved.
//

import UIKit

protocol ContactCellDelegate {
    func someMethodIWantToCall(cell: UITableViewCell)
    
}
class ContactCell: UITableViewCell {
    
//    var link: ViewController?
    var delegate : ContactCellDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // kind of cheat and use a hack
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "fav_star"), for: .normal)
        starButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        
        starButton.tintColor = .red
        starButton.addTarget(self, action: #selector(handleMarkAsFavorite), for: .touchUpInside)
        
        accessoryView = starButton
    }
    
    @objc private func handleMarkAsFavorite() {
        //        print("Marking as favorite")
//        link?.someMethodIWantsToCall(cell: self) // self pass the ContactCell class
        delegate?.someMethodIWantToCall(cell: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
