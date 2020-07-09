
import Fluent
import FluentSQLiteDriver
import Vapor
import Leaf

public func configure(_ app: Application) throws
{
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease

    app.databases.use(.sqlite(.file("db.sqlite") ), as: .sqlite)
    
    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.sessions.configuration.cookieName = "PainFreeJujitsu"
    app.middleware.use(app.sessions.middleware)
    app.middleware.use(Customer.sessionAuthenticator())



    try! app.register(collection: LandingPg())
    try! app.register(collection: JointQPg())
    try! app.register(collection: RankQPg())
    try! app.register(collection: DemographicPg())
    try! app.register(collection: EmailPg())
    try! app.register(collection: AgeQPg())
    try! app.register(collection: SalesPg())
    try! app.register(collection: DeepDivePg())
    
    app.migrations.add(CustomerMigration1())
    
    let protected = app.routes.grouped([
        app.sessions.middleware,
        UserSessionAuthenticator(),
        UserBearerAuthenticator(),
        //User.guardMiddleware(),
    ])

    // Add GET /me route for reading user's email.
    protected.get("me") { req -> String in
        let user = try req.auth.require(User.self)
        return user.email
    }
    
}
