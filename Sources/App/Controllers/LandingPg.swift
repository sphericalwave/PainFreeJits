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
        if req.hasSession {
            //guard let c = req.auth.get(Customer.self) else { fatalError() }
            //guard let c = req.session.authenticated(Customer.self) else { fatalError() }
            
            //find associated Customer
            //use
            //guard let sessionID = req.session.data["_CustomerSession"] else { fatalError() }
            //guard let uuid = UUID(uuidString: sessionID) else { fatalError() }
//            _ = Customer.query(on: req.db)
//                .filter(\.$id == c.sessionID)
//                .first()
//                .map {
//                    if let cust = $0 {
//                        print("hello \(cust.givenName!)")
//                        //req.auth.login(cust)
//                        //req.session.authenticate(cust)
//                    }
//            }
            //print("Hi I'm \(c.givenName ?? "?")")
            print("has session")
        }
        else {
            //create session
            let newGuy = Customer()
            newGuy.givenName = "Elon"
            //req.session.data["name"] = newGuy.givenName //create session
            _ = newGuy.create(on: req.db).map{
                req.session.authenticate(newGuy)
            }
//            let c = Customer
//            let newSession = req.session.authenticate(<#T##a: SessionAuthenticatable##SessionAuthenticatable#>)
            //associate a customer
        }
        return req.view.render("landingPg")
    }
    
    func startSurvey(req: Request) -> Response {
        print("LandingPg: \(req.headers.description)")
        return req.redirect(to: "/rank")
    }
}
