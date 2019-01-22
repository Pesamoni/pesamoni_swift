// APIHelper.swift
//

class APIHelper {
    static func rejectNil(source: [String:AnyObject?]) -> [String:AnyObject]? {
        var destination = [String:AnyObject]()
        for (key, nillableValue) in source {
            if let value: AnyObject = nillableValue {
                destination[key] = value
            }
        }

        if destination.isEmpty {
            return nil
        }
        return destination
    }

    static func rejectNilHeaders(source: [String:AnyObject?]) -> [String:String] {
        var destination = [String:String]()
        for (key, nillableValue) in source {
            if let value: AnyObject = nillableValue {
                destination[key] = "\(value)"
            }
        }
        return destination
    }

    static func convertBoolToString(source: [String: AnyObject]?) -> [String:AnyObject]? {
        guard let source = source else {
            return nil
        }
        var destination = [String:AnyObject]()
        let theTrue = NSNumber(bool: true)
        let theFalse = NSNumber(bool: false)
        for (key, value) in source {
            switch value {
            case let x where x === theTrue || x === theFalse:
                destination[key] = "\(value as! Bool)"
            default:
                destination[key] = value
            }
        }
        return destination
    }

}
