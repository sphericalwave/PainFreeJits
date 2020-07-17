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
        //print("\n\n \(req.description)\n\n")
        //print("\n\n \(req.content)\n\n")
        print("\n\n \(req.body.string ?? "no string")\n\n")

        let joints = try! req.content.decode(Joints.self)
        req.session.data["primary"] = joints.primary
        req.session.data["secondary"] = joints.secondary
        req.session.data["tertiary"] = joints.tertiary
        return req.redirect(to: "/demographics")
    }
    
    struct Joints: Content
    {
        var primary: String
        var secondary: String
        var tertiary: String
    }
}


