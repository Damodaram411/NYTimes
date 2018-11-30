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
            if((cellData.byline ?? "").isEmpty)
            {
                 autherNameLabel.text = "N/A"
            }
            setimageforDateLabel(cellData.publishedDate)
            let metadtainfo = cellData.media[0].mediaMetadata.filter { (object) -> Bool in
                return object.format.rawValue == "Standard Thumbnail"
            }
            if let url = URL.init(string: metadtainfo.first?.url ?? "") {
                articalImageView.downloadedFrom(url: url)
            }
        }
    }
    func setimageforDateLabel(_ text : String)
    {
        
        let iconsSize = CGRect(x: 0, y: -5, width: 22, height: 22)

        // #1. Define dict attribute for string
//        let bold17 = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]
        let font = [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 14.0)]

        // #2. Create "date" string and add the dict attribute to it
        let dateStr = NSAttributedString(string:"  \(text)", attributes: font as [NSAttributedString.Key : Any])
        
        // #3. Create NSTextAttachment
        let textAttachment = NSTextAttachment()
        
        // #4. Add image to the textAttachment then set it's bounds
        textAttachment.image = UIImage(named: "calendar")
        textAttachment.bounds = iconsSize

        
        // #5. Set image as NSAttributedString
        let calendarImage = NSAttributedString(attachment: textAttachment)
        
        // #6. Create NSMutableString to
        let mutableAttributedString = NSMutableAttributedString()
        
        mutableAttributedString.append(calendarImage)
        mutableAttributedString.append(dateStr)
        
        // #8. Set the mutableAttributedString to the textView then center it
        articalpublishedDateLabel.attributedText = mutableAttributedString
//        articalpublishedDateLabel.textAlignment = .center
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
