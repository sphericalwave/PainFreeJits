//
//  CustomerMigration1.swift
//  App
//
//  Created by Aaron Anthony on 2020-06-26.
//

import Fluent
import Vapor

struct CustomerMigration1: Migration
{
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([
        database.schema(Customer.schema)
            .id()
            .field(Customer.FieldKeys.name, .string, .required)
            .field(Customer.FieldKeys.email, .string, .required)
            .unique(on: Customer.FieldKeys.email)
            .create()
        ])
        .flatMap { self.users().create(on: database) }
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([database.schema(Customer.schema).delete()])
    }
    
    private func users() -> [Customer] {
        return [ Customer(name: "Aaron", email: "aaron@random.com") ]
    }
}
