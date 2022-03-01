//
//  MailProviderContext.swift
//  MailKit
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

public struct MailProviderContext {
    
    /// configuration
    public let configuration: MailProviderConfiguration
    
    /// logger
    public let logger: Logger
    
    /// event loop
    public let eventLoop: EventLoop
    
    /// public init method
    public init(configuration: MailProviderConfiguration,
                logger: Logger,
                eventLoop: EventLoop) {
        self.configuration = configuration
        self.logger = logger
        self.eventLoop = eventLoop
    }
}

