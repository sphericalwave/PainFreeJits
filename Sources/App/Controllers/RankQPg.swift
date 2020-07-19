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
        print(req.body.description)
        let rank = try! req.content.decode(Rank.self)
        req.session.data["belt"] = rank.belt
        req.session.data["stripes"] =  rank.stripes
        //print("\n\n \(req.content)\n\n")
        
        print("\n\n \(req.body.string ?? "no string")\n\n")


//        do {
////            let customer = try req.auth.require(Customer.self)
////            customer.belt = rank.belt
////            customer.stripes = rank.stripes
////            customer.save(on: req.db)
////                .map{ return req.redirect(to: "/joints") }
//
//            let usr = try req.auth.require(User.self)
//            req.session.data["rank"] = usr.id
//        }
//        catch {
////            let customer = Customer()
////            customer.belt = rank.belt
////            customer.stripes = rank.stripes
////            customer.save(on: req.db)
////                .map{ return req.redirect(to: "/joints") }
//
//            let usr = User(id: req.session.id?.string ?? "No Session ID")
////            usr.id = rank.belt
//            req.auth.login(usr)
//            req.session.authenticate(usr)
//        }
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


