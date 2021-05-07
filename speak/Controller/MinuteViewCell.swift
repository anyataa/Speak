//
//  MinuteViewCell.swift
//  speak
//
//  Created by Anya Akbar on 29/04/21.
//

import UIKit

class MinuteViewCell: UICollectionViewCell {
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    
    func configMinuteCell(number : Int) {
        mainLabel.text = "\(number)"
        mainLabel.frame = CGRect(x: 2, y: 20, width: 110, height: 40)
        mainLabel.textAlignment = .center
        mainLabel.font = UIFont.primaryBig
        
        
        minuteLabel.text = "minute"
        minuteLabel.frame = CGRect(x: 2, y: 50, width: 110, height: 34)
        minuteLabel.font = UIFont.primary(size: 22)
        minuteLabel.textAlignment = .center
    }
    
   
}
