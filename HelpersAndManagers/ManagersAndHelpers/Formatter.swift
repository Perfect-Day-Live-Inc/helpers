//
//  Formatter.swift
//  
//
//  Created by MacBook Retina on 10/25/17.
//  Copyright © 2017 Appiskey. All rights reserved.
//

import Foundation
import Swift

//MARK: Time Cases
///This enum is use to check or convert time format from 12hrs to 24hrs or 24hrs to 12hrs
public enum timeFormat : String{
    case Hrs12 = "en_US"
    case Hrs24 = "en_GB"
}

///this class contains time formats which are use in whole application
open class Formatter{
    
    public enum DateFormatsForApp : String{
        case dateFormattor = "d MMM yyyy"
        case fullDateComaAndTime = "d MMM yyyy, hh:mm a"
        case dateFormattorWithComma = "d MMM, yyyy"
        case onlyDateFormattor = "yyyy-MM-dd"
        case utcDateTimeFormattor = "yyyy-MM-dd HH:mm:ss"
        case onlyTimeWithSecond = "HH:mm:ss"
        case TimeFormattor12Hrs = "hh:mm a"
        case TimeFormattor24Hrs = "HH:mm"
        case dateTimeFormatterWithoutDay = "d MMM, HH:mm"
        case dateTimeFormatterWithDay = "EEEE, MMM d, yyyy"
        case monthThenDayThenYear = "MMM d, yyyy"
        case onlyYearAndMonthFirstYear = "yyyy-MM"
        case onlyYearAndMonthFirstMonth = "MMMM yyyy"
        case monthThenDayThenYearAndTime = "MMM d, yyyy | hh:mm a"
        case dayOfWeek = "EEEE"
    }
    
    private var appTimeFormat : timeFormat = .Hrs24

    private init() {}
    static public let getInstance = Formatter()

    ///this function change the whole app time format as 24 hrs or 12 hrs
    /// - Parameter format: timeformat
    public func changeAppTimeFormat(format : timeFormat){
        appTimeFormat = format
    }
    
    ///this function can get the whole app time format as 24 hrs or 12 hrs
    /// - Parameter format: timeformat
    public func getAppTimeFormat() -> timeFormat{
        return appTimeFormat
    }
    
