//
//  Customer.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-07.
//

import Fluent
import Vapor

//final class Customer: Model, Content {
//    // Name of the table or collection.
//    static let schema = "customers"
//
//    @ID(key: .id) var id: UUID?   //TODO: Be Immutable
//
//    @Field(key: "name") var name: String    //TODO: Be Immutable
//
//    init() { }  //TODO: Disagree
//
//    init(id: UUID? = nil, name: String) {
//        self.id = id
//        self.name = name
//    }
//}
//
//
//struct CustomerMgrt: Migration
//{
//    // Prepares the database for storing Customer models.
//    func prepare(on database: Database) -> EventLoopFuture<Void> {
//        database.schema("customers")
//            .id()
//            .field("name", .string)
//            .create()
//    }
//
//    // Optionally reverts the changes made in the prepare method.
//    func revert(on database: Database) -> EventLoopFuture<Void> {
//        database.schema("customers").delete()
//    }
//}
