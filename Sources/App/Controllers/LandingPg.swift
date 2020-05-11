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
        routes.get("", use: webpage(req:))
        routes.post("", use: startSurvey(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        //if vapor-session matches customer say welcome back
        //else create Customer with Vapor Session and say welcome to PainFree Jiujitsu
        if let session = req.cookies["vapor-session"] {
            //locate customer name using session
            let name = req.session.data["name"] ?? "unknown"
            print("welcome back \(name)")
        }
        else {
            print("Hi what's your name?")
            req.session.data["name"] = "Chewbacca"
        }
        return req.view.render("landingPg")
    }
    
    func startSurvey(req: Request) -> Response {
        print("LandingPg: \(req.headers.description)")
        return req.redirect(to: "/rank")
    }
}
