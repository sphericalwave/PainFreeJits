//
//  Question2.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-02.
//

import Fluent
import Vapor

class DemographicPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("demographics", use: webpage(req:))
        routes.post("demographics", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("demographicsPg")
    }
    
    func nextPg(req: Request) -> Response {
        print("DemographicPg: \(req.description)")
        let testForm = try! req.content.decode(Demographic.self)
        print(testForm.print())
        return req.redirect(to: "/email")
    }
}

struct Demographic: Content
{
    var gender: String
    var age: String
    
    func print() -> String {
        return "Rank: " + gender + " " + age
    }
}
