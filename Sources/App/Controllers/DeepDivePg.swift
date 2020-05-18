//
//  DeepDivePg.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-13.
//

import Fluent
import Vapor

class DeepDivePg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("dd", use: webpage(req:))
        routes.post("dd", use: submitForm(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("deepDivePg")
    }
    
    func submitForm(req: Request) -> Response {
        print("Joint Page: \(req.description)")
        let dds = try! req.content.decode(DeepDiveSurvey.self)
        dds.print2()
        return req.redirect(to: "/demographics")
    }
}

struct DeepDiveSurvey: Content
{
    //TODO: Complete
    var belt: String?
//    var ankles: String?
//    var knees: String?

    func print2() {
        print(belt ?? "nil")
    }
}
