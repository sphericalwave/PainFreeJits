//
//  Question1Pg.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-03.
//

import Fluent
import Vapor

class Question1Pg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("question1", use: webpage(req:))
        routes.post("question1", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("question1")
    }
    
    func nextPg(req: Request) -> Response {
        print("LandingPg: \(req.headers.description)")
        return req.redirect(to: "/question2")
    }
}
