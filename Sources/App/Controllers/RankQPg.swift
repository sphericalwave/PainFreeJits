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
        let rank = try! req.content.decode(Rank.self)
        print(rank.print())
        print(req.session.id ?? "no session found")
        //TODO: check for existing sessionId and match with a customer
        let newGuy = Customer()
        newGuy.givenName = "Elon"
        newGuy.belt = rank.belt
        newGuy.stripes = rank.stripes
        newGuy.create(on: req.db)
        
        req.session.data["user"] = "Aaron"
        let d = req.session.data
        
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


