//
//  MailProvider.swift
//  MailKit
//
//  Created by Tibor Bodecs on 2020. 04. 28..
//

public protocol MailProvider {

    var context: MailProviderContext { get }

    func send(_ message: MailMessage) async throws -> String

}
