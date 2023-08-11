
import UIKit

extension String {
    
    func specialPriceAttributedStringWith(_ color: UIColor) -> NSMutableAttributedString {
        let attributes = [NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int),
                          .foregroundColor: color, .font: fontForPrice()]
        return NSMutableAttributedString(attributedString: NSAttributedString(string: self, attributes: attributes))
    }
    
    func priceAttributedStringWith(_ color: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: color, .font: fontForPrice()]
        
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    func priceAttributedString(_ color: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    fileprivate func fontForPrice() -> UIFont {
        return UIFont(name: "Helvetica-Neue", size: 13) ?? UIFont()
    }
    
    var replaceSpecialCharacter: String {
        return self.replacingOccurrences(of: "%20", with: " ").replacingOccurrences(of: "%2C", with: ",").replacingOccurrences(of: "%27", with: "'").replacingOccurrences(of: "%26", with: "&").replacingOccurrences(of: "%0A", with: "\n").replacingOccurrences(of: "%7C", with: "|").replacingOccurrences(of: "%3A", with: ":").replacingOccurrences(of: "%09", with: "\t").replacingOccurrences(of: "%28", with: "(").replacingOccurrences(of: "%29", with: ")")
    }
}

