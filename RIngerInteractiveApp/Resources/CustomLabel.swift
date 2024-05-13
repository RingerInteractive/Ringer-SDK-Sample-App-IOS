//
//  CustomLabel.swift
//  RIngerInteractiveApp
//
//  Created by AnhDNT on 09/01/2024.
//

import UIKit

class CustomLabel: UILabel {

    // Default value for the label text
    var defaultValue: String = "Copyright %d Flash App, LLC"

    // Custom initializer with default value
    init(defaultValue: String) {
        super.init(frame: .zero)
        self.defaultValue = defaultValue
        setupLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }

    private func setupLabel() {
        // Set up any additional label configurations here
        let calendar = Calendar.current
        let currentDate = Date()
        let year = calendar.component(.year, from: currentDate)
        text = String(format: defaultValue, year)
        textColor = UIColor.white
        font = UIFont(name: "Nexa-Light", size: 15)
        // Add other styling or configuration as needed
    }
}
