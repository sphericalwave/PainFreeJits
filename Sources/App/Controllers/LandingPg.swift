//
//  LandingPg.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-03.
//

import Foundation
import Vapor

class LandingPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("landingPg", use: webpage(req:))
        routes.post("landingPg", use: startSurvey(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("landingPg")
    }
    
    func startSurvey(req: Request) -> Response {
        print("LandingPg: \(req.headers.description)")
        return req.redirect(to: "/question2")
    }
}
