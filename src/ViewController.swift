//
//  ViewController.swift
//  SCFD
//
//  Created by Alex Choi on 10/3/15.
//  Copyright © 2015 CHOI. All rights reserved.
//

import UIKit
import SoundCloudKit
import SwiftyJSON
import PromiseKit
import Alamofire



struct SoundCloud {
    
    typealias Router = SoundCloudKit.APIClient.Router // fucking guy nested the router
    
    let apiClient = SoundCloudKit.APIClient()
    let clientId = Private.clientId
    
    init() {
        APIClient.clientId = clientId
    }
    
    func fetchUser(name: String) -> Promise<User> {
        return Promise { fulfill, reject in
            apiClient.fetch(Router.User(name)) { (req, resp, res) -> Void in
                if let resValue = res.value {
                    fulfill(User(json: JSON(resValue)))
                } else if let error = res.error {
                    return reject(error)
                }
            }
        }
    }
    
    func fetchUserFavorites(user: User) -> Promise<[Track]> {
        return Promise { fulfill, reject in
            apiClient.fetch(Router.FavoritesOfUser(user), callback: { (req, resp, res) -> Void in
                if let resValue = res.value {
                    let tracks = JSON(resValue).arrayValue.map { Track(json: $0) }
                    fulfill(tracks)
                } else if let error = res.error {
                    return reject(error)
                }
            })
        }
    }
    
    func downloadFile(url: String, fileName: String) -> Promise<String> {
        let fileManager = NSFileManager.defaultManager()
        let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let destinationPath = directoryURL.URLByAppendingPathComponent(fileName).absoluteString
        
        return Promise { fulfill, reject in
            Alamofire.download(.GET, url, parameters: ["client_id": clientId], encoding: .URL) { temporaryURL, response in
                return NSURL(string: destinationPath)!
                }
                .progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
                    
                    let progress = Int(Float(totalBytesRead) / Float(totalBytesExpectedToRead) * 100)
                    
                    // This closure is NOT called on the main queue for performance
                    // reasons. To update your ui, dispatch to the main queue.
                    dispatch_async(dispatch_get_main_queue()) {
                        print("\(fileName) progress: \(progress) %")
                    }
                }
                .response { req, resp, data, error in
                    if let error = error {
                        print("Failed with error: \(error)")
                        return reject(error)
                    } else {
                        print("Downloaded file successfully. should be in \(destinationPath)")
                        fulfill(destinationPath)
                    }
            }
        }
    }
    
}

class ViewController: UIViewController {
    
    let soundCloud = SoundCloud()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        soundCloud.fetchUser("mindslime")
        .then { user in
            return self.soundCloud.fetchUserFavorites(user)
        }
        .then { (favorites) -> Promise<String> in
            print(favorites.map { $0.user.username + $0.title })
            let first = favorites.first!
            return self.soundCloud.downloadFile(first.streamUrl, fileName: first.user.username + first.title)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

