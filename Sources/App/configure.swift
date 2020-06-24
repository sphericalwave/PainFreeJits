import Fluent
import FluentSQLiteDriver
import Vapor
import Leaf
import ImperialGoogle
import ImperialGitHub

public func configure(_ app: Application) throws
{
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease

    app.databases.use(.sqlite(.file("db.sqlite") ), as: .sqlite)
    
    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)
    
    try app.oAuth(from: GitHub.self, authenticate: "github", callback: "") { (request, token) in
        print("auth token: \(token)")
        print("request: \(request.description)")
        return request.eventLoop.makeSucceededFuture(Response())
        //return request.eventLoop.future(request.redirect(to: "/"))
    }

    try! app.register(collection: LandingPg())
    try! app.register(collection: JointQPg())
    try! app.register(collection: RankQPg())
    try! app.register(collection: DemographicPg())
    try! app.register(collection: EmailPg())
    try! app.register(collection: AgeQPg())
    try! app.register(collection: SalesPg())
    try! app.register(collection: DeepDivePg())
    try! app.register(collection: OAuthPg())
    

}
