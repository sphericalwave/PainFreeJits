//
//  Question1Pg.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-03.
//

import Fluent
import Vapor

class JointQPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("joints", use: webpage(req:))
        routes.post("joints", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("jointsQPg")
    }
    
    func nextPg(req: Request) -> Response {
        //print("\n\n \(req.description)\n\n")
        //print("\n\n \(req.content)\n\n")
        print("\n\n \(req.body.string ?? "no string")\n\n")

        let joints = try! req.content.decode(Joints.self)
        req.session.data["joints"] = joints.everything().description
        return req.redirect(to: "/demographics")
    }
    
    struct Joints: Content
    {
        //TODO: Complete
        var toe: String?
        var ankle: String?
        var knee: String?
        var hip: String?
        var lowBack: String?
        var rib: String?
        var shoulder: String?
        var elbow: String?
        var wrist: String?
        var thumb: String?
        var finger: String?
        var fingerTip: String?

        
        func everything() -> [String] {
            var all = [String]()
            if let t = toe { all.append(t) }
            if let a = ankle { all.append(a) }
            if let kn = knee { all.append(kn) }
            if let hp = hip { all.append(hp) }
            if let lB = lowBack { all.append(lB) }
            if let rb = rib { all.append(rb) }
            if let sh = shoulder { all.append(sh) }
            if let elb = elbow { all.append(elb) }
            if let w = wrist { all.append(w) }
            if let tb = thumb { all.append(tb) }
            if let fg = finger { all.append(fg) }
            if let fgT = fingerTip { all.append(fgT) }
            return all
        }
        
//        func print2() -> String {
//            let ts = toes ?? "no toes"
//            let ank = ankles ?? "no ankles"
////            if let kn = knees {
////                print("knees")
////            }
//
//            return "Joint: " + ts + ank
//        }
    }
}


