//
//  CGMainScreenCell.swift
//  ChildGames
//
//  Created by v.vasilenko on 26.08.16.
//  Copyright © 2016 v.vasilenko. All rights reserved.
//

import UIKit

class STTweetCell: UITableViewCell {

    @IBOutlet weak var cellTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureForModel(indexPath: IndexPath, tweet: Tweet ) {
        if(indexPath.row % 2 == 0) {
            backgroundColor = UIColor.gray
            cellTitleLabel.textColor = UIColor.white
        } else {
            backgroundColor = UIColor.white
            cellTitleLabel.textColor = UIColor.black
        }
        self.cellTitleLabel.text = tweet.text
    }
}
