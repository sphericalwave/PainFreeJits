//
//  Question1Pg.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-03.
//

import Fluent
import Vapor

class JointQPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("joints", use: webpage(req:))
        routes.post("joints", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("jointsQPg")
    }
    
    func nextPg(req: Request) -> Response {
        print("LandingPg: \(req.headers.description)")
        return req.redirect(to: "/demographics")
    }
}
