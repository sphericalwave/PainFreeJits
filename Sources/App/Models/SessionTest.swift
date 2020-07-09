//
//  SessionTest.swift
//  App
//
//  Created by Aaron Anthony on 2020-07-09.
//

import Vapor

struct User {
    var email: String
}

extension User: SessionAuthenticatable {
    var sessionID: String {
        self.email
    }
}

struct UserSessionAuthenticator: SessionAuthenticator {
    typealias User = App.User
    func authenticate(sessionID: String, for request: Request) -> EventLoopFuture<Void> {
        print("UserSessionAuthenticator: sessionID \(sessionID)")
        let user = User(email: sessionID)
        request.auth.login(user)
        return request.eventLoop.makeSucceededFuture(())
    }
}

struct UserBearerAuthenticator: BearerAuthenticator {
    func authenticate(bearer: BearerAuthorization, for request: Request) -> EventLoopFuture<Void> {
        print("UserBearerAuthenticator: bearer token \(bearer.token)")
        if bearer.token == "test" {
            let user = User(email: "hello@vapor.codes")
            request.auth.login(user)
        }
        return request.eventLoop.makeSucceededFuture(())
    }
}
