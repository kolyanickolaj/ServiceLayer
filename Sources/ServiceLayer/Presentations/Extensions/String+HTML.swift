//
//  String+HTML.swift
//  ServiceLayer
//
//  Created by Andrey Polyashev on 3/1/24.
//

import UIKit

extension String {
    
    public func htmlToAttributedString(
        options: [NSAttributedString.DocumentReadingOptionKey : Any]? = nil,
        documentAttributes: AutoreleasingUnsafeMutablePointer<NSDictionary?>? = nil,
        baseFont: UIFont? = nil,
        foregroundColor: UIColor? = nil
    ) -> NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        var options = options
        if options != nil {
            options?[.documentType] = NSAttributedString.DocumentType.html
            options?[.characterEncoding] = String.Encoding.utf8.rawValue
        } else {
            options = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue,
            ]
        }
        guard let options else { return nil }
        do {
            let attributed = try NSMutableAttributedString(
                data: data,
                options: options,
                documentAttributes: nil
            )
            
            if let baseFont {
                attributed.setBaseFont(baseFont: baseFont, color: foregroundColor)
            }
            return attributed
        } catch {
            return nil
        }
    }
}


extension NSMutableAttributedString {

    /// Replaces the base font (typically Times) with the given font, while preserving traits like bold and italic
    public func setBaseFont(baseFont: UIFont?, color: UIColor? = nil, preserveFontSizes: Bool = false) {
        let baseDescriptor = baseFont?.fontDescriptor
        let wholeRange = NSRange(location: 0, length: length)
        beginEditing()
        enumerateAttribute(.font, in: wholeRange, options: []) { object, range, _ in
            if let font = object as? UIFont,
               let baseDescriptor,
               let descriptor = baseDescriptor.withSymbolicTraits(font.fontDescriptor.symbolicTraits)  {
                let newSize = preserveFontSizes ? descriptor.pointSize : baseDescriptor.pointSize
                let newFont = UIFont(descriptor: descriptor, size: newSize)
                self.removeAttribute(.font, range: range)
                self.addAttribute(.font, value: newFont, range: range)
            }
            
            if let color {
                self.removeAttribute(.foregroundColor, range: range)
                self.addAttribute(.foregroundColor, value: color, range: range)
            }
        }
        endEditing()
    }
}
