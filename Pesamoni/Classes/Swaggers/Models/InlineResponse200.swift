//
// InlineResponse200.swift
//

import Foundation


public class InlineResponse200: JSONEncodable {
    public var status: String?
    public var token: String?
    public var description: String?
    public var mobile: String?
    public var statuscode: String?
    public var transactionType: String?

    public init() {}

    // MARK: JSONEncodable
    func encodeToJSON() -> AnyObject {
        var nillableDictionary = [String:AnyObject?]()
        nillableDictionary["status"] = self.status
        nillableDictionary["token"] = self.token
        nillableDictionary["description"] = self.description
        nillableDictionary["mobile"] = self.mobile
        nillableDictionary["statuscode"] = self.statuscode
        nillableDictionary["transaction_type"] = self.transactionType
        let dictionary: [String:AnyObject] = APIHelper.rejectNil(nillableDictionary) ?? [:]
        return dictionary
    }
}
