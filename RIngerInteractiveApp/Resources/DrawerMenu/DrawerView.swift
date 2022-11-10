//
//  DrawerView.swift
//  NavigationDrawer
//
//  Created by Sowrirajan Sugumaran on 05/10/17.
//  Copyright © 2017 Sowrirajan Sugumaran. All rights reserved.
//

import UIKit

protocol DrawerControllerDelegate: AnyObject {
    func pushTo(indexPath: IndexPath)
}

class DrawerView: UIView, drawerProtocolNew {
    
    var sections = sectionsData
    
    public let screenSize = UIScreen.main.bounds
    var backgroundView = UIView()
    var drawerView = UIView()
    var tblVw = UITableView()
    var aryViewControllers = NSArray()
    weak var delegate: DrawerControllerDelegate?
    var currentViewController = UIViewController()
    var cellTextColor: UIColor?
    var userNameTextColor: UIColor?
    var btnLogOut = UIButton()
    var btnTC = UIButton()
    var btnDriver = UIButton()
    var vwForHeader = UIView()
    var vwForFooter = UIView()
    var lblunderLine = UILabel()
    var imgBg: UIImage?
    var fontNew: UIFont?
    var first = false
    
    fileprivate var imgProPic = UIImageView()
    fileprivate let imgBG = UIImageView()
    fileprivate var lblUserName = UILabel()
    fileprivate var gradientLayer: CAGradientLayer!
    
    convenience init(isBlurEffect: Bool, controller: UIViewController) {
        self.init(frame: UIScreen.main.bounds)
        self.tblVw.register(UINib.init(nibName: "DrawerCell", bundle: nil), forCellReuseIdentifier: "DrawerCell")
        self.initialise(isBlurEffect: isBlurEffect, controller: controller)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialise(isBlurEffect: Bool, controller: UIViewController) {
        
        currentViewController = controller
        currentViewController.tabBarController?.tabBar.isHidden = true
        tblVw.tableFooterView = UIView()
        backgroundView.frame = frame
        drawerView.backgroundColor = UIColor.clear
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0.6
        
        // Initialize the tap gesture to hide the drawer.
        let tap = UITapGestureRecognizer(target: self, action: #selector(DrawerView.actDissmiss))
        backgroundView.addGestureRecognizer(tap)
        addSubview(backgroundView)
        tblVw.estimatedRowHeight = 0.0
        drawerView.frame = CGRect(x: 0, y: 0, width: (screenSize.width   * 0.70), height: screenSize.height)
        drawerView.clipsToBounds = true
        
        // Initialize the gradient color for background view
       
        imgBG.frame = drawerView.frame
        self.drawerView.backgroundColor = .white
        
        // This is for adjusting the header frame to set header either top (isHeaderInTop:true) or bottom (isHeaderInTop:false)
        self.allocateLayout()
    }
    
    func allocateLayout() {
        
        imgProPic = UIImageView(frame: CGRect(x: 20, y: 3, width:drawerView.frame.width  * 0.3, height:drawerView.frame.width  * 0.3))
        vwForHeader = UIView(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height + 10, width:drawerView.frame.size.width, height:0))
        imgProPic.image = UIImage()
        vwForHeader.addSubview(imgProPic)
        
        lblUserName = UILabel(frame: CGRect(x: imgProPic.frame.maxX + 10, y: 0, width: vwForHeader.frame.size.width - imgProPic.frame.maxX - 10, height: 50))
        lblUserName.text = ""
        vwForHeader.addSubview(lblUserName)
        
        self.lblunderLine = UILabel(frame: CGRect(x: vwForHeader.frame.origin.x+10, y: 0, width:vwForHeader.frame.size.width-20, height: 0.0))
        if UIApplication.shared.statusBarFrame.height > 21{
            lblUserName.font = UIFont.boldSystemFont(ofSize: 20)
            tblVw.frame = CGRect(x: 0, y: 0, width: drawerView.frame.width, height: screenSize.height-0)
        }else{
            lblUserName.font = UIFont.boldSystemFont(ofSize: 17)
            tblVw.frame = CGRect(x: 0, y: 0, width: drawerView.frame.width, height:screenSize.height-0)
        }
        vwForFooter = UIView(frame: CGRect(x: 0, y: tblVw.frame.maxY + 10, width: drawerView.frame.size.width, height: 0))
        vwForFooter.backgroundColor = UIColor.clear
//        tblVw.separatorStyle = UITableViewCell.SeparatorStyle.none
//        aryViewControllers = controllers
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.clipsToBounds = true
        tblVw.backgroundColor = UIColor.clear
        vwForHeader.backgroundColor = UIColor.clear
        drawerView.addSubview(tblVw)
        tblVw.reloadData()
        
        lblunderLine.backgroundColor = UIColor.groupTableViewBackground
        vwForHeader.addSubview(lblunderLine)
        drawerView.addSubview(vwForFooter)
        
        drawerView.addSubview(vwForHeader)
        btnTC = UIButton(frame: CGRect(x: 0, y: 20, width: drawerView.frame.size.width, height: 0))
        vwForFooter.addSubview(btnTC)
    
        addSubview(drawerView)
    }
    
    // To dissmiss the current view controller tab bar along with navigation drawer
    @objc func actDissmiss() {
        currentViewController.tabBarController?.tabBar.isHidden = false
        self.dissmiss()
    }
   
}

extension DrawerView:  UITableViewDelegate, UITableViewDataSource {
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    
    // Cell
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollapsibleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollapsibleTableViewCell ??
            CollapsibleTableViewCell(style: .default, reuseIdentifier: "cell")
        
        let item: Item = sections[indexPath.section].items[indexPath.row]
        
        cell.nameLabel.text = item.name
     
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 44.0
    }
    
    // Header
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(sections[section].collapsed)

         if section == 2 {
             header.arrowLabel.text = ""
             if !first {
                 first = true
             } else {
                 self.delegate?.pushTo(indexPath: IndexPath(row: 0, section: section))
                 actDissmiss()
             }
         }
         
        header.section = section
        header.delegate = self
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.pushTo(indexPath: indexPath)
        actDissmiss()
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0.0
    }
    
}

extension DrawerView: CollapsibleTableViewHeaderDelegate {

    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed

        // Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)

        tblVw.reloadSections(NSIndexSet(index: section) as IndexSet, with: .none)
    }
}
