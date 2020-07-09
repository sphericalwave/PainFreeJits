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
//        if req.hasSession {
//            print("has session")
//            if let c = req.session.authenticated(Customer.self) {
//                print("customer: \(c.)")
            //Customer
//            if let c = req.auth.get(Customer.self) {
//                print("customer: \(c.description)")
//            }
            
//            if let c = req.session. {
//                print("customer: \(c.description)")
//            }
//        }
//        else {
//            //create session..already exists
//            let newGuy = Customer()
//            newGuy.givenName = "Elon"
//            _ = newGuy.create(on: req.db).map{
//                req.session.authenticate(newGuy)
//            }
//            let c = Customer
//            let newSession = req.session.authenticate(<#T##a: SessionAuthenticatable##SessionAuthenticatable#>)
            //associate a customer
        //}
        return req.view.render("landingPg")
    }
    
    func startSurvey(req: Request) -> Response {
        print("LandingPg: \(req.headers.description)")
        return req.redirect(to: "/rank")
    }
}
