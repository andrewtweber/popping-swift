//
//  AnimationsListViewController.swift
//  Popping
//
//  Created by Andrew Weber on 12/18/18.
//  Copyright © 2018 Andrew Weber. All rights reserved.
//

import UIKit

class AnimationsListViewController: UITableViewController
{
    var kCellIdentifier = "cellIdentifier"
    var titles: [String]!
    var controllers: [UIViewController.Type]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "popping"
        self.configureTableView()
        self.configureTitleView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = self.viewController(forRowAt: indexPath)
        viewController.title = self.title(forRowAt: indexPath)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! MenuTableViewCell
        cell.textLabel?.text = self.title(forRowAt: indexPath)
        return cell
    }
    
    private func configureTableView() {
        self.titles = [
            //"Button Animation",
            "Circle Animation",
            //"Image Animation",
            "Custom Transition",
            //"Paper Button Animation",
            "Folding Animation",
            "Password Indicator Animation",
            //"Constraints Animation",
        ]
        self.controllers = [
            //ButtonViewController.self,
            CircleViewController.self,
            //ImageViewController.self,
            CustomTransitionViewController.self,
            //PaperButtonViewController.self,
            FoldingViewController.self,
            PasswordViewController.self,
            //ConstraintsViewController.self,
        ]
        
        self.tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 50
    }
    
    private func configureTitleView() {
        let headlineLabel = UILabel()
        headlineLabel.font = UIFont(name: "Avenir-Light", size: 28)
        headlineLabel.textAlignment = .center
        headlineLabel.textColor = .customGray
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.customBlue,
        ]
        
        let attributedString = NSMutableAttributedString(string: self.title!)
        attributedString.addAttributes(attributes, range: NSRange(location: 1, length: 1))
        headlineLabel.attributedText = attributedString
        headlineLabel.sizeToFit()
        
        self.navigationItem.titleView = headlineLabel
    }
    
    private func viewController(forRowAt indexPath: IndexPath) -> UIViewController {
        let type: UIViewController.Type = self.controllers[indexPath.row]
        
        return type.init()
    }
    
    private func title(forRowAt indexPath: IndexPath) -> String {
        return self.titles[indexPath.row]
    }
}
