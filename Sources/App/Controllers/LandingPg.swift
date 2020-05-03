//
//  LandingPg.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-03.
//

import Foundation
//import Fluent
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
    
    func startSurvey(req: Request) -> HTTPStatus {
        //print("Persist Answer to Session")
        //fatalError()
        print("postAnswer: \(req.headers.description)")
        return .ok
    }
}
