//
//  TrackTableViewCell.swift
//  SCFD
//
//  Created by Alex Choi on 10/5/15.
//  Copyright © 2015 CHOI. All rights reserved.
//

import UIKit
import AlamofireImage

func stringFromTimeInterval(interval:NSTimeInterval) -> String {
    let interval = NSInteger(interval)
    
    let seconds = interval % 60
    let minutes = (interval / 60) % 60
    let hours = (interval / 3600)
    
    var string = ""
    if hours > 0 {
        string += "\(hours):"
    }
    string += String(NSString(format: "%.2d:", minutes))
    string += String(NSString(format: "%.2d", seconds))
    
    return string
}

extension Int64 {
    /** HH:MM:SS formatted string under assumption time is in milliseconds */
    var timeIntervalString: String {
        return stringFromTimeInterval(NSTimeInterval(self / 1000))
    }

}

extension Int {
    
    var neatString: String {
        if self == 0 { return "" }
        let million = 1000000
        let thousand = 1000
        let float = Float(self)
        if self >  million {
            return String(NSString(format: "%.1fM", float / Float(million)))
        } else if self > thousand {
            return String(NSString(format: "%.1fK", float / Float(thousand)))
        } else {
            return String(self)
        }
    }
}

class TrackTableViewCell: UITableViewCell {
    
    let avatarImageView = UIImageView()
    
    let labelContainer = UIView()
    let artistLabel = UILabel()
    let titleLabel = UILabel()
    let durationLabel = UILabel()
    
    let downloadStatusLabel = UILabel()
    let playbackCountLabel = UILabel()
    let downloadCountLabel = UILabel()
    let favoriteCountLabel = UILabel()
    
    let verticalPadding: CGFloat = 5
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .None

        contentView.backgroundColor = Color.Background.value
        contentView.addSubviewsWithAutoLayout(avatarImageView, labelContainer)
        
        let labels = [artistLabel, titleLabel, durationLabel, downloadStatusLabel, playbackCountLabel, downloadCountLabel, favoriteCountLabel]
        
        for label in labels {
            label.backgroundColor = Color.Background.value
            labelContainer.addSubviewWithAutoLayout(label)
        }
        
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .ByWordWrapping
        titleLabel.setFont(.Body)
        
        artistLabel.setFont(.Caption1)
        
        for label in [downloadStatusLabel, durationLabel, playbackCountLabel, downloadCountLabel, favoriteCountLabel] {
            label.setFont(.Caption2)
        }
        
        for label in [artistLabel, titleLabel, downloadStatusLabel, durationLabel, playbackCountLabel, downloadCountLabel, favoriteCountLabel] {
            label.textColor = Color.PrimaryForeground.value
        }

        for smallLabel in [favoriteCountLabel, downloadCountLabel, downloadStatusLabel] {
            smallLabel.anchorCenterYToCenterYOfView(playbackCountLabel)
        }
        
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .ScaleAspectFill
        avatarImageView.anchorAllEdgesToView(contentView)

        durationLabel.anchorCenterYToCenterYOfView(artistLabel)

        labelContainer.anchorCenterToCenterOfView(contentView)
        contentView.addConstraintsWithVisualFormatStrings([
            "H:|-25-[labelContainer]-15-|"], views: [
            "labelContainer": labelContainer])
        
        let spacers = [UIView(), UIView(), UIView()]
        labelContainer.addSubviewsWithAutoLayout(spacers)
        
        labelContainer.addConstraintsWithVisualFormatStrings([
            "H:|[artistLabel]->=5-[durationLabel]|",
            "H:|[titleLabel]->=0-|",
            "H:|[playbackCountLabel][spacer1(==spacer2)][favoriteCountLabel][spacer2(==spacer3)][downloadCountLabel][spacer3][downloadStatusLabel]|",
            "V:|[artistLabel]-v-[titleLabel]->=v-[playbackCountLabel]|"
            ], metrics: [
                "v": verticalPadding
            ]
            , views: [
            "artistLabel": artistLabel,
            "titleLabel": titleLabel,
            "durationLabel": durationLabel,
                "playbackCountLabel": playbackCountLabel,
                "downloadCountLabel": downloadCountLabel,
                "favoriteCountLabel": favoriteCountLabel,
                "downloadStatusLabel": downloadStatusLabel,
                "spacer1": spacers[0],
                "spacer2": spacers[1],
                "spacer3": spacers[2]
            ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarImageView.image = nil
    }
    
    func prepare(track: Track) {
        if let imageURL = NSURL(string: track.fullSizeArtworkURL) {
            avatarImageView.af_setImageWithURL(imageURL)
        }        
        artistLabel.text = track.user.username
        titleLabel.text = track.title
        playbackCountLabel.text = track.playbackCount.neatString
        favoriteCountLabel.text = track.favoritingsCount.neatString
        downloadCountLabel.text = track.downloadCount.neatString
        durationLabel.text = track.duration.timeIntervalString
        downloadStatusLabel.text = "i"
    }
    
}

extension Track {
    
    var fullSizeArtworkURL: String {
        let imageURL = artworkUrl ?? user.avatarUrl
        return imageURL.stringByReplacingOccurrencesOfString("large", withString: "t500x500")
    }

}
