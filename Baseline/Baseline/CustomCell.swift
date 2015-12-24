//
//  CustomCell.swift
//  Baseline
//
//  Created by Bharti Softech on 12/9/15.
//  Copyright © 2015 Givenera. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
       
      //  self.contentView.addSubview(eventName)
       
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
      //  eventName = UILabel(frame: CGRectMake(20, 10, self.bounds.size.width - 40, 25))
       
        
    }

}
