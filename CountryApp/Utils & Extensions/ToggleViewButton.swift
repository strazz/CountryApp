//
//  ToggleViewButton.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 04/01/22.
//

import SwiftUI

struct ToggleViewButton: View {
    
    @State private var show: Bool
    private let action: (() -> Void)?
    
    init(show: Bool, action: (() -> Void)? = nil) {
        self.action = action
        self.show = show
    }
    
    var body: some View {
        Button(show ? "button.hide".localized : "button.show".localized) {
            show.toggle()
            action?()
        }
    }
}

struct ToggleViewButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleViewButton(show: true)
    }
}
