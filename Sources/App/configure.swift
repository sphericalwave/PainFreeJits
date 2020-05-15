import Fluent
import FluentSQLiteDriver
import Vapor
import Leaf

public func configure(_ app: Application) throws
{
    // Serves files from `Public/` directory
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    // Configure Leaf
    app.views.use(.leaf)
    app.leaf.cache.isEnabled = app.environment.isRelease

    // Configure SQLite database
    //app.databases.use(.sqlite(.memory), as: .sqlite)
    app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
    //app.databases.use(.postgres(hostname: "localhost", username: "vapor", password: "vapor", database: "vapor"), as: .psql)


    // Configure migrations
    //app.migrations.add(CreateTodo())
    app.migrations.add(CustomerMgrt())
    //try app.autoMigrate().wait() //for in memory //Some issue here if i leave this on
    
    app.sessions.use(.fluent(.sqlite)) //.sqlite
    app.middleware.use(app.sessions.middleware)
    app.sessions.configuration.cookieName = "PainFreeJiujitsu"
    // Configures cookie value creation.
    app.sessions.configuration.cookieFactory = { sessionID in
        .init(string: sessionID.string, isSecure: true)
    }
    app.sessions.use(.fluent)
    //app.sessions.use(.fluent(.sqlite))
    app.migrations.add(SessionRecord.migration)  //how do i run migrations?
    
    app.get("set", ":value") { req -> HTTPStatus in
        print(req.description)
        for (cookie, value) in req.cookies.all {
            print("\(cookie) : \(value)")
            let cD = cookie.description
            if cD == "vapor-session" { print("i see you've played knify Spoony before")}
        }
        let input = req.parameters.get("value")
        var data = req.session.data
        data["name"] = input
        print("sessionData name \(data["name"]!)")
        return .ok
    }
    
    app.get("get") { req -> String in
        print(req.description)
        let sNm = req.session.data["name"] ?? "no name assigned"
        print("get sessionData name \(sNm)")
        return sNm //req.session.data["name"] ?? "n/a"
    }
    
    app.get("del") { req -> HTTPStatus in
        print(req.description)
        let sNm = req.session.data["name"] ?? "no name assigned"
        print("del sessionData name \(sNm)")
        req.session.destroy()
        return .ok
    }
    
    app.post("customer") { req -> EventLoopFuture<Customer> in
        for (cookie, value) in req.cookies.all { print("\(cookie) : \(value)")}
        let cstmr = try req.content.decode(Customer.self)
        return cstmr.create(on: req.db).map { cstmr }
    }
    
    app.get("customer") { req in
        Customer.query(on: req.db).all()
    }

    try! app.register(collection: LandingPg())
    try! app.register(collection: JointQPg())
    try! app.register(collection: RankQPg())
    try! app.register(collection: DemographicPg())
    try! app.register(collection: EmailPg())
    try! app.register(collection: AgeQPg())

    //try! app.register(collection: HelloPg())
    //try! app.register(collection: PinkBxPg())
    try! app.register(collection: SalesPg())
    try! app.register(collection: DeepDivePg())
    //try! app.register(collection: HomePg())
    //try! app.register(collection: YogurtPg())
}
