
import Fluent
import FluentSQLiteDriver
import Vapor
import Leaf
import ImperialGitHub
import ImperialGoogle

public func configure(_ app: Application) throws
{
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease

    app.databases.use(.sqlite(.file("db.sqlite") ), as: .sqlite)
    
    app.sessions.use(.fluent)
    app.migrations.add(SessionRecord.migration)
    app.middleware.use(app.sessions.middleware)

    //worked
//    try app.oAuth(from: Google.self, authenticate: "google", callback: "http://localhost:8080/google-complete", scope: ["https://mail.google.com/"]) { (request, token) in
//        print(token)
//        return request.eventLoop.future(request.redirect(to: "/"))
//    }

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
