//
//  EmailPg.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-05.
//

import Fluent
import Vapor

class EmailPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("email", use: webpage(req:))
        routes.post("email", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("emailPg")
    }
    
    func nextPg(req: Request) throws -> EventLoopFuture<View> {
        print("\nEmailPg: \(req.description)\n")
        
        do {
            let contact = try req.content.decode(Contact.self)
            req.session.data["givenName"] = contact.name
            req.session.data["email"] = contact.email
            
            guard let sId = req.session.id?.string else { fatalError() }
            print("\nEmailPg: SessionId: \(sId)\n")
            let uuid = UUID(uuidString: sId)
            
            return Customer.query(on: req.db)
                .filter(\.$email == contact.email)
                .first()
                .map { cust -> Customer in
                    guard let cust = cust else {
                        let c = Customer()
                        c.id = uuid
                        c.givenName = req.session.data["givenName"]
                        c.email = req.session.data["email"]
                        c.birthDate = Date() //TODO: req.session.data["birthdate"]
                        c.gender = true //TODO: req.session.data["gender"]
                        c.painfulJoints = req.session.data["joints"] //TODO;
                        c.belt = req.session.data["belt"]
                        c.stripes = req.session.data["stripes"]
                        return c
                    }
                    cust.email = req.session.data["email"]
                    cust.givenName = req.session.data["givenName"]
                    return cust
                }
                .map{ _ = $0.save(on: req.db) }
                .flatMap { req.view.render("salesPg") }
        }
        catch { throw Abort(.noContent) }
    }
    
    struct Contact: Content
    {
        var name: String
        var email: String
        func print() -> String { return name + " " + email }
    }
}




//aweber
//awlist5620928
//POST https://api.aweber.com/1.0/accounts/{accountId}/lists/{listId}/subscribers
//POST https://api.aweber.com/1.0/accounts/{accountId}/lists/awlist5620928/subscribers
//api@aweber.com


//https://mailchimp.com/developer/guides/manage-subscribers-with-the-mailchimp-api/
//Add a contact to a list/audience
//
//To add a contact to a list/audience, send a POST request to the List Members endpoint: /3.0/lists/9e67587f52/members/. The request body should be a JSON object that contains the information you want to add, with status and any other required list fields.
//{
//    "email_address": "urist.mcvankab@freddiesjokes.com",
//    "status": "subscribed",
//    "merge_fields": {
//        "FNAME": "Urist",
//        "LNAME": "McVankab"
//    }
//}
//You'll get errors if the contact is already subscribed to the list/audience, or if any required merge_fields are missing. The full list of fields available in the List Member Schema.
//https://api.mailchimp.com/schema/3.0/Lists/Members/Instance.json?_ga=2.212803028.1510758903.1590005039-1144848101.1589896190
