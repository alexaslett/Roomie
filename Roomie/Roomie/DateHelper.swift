//
//  DateHelper.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/22/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation

extension Date {
    var formatter: DateFormatter? {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.doesRelativeDateFormatting = true
        return formatter
    }
}
