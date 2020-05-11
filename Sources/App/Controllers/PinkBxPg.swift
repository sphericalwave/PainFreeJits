//
//  PinkBxPg.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-06.
//

import Fluent
import Vapor

class PinkBxPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("pinkBx", use: webpage(req:))
        routes.post("pinkBx", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("pinkBxPg")
    }
    
    func nextPg(req: Request) -> Response {
        return req.redirect(to: "/landingPg")
    }
}

class OrgGrnBxPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("OrgGrnBxPg", use: webpage(req:))
        routes.post("OrgGrnBxPg", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("OrgGrnBxPg")
    }
    
    func nextPg(req: Request) -> Response {
        return req.redirect(to: "/OrgGrnBxPg")
    }
}

class RspsvPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("RspsvPg", use: webpage(req:))
        routes.post("RspsvPg", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("RspsvPg")
    }
    
    func nextPg(req: Request) -> Response {
        return req.redirect(to: "/RspsvPg")
    }
}

class HomePg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("", use: webpage(req:))
        routes.post("", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("index")
    }
    
    func nextPg(req: Request) -> Response {
        return req.redirect(to: "/RspsvPg")
    }
}

class YogurtPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("yog", use: webpage(req:))
        routes.post("yog", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("yogPg")
    }
    
    func nextPg(req: Request) -> Response {
        return req.redirect(to: "/landing")
    }
}
