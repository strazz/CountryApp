//
//  ImageCacheError.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 03/01/22.
//

import Foundation

enum ImageCacheError: LocalizedError {
    case dataConversionFailed
    case invalidUrl
    case sessionError(Error)
}
