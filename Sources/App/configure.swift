
import Fluent
import FluentPostgresDriver
import Vapor
import Leaf


enum EnvironmentError: Error {
    case dbURL(msg: String)
}

public func configure(_ app: Application) throws
{
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.views.use(.leaf)
    //app.leaf.cache.isEnabled = app.environment.isRelease
    
    guard let databaseURL = Environment.get("DATABASE_URL") else {
        throw EnvironmentError.dbURL(msg: "DATABASE_URL Error")
    }
    app.databases.use(try .postgres(url: databaseURL), as: .psql)
    
    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.sessions.configuration.cookieName = "PainFreeJujitsu"
    app.middleware.use(app.sessions.middleware)
    //app.middleware.use(Customer.sessionAuthenticator())

    try! app.register(collection: LandingPg())
    try! app.register(collection: JointQPg())
    try! app.register(collection: RankQPg())
    try! app.register(collection: DemographicPg())
    try! app.register(collection: EmailPg())
    try! app.register(collection: AgeQPg())
    try! app.register(collection: SalesPg())
    try! app.register(collection: DeepDivePg())
    
    app.migrations.add(CustomerMigration1(), to: .psql)
    
    app.middleware.use(UserSessionAuthenticator())
    
    let protected = app.routes.grouped([
        UserSessionAuthenticator(),
        //UserBearerAuthenticator(),
        //User.guardMiddleware(),
    ])

    // Add GET /me route for reading user's email.
    protected.get("me") { req -> String in
        //let user = User(email: "hello@vapor.codes")
        //req.auth.login(user)
//        guard let id = req.session.id?.string else { fatalError("No Session Id") }
//        //print("sessiondID = \(id?.string ?? "no session")" )
//        let u = User(id: id)
//        //req.auth.login(u)
        //let user = try req.auth.require(User.self)
//        return u.id
        //return "sessiondID = \(id?.string ?? "no session")"
        
        //guard let user = req.auth.get(User.self) else { throw Abort(.unauthorized) }
        //req.session.authenticate(user)
        //return user.sessionID
        
        return "whatever"
    }
    
}
