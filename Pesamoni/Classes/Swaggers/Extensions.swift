// Extensions.swift
//


import Alamofire

extension Bool: JSONEncodable {
    func encodeToJSON() -> AnyObject { return self }
}

extension Float: JSONEncodable {
    func encodeToJSON() -> AnyObject { return self }
}

extension Int: JSONEncodable {
    func encodeToJSON() -> AnyObject { return self }
}

extension Int32: JSONEncodable {
    func encodeToJSON() -> AnyObject { return NSNumber(int: self) }
}

extension Int64: JSONEncodable {
    func encodeToJSON() -> AnyObject { return NSNumber(longLong: self) }
}

extension Double: JSONEncodable {
    func encodeToJSON() -> AnyObject { return self }
}

extension String: JSONEncodable {
    func encodeToJSON() -> AnyObject { return self }
}

private func encodeIfPossible<T>(object: T) -> AnyObject {
    if object is JSONEncodable {
        return (object as! JSONEncodable).encodeToJSON()
    } else {
        return object as! AnyObject
    }
}

extension Array: JSONEncodable {
    func encodeToJSON() -> AnyObject {
        return self.map(encodeIfPossible)
    }
}

extension Dictionary: JSONEncodable {
    func encodeToJSON() -> AnyObject {
        var dictionary = [NSObject:AnyObject]()
        for (key, value) in self {
            dictionary[key as! NSObject] = encodeIfPossible(value)
        }
        return dictionary
    }
}

extension NSData: JSONEncodable {
    func encodeToJSON() -> AnyObject {
        return self.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
    }
}

private let dateFormatter: NSDateFormatter = {
    let fmt = NSDateFormatter()
    fmt.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    fmt.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    return fmt
}()

extension NSDate: JSONEncodable {
    func encodeToJSON() -> AnyObject {
        return dateFormatter.stringFromDate(self)
    }
}

extension NSUUID: JSONEncodable {
    func encodeToJSON() -> AnyObject {
        return self.UUIDString
    }
}

/// Represents an ISO-8601 full-date (RFC-3339).
/// ex: 12-31-1999
/// https://xml2rfc.tools.ietf.org/public/rfc/html/rfc3339.html#anchor14
public final class ISOFullDate: CustomStringConvertible {

    public let year: Int
    public let month: Int
    public let day: Int

    public init(year year: Int, month: Int, day: Int) {
        self.year = year
        self.month = month
        self.day = day
    }

    /**
     Converts an NSDate to an ISOFullDate. Only interested in the year, month, day components.

     - parameter date: The date to convert.

     - returns: An ISOFullDate constructed from the year, month, day of the date.
     */
    public static func from(date date: NSDate) -> ISOFullDate? {
        guard let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian) else {
            return nil
        }

        let components = calendar.components(
            [
                .Year,
                .Month,
                .Day,
            ],
            fromDate: date
        )
        return ISOFullDate(
            year: components.year,
            month: components.month,
            day: components.day
        )
    }

    /**
     Converts a ISO-8601 full-date string to an ISOFullDate.

     - parameter string: The ISO-8601 full-date format string to convert.

     - returns: An ISOFullDate constructed from the string.
     */
    public static func from(string string: String) -> ISOFullDate? {
        let components = string
            .characters
            .split("-")
            .map(String.init)
            .flatMap { Int($0) }
        guard components.count == 3 else { return nil }

        return ISOFullDate(
            year: components[0],
            month: components[1],
            day: components[2]
        )
    }

    /**
     Converts the receiver to an NSDate, in the default time zone.

     - returns: An NSDate from the components of the receiver, in the default time zone.
     */
    public func toDate() -> NSDate? {
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.timeZone = NSTimeZone.defaultTimeZone()
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        return calendar?.dateFromComponents(components)
    }

    // MARK: CustomStringConvertible

    public var description: String {
        return "\(year)-\(month)-\(day)"
    }

}

extension ISOFullDate: JSONEncodable {
    public func encodeToJSON() -> AnyObject {
        return "\(year)-\(month)-\(day)"
    }
}


