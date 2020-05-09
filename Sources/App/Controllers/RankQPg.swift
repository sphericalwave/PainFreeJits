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
        //code goes here to catch radio buttons
        print("RankPg: \(req.description)")
        return req.redirect(to: "/joints")
    }
}
