//
//  ViewController.swift
//  SCFD
//
//  Created by Alex Choi on 10/3/15.
//  Copyright © 2015 CHOI. All rights reserved.
//

import UIKit
import PromiseKit

class HomeViewController: UIViewController {
    
    let soundCloud = SoundCloud()
    
    let tableView = UITableView(frame: CGRectZero, style: .Plain)
    
    var tracks = [Track]()
    
    let cellIdentifier = "cellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "Home"
        
        tableView.backgroundColor = Color.backgroundColor
        tableView.registerClass(TrackTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 80
        
        view.addSubviewsWithAutoLayout(tableView)
        view.addConstraintsWithVisualFormatStrings([
            "H:|[tableView]|",
            "V:|[tableView]|"], views: [
            "tableView": tableView])
        
        loadTracks()
    }
    
    func trackForIndexPath(indexPath: NSIndexPath) -> Track {
        return tracks[indexPath.row]
    }
    
    func loadTracks() {
        soundCloud.fetchUser("mindslime")
            .then { (user) in
                return self.soundCloud.fetchUserFavorites(user)
            }
            .then { (favorites) -> Void in
                self.tracks = favorites
                self.tableView.reloadData()
            }
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! TrackTableViewCell
        let track = trackForIndexPath(indexPath)
        cell.prepare(track)
        return cell
    }
}

