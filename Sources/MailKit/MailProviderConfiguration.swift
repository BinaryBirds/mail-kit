//
//  MailProviderConfiguration.swift
//  MailKit
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

/// configuration protocol
public protocol MailProviderConfiguration {

    /// creates a new driver using the providers object, driver will be stored in that storage
    func makeDriver(for: MailProviders) -> MailProviderDriver
}
