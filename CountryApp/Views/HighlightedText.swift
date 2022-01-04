//
//  HighlightedText.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 03/01/22.
//

import SwiftUI

struct HighlightedText: View {
    let text: String
    let matching: String
    
    init(_ text: String, matching: String) {
        self.text = text
        self.matching = matching
    }
    
    var body: some View {
        guard let regex = try? NSRegularExpression(
            pattern: NSRegularExpression.escapedPattern(for: matching)
                .trimmingCharacters(in: .whitespacesAndNewlines).folding(options: .regularExpression, locale: .current),
            options: .caseInsensitive), matching.count > 2 else {
            return Text(text)
        }
        
        let range = NSRange(location: 0, length: text.count)
        let matches = regex.matches(in: text, options: .withTransparentBounds, range: range)
        
        return text.enumerated().map { (char) -> Text in
            guard matches.filter( {
                $0.range.contains(char.offset)
            }).count == 0 else {
                return Text( String(char.element) ).foregroundColor(.red)
            }
            return Text( String(char.element) )
            
        }.reduce(Text("")) { (a, b) -> Text in
            return a + b
        }
    }
}
