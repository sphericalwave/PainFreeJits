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
        static var givenName: FieldKey { "givenName" }
        static var familyName: FieldKey { "familyName" }
        static var email: FieldKey { "email" }
        static var belt: FieldKey { "belt" }
        static var stripes: FieldKey { "stripes" }
        static var painfulJoints: FieldKey { "painfulJoints" }
        static var gender: FieldKey { "gender" }
        static var birthDate: FieldKey { "birthDate" }
    }

    //FIXME: That's a lot of optionals
    @ID() var id: UUID?
    @Field(key: "givenName") var givenName: String?
    @Field(key: "familyName") var familyName: String?
    @Field(key: "email") var email: String?
    @Field(key: "belt") var belt: String?
    @Field(key: "stripes") var stripes: String?
    @Field(key: "painfulJoints") var painfulJoints: String?
    @Field(key: "gender") var gender: Bool?
    @Field(key: "birthDate") var birthDate: Date?

    init() { }
}

extension Customer: SessionAuthenticatable {
    typealias SessionID = UUID
    var sessionID: SessionID { self.id! }
}

extension Customer: Authenticatable { }