    ///this function returns time format "14:15:20"
    /// - Returns: Date Formatter
    public func getOnlyTimeWithSecond() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.onlyTimeWithSecond.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format "10 Sept 2020, 11:10 am"
    /// - Returns: Date Formatter
    public func getfullDateComaAndTime() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.fullDateComaAndTime.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format "2019-09"
    /// - Returns: Date Formatter
    public func onlyYearAndMonthFirstYear() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.onlyYearAndMonthFirstYear.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format "September 2013"
    /// - Returns: Date Formatter
    public func onlyYearAndMonthFirstMonth() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.onlyYearAndMonthFirstMonth.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format "2019-10-10 13:15:20"
    /// - Returns: Date Formatter
    public func getUTCDateTimeFormattor() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.utcDateTimeFormattor.rawValue
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }
    
    ///this function returns time format "2019-10-10"
    /// - Returns: Date Formatter
    public func getOnlyDateFormattor() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.onlyDateFormattor.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format "May 10, 1996"
    /// - Returns: Date Formatter
    public func monthThenDayThenYear() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.monthThenDayThenYear.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format "May"
    /// - Returns: Date Formatter
    public func getDayOfWeek() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.dayOfWeek.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format "Jun 10, 2019 | 15:15 am"
    /// - Returns: Date Formatter
    public func monthThenDayThenYearAndTime() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.monthThenDayThenYearAndTime.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format "Monday, May 13, 2019"
    /// - Returns: Date Formatter
    public func dateTimeFormatterWithDay() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.dateTimeFormatterWithDay.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format in only 12hrs format
    /// - Returns: Date Formatter
    public func get12HrsTimeFormattor() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.TimeFormattor12Hrs.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format in only 24hrs format
    /// - Returns: Date Formatter
    public func get24HrsTimeFormattor() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.TimeFormattor24Hrs.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format "10 May 2019"
    /// - Returns: Date Formatter
    public func getAppDateFormattor() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.dateFormattor.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns Date Format with comma style e.g: 22, Jan, 2018
    /// - Returns: Date Formatter
    public func getAppDateFormattorWithComma() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.dateFormattorWithComma.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    ///this function returns time format "10 Sept, 17:15"
    /// - Returns: Date Formatter
    public func dateTimeFormatterWithoutDay() -> DateFormatter{
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatsForApp.dateTimeFormatterWithoutDay.rawValue
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    /**
     this function convert date to time
     - Parameter date: Date to convert.
     - Returns: Date in String
     */
    public func convertDateToTime(date: Date) -> String{
        if self.appTimeFormat == .Hrs12{
            let time = get12HrsTimeFormattor().string(from: date)
            return time
        }else{
            let time = get24HrsTimeFormattor().string(from: date)
            return time
        }
    }
    
    /**
     get 12Hrs time from any date
     - Parameter date: Date to convert.
     - Returns: Date in 12Hrs Format.
     */
    static public func get12HrsTime(from date: Date) -> String{
        let time = Formatter().get12HrsTimeFormattor().string(from: date)
        return time
    }
    
    
    /**
     get 24Hrs time from any date
     - Parameter date: Date to convert.
     - Returns: Date in 24Hrs Format.
     */
    static public func get24HrsTime(from date: Date) -> String{
        let time = Formatter().get24HrsTimeFormattor().string(from: date)
        return time
    }
    
    /**
     convert string to given date
     - Parameter format: enum type DateFormatsForApp for date format
     - Parameter stringToConvert: string To Convert into date
     - Parameter isUTC: is date is in UTC format
     - Returns: return converted date, it may contains nil value.
     */
    static public func convertStringToDate(format: DateFormatsForApp, stringToConvert: String, isUTC: Bool=false) -> Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        if isUTC{
            formatter.timeZone = TimeZone(abbreviation: "UTC")
        }else{
            formatter.timeZone = TimeZone.current
        }
        if let date = formatter.date(from: stringToConvert){
            return date
        }else{
            return nil
        }
    }
    
    
    /**
     convert date to string
     - Parameter format: enum type DateFormatsForApp for date format
     - Parameter dateToConvert: date To Convert into string
     - Parameter isUTC: is date is in UTC format
     - Returns: return converted string.
     */
    static public func convertDateToString(format: DateFormatsForApp, dateToConvert: Date, isUTC: Bool=false) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        if isUTC{
            formatter.timeZone = TimeZone(abbreviation: "UTC")
        }else{
            formatter.timeZone = TimeZone.current
        }
        return formatter.string(from: dateToConvert)
    }
    
    /**
     convert string of date to string which will viewable on screen
     - Parameter format: enum type DateFormatsForApp for date format
     - Parameter formatToShow: enum type DateFormatsForApp for date format which will viewable on screen
     - Parameter stringToConvert: string To Convert into viewable date string
     - Parameter isUTC: is date is in UTC format
     - Returns: return converted string, it may contains nil value.
     */
    static public func convertStringToViewableString(format: DateFormatsForApp, formatToShow: DateFormatsForApp, stringToConvert: String, isUTC: Bool=false) -> String?{
        if let date = Formatter.convertStringToDate(format: format, stringToConvert: stringToConvert, isUTC: isUTC){
            let formatter = DateFormatter()
            formatter.dateFormat = formatToShow.rawValue
            formatter.timeZone = TimeZone.current
            let strDate = formatter.string(from: date)
            return strDate
        }else{
            return nil
        }
    }
    
    /**
     get string date to viewable string for app with timeago
     - Parameter string: string to convert viewable string
     - Parameter showableFormat: enum type DateFormatsForApp for date format which will viewable on screen
     - Returns: return converted string, it may contains nil value.
     */
    static public func getDateToShowableFormatWithTimeAgo(string: String, showableFormat: DateFormatsForApp) -> String?{
        
        if let date = Formatter.convertStringToDate(format: Formatter.DateFormatsForApp.utcDateTimeFormattor,
                                                    stringToConvert: string, isUTC: true){
            let dateToShow = Formatter.convertStringToViewableString(format: Formatter.DateFormatsForApp.utcDateTimeFormattor,
                                                                     formatToShow: showableFormat,
                                                                     stringToConvert: string) ?? ""
            let timeAgo = Formatter.timeAgoSinceDate(date: date,
                                                     currentDate: Date(), numericDates: false)
            return dateToShow + ", " + timeAgo
        }
        return nil
    }
    
    ///this function return timesAgo from date
    static public func timeAgoSinceDate(date:Date,currentDate:Date, numericDates:Bool) -> String {
        let now = currentDate
        let earliest = (now as NSDate).earlierDate(date)
        let latest = (earliest == now) ? date : now
        var components:DateComponents = Calendar.current.dateComponents([.day, .weekOfYear, .month, .hour, .minute, .second, .year], from: earliest, to: latest)
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 year ago"
            } else {
                return "Last year"
            }
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            if (numericDates){
                return "1 month ago"
            } else {
                return "Last month"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 minute ago"
            } else {
                return "A minute ago"
            }
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
        
    }
    
}

///Contains custom variable to get startOfDay
extension Date{
    
    ///it will contain start of day of Date
    public var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
}
