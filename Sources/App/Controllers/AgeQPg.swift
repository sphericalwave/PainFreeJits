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
        print("\n\n \(req.body.string ?? "no string")\n\n")
        let age = try! req.content.decode(Age.self)
        //print(testForm.print())

        req.session.data["birthdate"] = age.bday
        print(req.session.data)

        return req.redirect(to: "/email")
    }
    
    struct Age: Content
    {
        var bday: String
        //func print() -> String { return "Age: " + age }
    }
}


