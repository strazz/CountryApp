//
//  ErrorView.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 03/01/22.
//

import SwiftUI

struct ErrorView: View {
    
    private let error: Error
    
    init(with error: Error) {
        self.error = error
    }
    
    var body: some View {
        Text(error.localizedDescription)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        let mockError = APIError.invalidUrl(statusCode: -1, url: "test")
        ErrorView(with: mockError)
    }
}
