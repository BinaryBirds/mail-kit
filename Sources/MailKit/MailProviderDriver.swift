//
//  MailProviderDriver.swift
//  MailKit
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

/// MailProviderDriver protocol to create a MailProvider with a given context
public protocol MailProviderDriver {

    /// creates a mail provider object with a given context
    func makeProvider(with context: MailProviderContext) -> MailProvider
    
    /// shuts down the driver
    func shutdown()
}
