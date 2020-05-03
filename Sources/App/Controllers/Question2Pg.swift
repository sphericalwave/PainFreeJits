//
//  Question2.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-02.
//

import Fluent
import Vapor

class Question2Pg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("question2", use: webpage(req:))
        routes.post("question2", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("question2")
    }
    
    func nextPg(req: Request) -> HTTPStatus {
        print("Persist Answer to Session")
        print("postAnswer: \(req.headers.description)")
        return .ok
    }
}
