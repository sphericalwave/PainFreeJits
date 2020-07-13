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
            .field(Customer.FieldKeys.givenName, .string)
            .field(Customer.FieldKeys.familyName, .string)
            .field(Customer.FieldKeys.email, .string)
            .field(Customer.FieldKeys.belt, .string)
            .field(Customer.FieldKeys.stripes, .string)
            .field(Customer.FieldKeys.painfulJoints, .string) //.array(of: .string))
            .field(Customer.FieldKeys.gender, .bool)
            .field(Customer.FieldKeys.birthDate, .date)
            .unique(on: Customer.FieldKeys.email)
            .create()
        ])
        .flatMap { self.users().create(on: database) }
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.eventLoop.flatten([database.schema(Customer.schema).delete()])
    }
    
    private func users() -> [Customer] {
        let aaron = Customer()
        aaron.givenName = "Aaron"
        aaron.familyName = "Mcgrath"
        aaron.email = "aaron@sphericalwave.com"
        aaron.belt = "blue"
        aaron.stripes = "2"
        aaron.painfulJoints = "left hip" //= ["left hip", "left shoulder", "right elbow"]
        aaron.gender = true
        aaron.birthDate = Date()
        return [ aaron ]
    }
}
