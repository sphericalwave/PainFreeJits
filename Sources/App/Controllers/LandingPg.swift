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
        if let customer = req.auth.get(Customer.self) {
            req.session.authenticate(customer)  //save userId into current session storage
        }
        else {
            let newGuy = Customer()
            newGuy.givenName = "Elon"
            req.session.data["name"] = newGuy.givenName //create session
            _ = newGuy.create(on: req.db).map{
                Customer.query(on: req.db)
                    .filter(\.$givenName == newGuy.givenName)
                    .first()
                    .map {
                        if let cust = $0 {
                            req.session.authenticate(cust)
                        }
                    }
            }            
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
