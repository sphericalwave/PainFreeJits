//
//  ImperialAPI.swift
//  App
//
//  Created by Aaron Anthony on 2020-05-24.
//

import Vapor
import ImperialGoogle

//struct ImperialAPI: RouteCollection
//{
//    func boot(routes: RoutesBuilder) throws {
//        guard let googleCallbackURL = Environment.get("GOOGLE_CALLBACK_URL") else { fatalError() }
//        try routes.oAuth(from: Google.self, authenticate: "login-google", authenticateCallback: nil, callback: googleCallbackURL, scope: ["profile", "email"], completion: processGoogleLogin)
//    }
//
//    func processGoogleLogin(request: Request, token: String) throws -> EventLoopFuture<ResponseEncodable> {
//        return request.eventLoop.makeSucceededFuture(request.redirect(to: "/"))
//    }
//}


//struct ImperialController: RouteCollection {
//    func boot(routes: RoutesBuilder) throws {
//        guard let googleCallbackURL = Environment.get("GOOGLE_CALLBACK_URL") else {
//            fatalError("Google callback URL not set")
//        }
//        try routes.oAuth(from: Google.self, authenticate: "login-google", callback: googleCallbackURL,
//                         scope: ["profile", "email"], completion: processGoogleLogin)
//    }
    
//    func processGoogleLogin(request: Request, token: String) throws -> EventLoopFuture<ResponseEncodable> {
//        return try getUser(on: request).flatMap(to: ResponseEncodable.self) { userInfo in
//            return User.query(on: request).filter(\.username == userInfo.email)
//                .first().flatMap(to: ResponseEncodable.self) { foundUser in
//                    guard let existingUser = foundUser else {
//                        let user = User(name: userInfo.name, username: userInfo.email, password: UUID().uuidString)
//                        return user.save(on: request).map(to: ResponseEncodable.self) { user in
//                            try request.authenticateSession(user)
//                            return request.redirect(to: "/")
//                        }
//                    }
//                    try request.authenticateSession(existingUser)
//                    return request.future(request.redirect(to: "/"))
//            }
//        }
//    }
    
//    func getUser(on request: Request) throws -> EventLoopFuture<GoogleUserInfo> {
//        var headers = HTTPHeaders()
//        headers.bearerAuthorization = try BearerAuthorization(token: request.accessToken())
//
//        let googleAPIURL = "https://www.googleapis.com/oauth2/v1/userinfo?alt=json"
//        request.client.get(<#T##url: URI##URI#>, headers: <#T##HTTPHeaders#>, beforeSend: <#T##(inout ClientRequest) throws -> ()#>)
//
//        return try request.client.get(googleAPIURL, headers: headers).map(to: GoogleUserInfo.self) { response in
//            guard response.http.status == .ok else {
//                if response.http.status == .unauthorized {
//                    throw Abort.redirect(to: "/login-google")
//                } else {
//                    throw Abort(.internalServerError)
//                }
//            }
//            return try response.content.syncDecode(GoogleUserInfo.self)
//        }
//    }
//}

//ClientID 680294895132-5kuu3ltvvvqmg074b8pq9b1g8jeo00as.apps.googleusercontent.com
//ClientSecret Yc9nvxU2lyHo1bmiNKqg8vla

struct GoogleUserInfo: Content
{
    let email: String
    let name: String
}

//final class User: Codable {
//    var id: UUID?
//    var name: String
//    var username: String
//    var password: String
//}

import Fluent
//import Vapor

final class User: Model, Content
{
    static let schema = "todos"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "name")
    var name: String
    
    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String

    init() { }

    init(id: UUID? = nil, name: String, username: String, password: String) {
        self.id = id
        self.name = name
        self.username = username
        self.password = password
    }
}

//extension User: PostgreSQLUUIDModel { typealias Database = PostgreSQLDatabase }
//extension User: Content {}

import Fluent
//import Vapor

class OAuthPg: RouteCollection
{
    func boot(routes: RoutesBuilder) throws {
        routes.get("oauth", use: webpage(req:))
        routes.post("oauth", use: nextPg(req:))
    }
    
    func webpage(req: Request) -> EventLoopFuture<View> {
        return req.view.render("oAuthPg")
    }
    
    func nextPg(req: Request) -> Response {
//        print("AgeQPg: \(req.description)")
//        let testForm = try! req.content.decode(Age.self)
//        print(testForm.print())
        return req.redirect(to: "/landingPg")
    }
}
