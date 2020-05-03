//
//  Question2.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-02.
//

import Fluent
import Vapor

class Question2: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("question2", use: webpage(req:))
        routes.post("question2", use: postAnswer(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("question2")
    }
    
    func postAnswer(req: Request) -> HTTPStatus {
        print("Persist Answer to Session")
        print("postAnswer: \(req.headers.description)")
        return .ok
    }
}
