//
//  UILabel+Ext.swift
//  Tonywin
//
//  Created by Vladislav Pavlov on 19.10.2023.
//

import UIKit.UILabel

extension UILabel {
    
    func setAttributes(kern: Double? = nil, heightMultiple: Double = 1.0, aligment: NSTextAlignment) {
        
        // For the method to work successfully, it is necessary that the text is not nil.
        
        guard let text = self.text else { return }
        let nsAttributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = aligment
        paragraphStyle.lineHeightMultiple = heightMultiple
        
        var attributes: [NSAttributedString.Key: Any] = [.paragraphStyle: paragraphStyle]
        
        if let kern = kern {
            attributes[.kern] = kern
        }
        
        nsAttributedString.addAttributes(
            attributes,
            range: NSRange(location: 0, length: text.count)
        )
        
        self.attributedText = nsAttributedString
    }
    
    func setTextColor(after startText: String, textColor: UIColor) {
        
        guard let text = self.text else { return }

        let nsAttributedString: NSMutableAttributedString
        if let attributedText {
            nsAttributedString = NSMutableAttributedString(attributedString: attributedText)
        } else {
            nsAttributedString = NSMutableAttributedString(string: text)
        }
        
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: textColor]
        nsAttributedString.addAttributes(
            attributes,
            range: NSRange(
                location: startText.count,
                length: text.count - startText.count)
        )
        
        self.attributedText = nsAttributedString
    }
    
    func setTextFont(
        after startText: String,
        font: UIFont,
        kern: Double? = nil,
        heightMultiple: Double = 1.0) {
            
            guard let text = self.text else { return }
            
            let nsAttributedString = NSMutableAttributedString(string: text)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = heightMultiple
            
            var attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: paragraphStyle,
                .font: font
            ]
            
            if let kern = kern {
                attributes[.kern] = kern
            }
            
            nsAttributedString.addAttributes(
                attributes,
                range: NSRange(
                    location: startText.count,
                    length: text.count - startText.count)
            )
            
            self.attributedText = nsAttributedString
        }
}
