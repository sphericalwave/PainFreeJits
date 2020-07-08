//
//  LandingPg.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-03.
//

import Foundation
import Vapor
import Fluent

class LandingPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("", use: webpage(req:))
        routes.post("", use: startSurvey(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
//        if let name = req.session.data["name"] {
//            print("Hello \(name)")
//            //Fetch User with Session ID
//        }
//        else {
//            print("Hi what's your name?")
//            req.session.data["name"] = "Chewbacca"
//            //Create User with sessionID
//        }
        if let customer = req.auth.get(Customer.self) {
            req.session.authenticate(customer)
        }
        else {
            let newGuy = Customer()
            newGuy.givenName = "Elon"
            let e = newGuy.create(on: req.db)
            //req.session.authenticate(e)
        }
        
        return req.view.render("landingPg")
    }
    
    func startSurvey(req: Request) -> Response {
        print("LandingPg: \(req.headers.description)")
        return req.redirect(to: "/rank")
    }
    
//    func login(req: Request) throws -> Response {
//        guard let customer = req.auth.get(Customer.self) else {
//            throw Abort(.unauthorized)
//        }
//        req.session.authenticate(customer)
//    }
}
