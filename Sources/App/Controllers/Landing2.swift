//
//  Landing2.swift
//  App
//
//  Created by Aaron Anthony on 2020-07-22.
//

import Foundation
import Vapor
import Fluent

class Landing2: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("landing2", use: webpage(req:))
        routes.post("landing2", use: startSurvey(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("landing2")
    }
    
    func startSurvey(req: Request) -> Response {
        print("LandingPg: \(req.headers.description)")
        return req.redirect(to: "/dd")
    }
}
