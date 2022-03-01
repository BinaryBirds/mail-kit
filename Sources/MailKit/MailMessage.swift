//
//  MailMessage.swift
//  MailKit
//
//  Created by Tibor Bodecs on 2022. 02. 28..
//

import Foundation

public struct MailMessage: Codable {

    public struct Content: Codable {
        
        public enum Format: Codable {
            case text
            case html
        }
        
        public let value: String
        public let type: Format

        public init(value: String, type: Format = .text) {
            self.type = type
            self.value = value
        }
    }

    public let from: String
    public let to: [String]
    public let replyTo: [String]?
    public let cc: [String]?
    public let bcc: [String]?
    public let subject: String
    public let content: Content
    
    public init(from: String,
                to: [String],
                replyTo: [String]? = nil,
                cc: [String]? = nil,
                bcc: [String]? = nil,
                subject: String,
                content: Content) {
        self.from = from
        self.to = to
        self.replyTo = replyTo
        self.cc = cc
        self.bcc = bcc
        self.subject = subject
        self.content = content
    }
}
