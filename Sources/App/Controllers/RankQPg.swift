//
//  RankQPg.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-05.
//

import Fluent
import Vapor

class RankQPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("rank", use: webpage(req:))
        routes.post("rank", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("rankQPg")
    }
    
    func nextPg(req: Request) -> Response {
        print("RankPg: \(req.description)")
        let testForm = try! req.content.decode(Rank.self)
        print(testForm.print())
        return req.redirect(to: "/joints")
    }
    
    struct Rank: Content
    {
        var belt: String
        var stripes: String
        
        func print() -> String {
            return "Rank: " + belt + " " + stripes
        }
    }
}


