//
//  Customer.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-07.
//

import Fluent
import Vapor

final class Customer: Model
{
    static let schema = "customers"
    
    struct FieldKeys {
        static var name: FieldKey { "name" }
        static var email: FieldKey { "email" }
    }

    @ID() var id: UUID?
    @Field(key: "name") var name: String
    @Field(key: "name") var email: String

    init() { }

    init(id: Customer.IDValue? = nil, name: String, email: String ) {
        self.id = id
        self.name = name
        self.email = email
    }
}



