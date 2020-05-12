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
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("salesPg")
    }
    
    func nextPg(req: Request) -> Response {
//        print("AgeQPg: \(req.description)")
//        let testForm = try! req.content.decode(Age.self)
//        print(testForm.print())
        return req.redirect(to: "/landingPg")
    }
}
