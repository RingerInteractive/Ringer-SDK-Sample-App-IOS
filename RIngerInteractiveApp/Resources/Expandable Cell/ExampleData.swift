//
//  ExampleData.swift
//  ios-swift-collapsible-table-section
//
//  Created by Yong Su on 8/1/17.
//  Copyright © 2017 Yong Su. All rights reserved.
//

import Foundation

//
// MARK: - Section Data Structure
//
public struct Item {
    var name: String
  
    public init(name: String) {
        self.name = name
    }
}

public struct Section {
    var name: String
    var items: [Item]
    var collapsed: Bool
    
    public init(name: String, items: [Item], collapsed: Bool = false) {
        self.name = name
        self.items = items
        self.collapsed = collapsed
    }
}

public var sectionsData: [Section] = [
    Section(name: "Settings", items: [
        Item(name: "Contacts"),
        Item(name: "Notifications")
    ]),
    Section(name: "Terms of Service & Privacy", items: [
        Item(name: "Privacy Policy"),
        Item(name: "Terms of Service"),
        Item(name: "License Agreement")
    ]),
    Section(name: "Contact Us", items: [
    ])
]
