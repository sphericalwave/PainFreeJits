//
//  Question2.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-02.
//

import Fluent
import Vapor

class DemographicPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("demographics", use: webpage(req:))
        routes.post("demographics", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("demographicsPg")
    }
    
    func nextPg(req: Request) -> Response {
        //print("DemographicPg: \(req.description)")
        print("\n\n \(req.body.string ?? "no string")\n\n")

        let gender = try! req.content.decode(Demographic.self)
        req.session.data["gender"] = gender.gender
        return req.redirect(to: "/age")
    }
    
    struct Demographic: Content
    {
        var gender: String
        func print() -> String { return "Rank: " + gender }
    }
}


