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
        print(joint.print2())
        
        let joints = try! req.content.decode(Joint.self)
        do {
            let customer = try req.auth.require(Customer.self)
            customer.painfulJoints = joints.toes ?? "FIXME"
            
            customer.save(on: req.db)
                .map{ return req.redirect(to: "/demographics") }
        }
        catch {
            let customer = Customer()
            customer.painfulJoints = joints.toes ?? "FIXME"
            customer.save(on: req.db)
                .map{ return req.redirect(to: "/demographics") }
        }
        return req.redirect(to: "/demographics")
    }
    
    struct Joint: Content
    {
        //TODO: Complete
        var toes: String?
        var ankles: String?
        var knees: String?
        
        func print2() -> String {
            let ts = toes ?? "no toes"
            let ank = ankles ?? "no ankles"
            if let kn = knees {
                print("knees")
            }

            return "Joint: " + ts + ank
        }
    }
}


