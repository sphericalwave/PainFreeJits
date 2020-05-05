//
//  EmailPg.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-05.
//

import Fluent
import Vapor

class EmailPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("email", use: webpage(req:))
        routes.post("email", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("emailPg")
    }
    
    func nextPg(req: Request) -> Response {
        return req.redirect(to: "/landingPg")
    }
}
