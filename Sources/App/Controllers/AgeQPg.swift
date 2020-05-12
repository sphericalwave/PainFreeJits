//
//  AgeQPg.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-12.
//

import Fluent
import Vapor

class AgeQPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("age", use: webpage(req:))
        routes.post("age", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("ageQPg")
    }
    
    func nextPg(req: Request) -> Response {
        print("AgeQPg: \(req.description)")
        let testForm = try! req.content.decode(Age.self)
        print(testForm.print())
        return req.redirect(to: "/email")
    }
}

struct Age: Content
{
    var age: String
    func print() -> String { return "Age: " + age }
}
