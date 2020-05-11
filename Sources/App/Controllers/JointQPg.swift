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
        print("Joint Page: \(req.description)")
        let joint = try! req.content.decode(Joint.self)
        print(joint.print())
        return req.redirect(to: "/demographics")
    }
}

struct Joint: Content
{
    var joint: String
    
    func print() -> String {
        return "Joint: " + joint
    }
}
