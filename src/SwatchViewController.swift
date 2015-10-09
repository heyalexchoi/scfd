//
//  ColorSwatchTableViewController.swift
//  WeLive
//
//  Created by Alex Choi on 9/25/15.
//  Copyright © 2015 WeWork. All rights reserved.
//

import UIKit

class SwatchViewController: UITableViewController {
    
    enum Section: Int {
        case Fonts, Colors
        static var all: [Section] {
            return [Fonts, Colors]
        }
        var items: [StyleEnum] {
            switch self {
            case .Fonts:
                return Font.all
            case .Colors:
                return Color.all
            }
        }
        var title: String {
            switch self {
            case .Fonts:
                return "Fonts"
            case .Colors:
                return "Colors"
            }
        }
    }
    
    let cellIdentifier = "cellIdentifier"
    let colors = Color.all
    let fonts = Font.all
    
    init() {
        super.init(style: .Grouped)
        title = "Swatch"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return Section.all.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = Section(rawValue: section)!
        return section.items.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        let styleItem = itemForIndexPath(indexPath)
        
        if let styleItem = styleItem as? Color {
            cell.backgroundColor = styleItem.value
            cell.textLabel?.text = styleItem.name
            cell.textLabel?.font = UIFont.systemFontOfSize(15)
            
        } else if let styleItem = styleItem as? Font {
            cell.backgroundColor = UIColor.whiteColor()
            cell.textLabel?.text = styleItem.name
            cell.textLabel?.font = styleItem.value
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section)!.title
    }
    
    // MARK: - Helpers
    
    func itemForIndexPath(indexPath: NSIndexPath) -> StyleEnum {
        let section = Section(rawValue: indexPath.section)!
        return section.items[indexPath.item]
    }

}
