//
//  MailProviderID.swift
//  MailKit
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

public struct MailProviderID: Hashable, Codable {
    
    /// string representation of the identifier
    public let string: String
    
    /// init identifier using a string 
    public init(string: String) {
        self.string = string
    }
}
