//
//  StringExtensions.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 03/01/22.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
