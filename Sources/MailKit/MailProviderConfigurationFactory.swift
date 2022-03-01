//
//  MailProviderConfigurationFactory.swift
//  MailKit
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

/// configuration factory
public struct MailProviderConfigurationFactory {

    /// creates a new fs configuration object
    public let make: () -> MailProviderConfiguration

    /// init the fs factory with a make block
    public init(make: @escaping () -> MailProviderConfiguration) {
        self.make = make
    }
}
