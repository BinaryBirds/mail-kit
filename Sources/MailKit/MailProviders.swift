//
//  MailProviders.swift
//  MailKit
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

import class NIOConcurrencyHelpers.Lock

public final class MailProviders {
    
    // MARK: - private
    
    /// identifier of the default driver
    private var defaultID: MailProviderID?
    
    /// identifiers and configuration pairs
    private var configurations: [MailProviderID: MailProviderConfiguration]

    /// Running drivers, access to this variable must be synchronized.
    private var drivers: [MailProviderID: MailProviderDriver]

    /// Lock, to synchronize access across threads.
    private var lock: Lock
    
    /// returns an existing configuration for an identifier otherwise call results in a fatal error
    private func requireConfiguration(for id: MailProviderID) -> MailProviderConfiguration {
        guard let configuration = configurations[id] else {
            fatalError("No mail provider configuration registered for \(id).")
        }
        return configuration
    }

    /// returns the existing identifier, otherwise call results in a fatal error
    private func requireDefaultID() -> MailProviderID {
        guard let id = defaultID else {
            fatalError("No default mail provider configured.")
        }
        return id
    }
    
    // MARK: - public api
    
    public func ids() -> Set<MailProviderID> {
        return self.lock.withLock { Set(self.configurations.keys) }
    }
    
    /// init a mail providers object
    public init() {
        self.configurations = [:]
        self.drivers = [:]
        self.lock = .init()
    }
    
    /// register a configuration using a factory object with a provider id, optionally mark as default driver configuration
    public func use(_ factory: MailProviderConfigurationFactory, as id: MailProviderID, isDefault: Bool? = nil) {
        use(factory.make(), as: id, isDefault: isDefault)
    }
    
    /// use a configuration with a provider id, optionally mark as default configuration
    public func use(_ config: MailProviderConfiguration, as id: MailProviderID, isDefault: Bool? = nil) {
        lock.lock()
        defer { lock.unlock() }
        configurations[id] = config
        if isDefault == true || (defaultID == nil && isDefault != false) {
            defaultID = id
        }
    }

    /// returns the default provider for a given identifier
    public func `default`(to id: MailProviderID) {
        lock.lock()
        defer { lock.unlock() }
        defaultID = id
    }
    
    /// returns the configuration for a given identifier
    public func configuration(for id: MailProviderID? = nil) -> MailProviderConfiguration? {
        lock.lock()
        defer { lock.unlock() }
        return configurations[id ?? requireDefaultID()]
    }
    
    /// returns a provider for a given identifier using a logger and an event loop object
    public func provider(_ id: MailProviderID? = nil, logger: Logger, on eventLoop: EventLoop) -> MailProvider? {
        lock.lock()
        defer { lock.unlock() }
        let id = id ?? requireDefaultID()
        var logger = logger
        logger[metadataKey: "mail-provider-id"] = .string(id.string)
        let configuration = requireConfiguration(for: id)
        let context = MailProviderContext(
            configuration: configuration,
            logger: logger,
            eventLoop: eventLoop
        )
        let driver: MailProviderDriver
        if let existing = drivers[id] {
            driver = existing
        }
        else {
            let new = configuration.makeDriver(for: self)
            drivers[id] = new
            driver = new
        }
        return driver.makeProvider(with: context)
    }

    /// reinitialize a driver for a given identifier
    public func reinitialize(_ id: MailProviderID? = nil) {
        lock.lock()
        defer { lock.unlock() }
        let id = id ?? requireDefaultID()
        if let driver = drivers[id] {
            drivers[id] = nil
            driver.shutdown()
        }
    }

    /// shuts down all the initialized drivers
    public func shutdown() {
        lock.lock()
        defer { lock.unlock() }
        for driver in drivers.values {
            driver.shutdown()
        }
        drivers = [:]
    }

}
