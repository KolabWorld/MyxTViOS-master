//
//  StringExtension.swift
//  WXRKSTUDY
//
//  Created by Karamjeet Singh on 16/08/22.
//

import Foundation
import UIKit

extension String {
    func datestringToStringDisplay(style: DateFormatter.Style) -> String? {
        //set things up
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_US")
        formatter.timeZone = .current

        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // this is the date format coming in
        //this guards against a String not being in the correct format
        guard let date = formatter.date(from: self) else {
            return nil
        }

        formatter.dateStyle = style // this is the date format going out
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM,dd"
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
    
    
    func returnDate() -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_US")
        formatter.timeZone = .current

        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // this is the date format coming in
        //this guards against a String not being in the correct format
        guard let date = formatter.date(from: self) else {
            return Date()
        }
        return date
    }
    func returnDateWithTime() -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_US")
        formatter.timeZone = .current

        formatter.dateFormat = "yyyy-MM-dd" // this is the date format coming in
        //this guards against a String not being in the correct format
        guard let date = formatter.date(from: self) else {
            return Date()
        }
        return date
    }
    
    func datestringToStringDisplay(fromFotmat: String, toFormat:String, style: DateFormatter.Style) -> String? {
        //set things up
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_US")
        formatter.timeZone = .current

        formatter.dateFormat = fromFotmat // this is the date format coming in
        //this guards against a String not being in the correct format
        guard let date = formatter.date(from: self) else {
            return nil
        }

        formatter.dateStyle = style // this is the date format going out
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = toFormat
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
    
    func datestringToStringDisplaySuffix( style: DateFormatter.Style) -> String? {
        //set things up
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_US")
        formatter.timeZone = .current

        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" // this is the date format coming in
        //this guards against a String not being in the correct format
        guard let date = formatter.date(from: self) else {
            return nil
        }

        formatter.dateStyle = style // this is the date format going out
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM, yyyy 'at' hh:mma"
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
    
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
           var pureNumber = self.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression)
           for index in 0 ..< pattern.count {
               guard index < pureNumber.count else { return pureNumber }
               let stringIndex = String.Index(utf16Offset: index, in: pattern)
               let patternCharacter = pattern[stringIndex]
               guard patternCharacter != replacementCharacter else { continue }
               pureNumber.insert(patternCharacter, at: stringIndex)
           }
           return pureNumber
       }
    
    func isValidEmail() -> Bool {
             // here, `try!` will always succeed because the pattern is valid
             let regex = try! NSRegularExpression(pattern: "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,3})$", options: .caseInsensitive)
           let valid = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
           print("Email validation \(valid)")
             return valid
         }

         // vrify Valid PhoneNumber or Not
         func isValidPhone() -> Bool {

           let regex = try! NSRegularExpression(pattern: "^[0-9]\\d{9}$", options: .caseInsensitive)
           let valid = regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
           print("Mobile validation \(valid)")
             return valid
         }
}


extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    var releaseVersionNumberPretty: String {
        return "v\(releaseVersionNumber ?? "1.0.0")"
    }
}
extension UILabel {
    func setHTMLFromString(htmlText: String) {
        let modifiedFont = String(format:"<span style=\"font-family: 'AquawaxPro-DemiBold'; color:White; font-size: \(11.5)\">%@</span>", htmlText)
        
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        self.attributedText = attrStr
    }
}

extension Date {

    func dateFormatWithSuffix() -> String {
        return "dd'\(self.daySuffix())' MMM, yyyy 'at' hh:MMa"
    }

    func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}

