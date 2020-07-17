//
//  SalesPg.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-12.
//

import Fluent
import Vapor

class SalesPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("sales", use: webpage(req:))
        routes.post("sales", use: nextPg(req:))
    }
    
    func webpage(req: Request) throws -> EventLoopFuture<View> {
            let email = req.session.data["email"]
        let session = req.session.data
            
            return Customer.query(on: req.db)
                .filter(\.$email == email)
                .first()
                .unwrap(or: Abort(.noContent))
                .flatMap { customer in
                    print(customer.painfulJoints ?? "pain free")
                    let vC = ViewContext(primary: session["primary"] ?? "1",
                                         secondary: session["secondary"] ?? "2",
                                         tertiary: session["tertiary"] ?? "3")
                    return req.view.render("salesPg", vC)
                }  //display 3 videos based on their selection
    }
    
    func nextPg(req: Request) -> Response {
        //FIXME:
        return req.redirect(to: "/landingPg")
    }
    
    struct ViewContext: Encodable {
        let primary: String
        let secondary: String
        let tertiary: String
    }
}
