//
//  TrackTableViewCell.swift
//  SCFD
//
//  Created by Alex Choi on 10/5/15.
//  Copyright © 2015 CHOI. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    
    var expectedHeight: CGFloat {
        return 80
    }
    
    let avatarImageView = UIImageView()
    let artistLabel = UILabel()
    let titleLabel = UILabel()
    let downloadStatusLabel = UILabel()
    let durationLabel = UILabel()
    let playbackCountLabel = UILabel()
    let downloadCountLabel = UILabel()
    let favoriteCountLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.backgroundColor = Color.backgroundColor
        contentView.addSubviewsWithAutoLayout(avatarImageView, artistLabel, titleLabel, downloadStatusLabel, durationLabel, playbackCountLabel, downloadCountLabel, favoriteCountLabel)
        
        for label in [artistLabel, titleLabel, downloadStatusLabel, durationLabel, playbackCountLabel, downloadCountLabel, favoriteCountLabel] {
            label.textColor = Color.textColor
        }

        for smallLabel in [favoriteCountLabel, downloadCountLabel, downloadStatusLabel] {
            smallLabel.anchorCenterYToCenterYOfView(playbackCountLabel)
        }
        contentView.addConstraintsWithVisualFormatStrings([
            "H:|-5-[avatarImageView(70)]-5-[artistLabel]-5-[durationLabel(40)]-5-|",
            "H:|-5-[avatarImageView]-5-[titleLabel]-5-|",
            "H:|-5-[avatarImageView]-5-[playbackCountLabel(40)]-5-[favoriteCountLabel(40)]-5-[downloadCountLabel(40)]-5-[downloadStatusLabel(40)]",
            "V:|-5-[avatarImageView(70)]",
            "V:|-5-[artistLabel]-5-[titleLabel]-5-[playbackCountLabel]"
            ], views: [
            "avatarImageView": avatarImageView,
            "artistLabel": artistLabel,
            "titleLabel": titleLabel,
            "downloadStatusLabel": downloadStatusLabel,
            "durationLabel": durationLabel,
            "playbackCountLabel": playbackCountLabel,
            "downloadCountLabel": downloadCountLabel,
            "favoriteCountLabel": favoriteCountLabel])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepare(track: Track) {
        avatarImageView.backgroundColor = UIColor.purpleColor()
        artistLabel.text = track.user.username
        titleLabel.text = track.title
        playbackCountLabel.text = String(track.playbackCount)
        favoriteCountLabel.text = String(track.favoritingsCount)
        downloadCountLabel.text = String(track.downloadCount)
        durationLabel.text = String(track.duration) // format to hh:mm
        downloadStatusLabel.text = "i"
    }
    
}
