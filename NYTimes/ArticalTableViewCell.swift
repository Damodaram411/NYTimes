//
//  ArticalTableViewCell.swift
//  NYTimes
//
//  Created by Damu on 15/11/18.
//  Copyright © 2018 Damu. All rights reserved.
//

import UIKit

class ArticalTableViewCell: UITableViewCell {
    
    @IBOutlet var articalImageView: UIImageView!
    @IBOutlet var articaltitleLabel: UILabel!
    @IBOutlet var autherNameLabel: UILabel!
    @IBOutlet var articalpublishedDateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Assigned content to cell
    public var cellData : Result!{
        didSet{
            self.backgroundColor = UIColor.groupTableViewBackground
            articaltitleLabel.text = cellData.title
            autherNameLabel.text = cellData.byline
            if(cellData.byline.isEmpty)
            {
                 autherNameLabel.text = "N/A"
            }
            articalpublishedDateLabel.text = cellData.publishedDate
            let metadtainfo = cellData.media[0].mediaMetadata.filter { (object) -> Bool in
                return object.format.rawValue == "Standard Thumbnail"
            }
            if let url = URL.init(string: metadtainfo.first?.url ?? "") {
                articalImageView.downloadedFrom(url: url)
            }



        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
