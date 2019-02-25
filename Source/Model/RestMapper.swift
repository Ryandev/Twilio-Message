
/**
 @package Twilio Message
 @author Ryan Powell
 @license MIT
 */

import Foundation

protocol RestInMapper {
    func update(dictionary: [AnyHashable:AnyObject])
}

protocol RestOutMapper {
    func serialize() -> [AnyHashable:AnyObject]
}

protocol ValueMapper {
    associatedtype Value = Self
    
    static func mapValue(from object: Any) throws -> Value
}

extension Dictionary {
    func jsonMap<A: ValueMapper>(_ k: Key) -> A? {
        let any = self[k]
        guard let val = any else { return nil }
        let returnValue: A?? = try? A.mapValue(from: val) as? A
        return returnValue != nil ? returnValue! : nil
    }
}

enum ValueMapperError: Error {
    case typeMismatch
}

extension String: ValueMapper {
    public static func mapValue(from object: Any) throws -> String {
        guard let value = object as? String else {
            throw ValueMapperError.typeMismatch
        }
        return value
    }
}

extension Int: ValueMapper {
    public static func mapValue(from object: Any) throws -> Int {
        guard let value = object as? NSNumber else {
            throw ValueMapperError.typeMismatch
        }
        return value.intValue
    }
}

extension Float: ValueMapper {
    public static func mapValue(from object: Any) throws -> Float {
        guard let value = object as? NSNumber else {
            throw ValueMapperError.typeMismatch
        }
        return value.floatValue
    }
}

extension Date: ValueMapper {
    public static func mapValue(from object: Any) throws -> Date {
        guard let value = object as? String else {
            throw ValueMapperError.typeMismatch
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let date = dateFormatter.date(from: value) ?? Date()

        return date
    }
    
    func restoreValue() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
        let dateStr = dateFormatter.string(from: self)
        return dateStr
    }
}
