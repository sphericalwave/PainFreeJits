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
        //if vapor-session matches customer say welcome back
        //else create Customer with Vapor Session and say welcome to PainFree Jiujitsu
        return req.view.render("landingPg")
    }
    
    func startSurvey(req: Request) -> Response {
        print("LandingPg: \(req.headers.description)")
        return req.redirect(to: "/rank")
    }
}

//import Foundation
//import Vapor
//
//class HelloPg: RouteCollection
//{
//    func boot(routes: RoutesBuilder) throws {
//        routes.get("hello", use: webpage(req:))
//    }
//    
//    func webpage(req: Request) -> EventLoopFuture<View> {
//        return req.view.render("helloPg")
//    }
//}
