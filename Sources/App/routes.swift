import Fluent
import Vapor

func routes(_ app: Application) throws
{
//    app.get { req -> EventLoopFuture<View> in
//        let context = Context(index: .init(title: "My page", description: "This is my Page"),
//                              page: .init(content: "Welcome to my page!"))
//        return req.view.render("page", context)
//    }
//
//    app.get("srvSnglChoice") { req -> EventLoopFuture<View> in
//        let ndx = Index(title: "srvSnglChoice", description: "What hurts the most?")
//        let pg = Page(content: "Fingers, Toes")
//        let context = Context(index: ndx, page: pg)
//        return req.view.render("srvSnglChoice", context)
//    }
    
    let landingPg = LandingPg()
    try! app.register(collection: landingPg)
    
    let q1Pg = Question1Pg()
    try! app.register(collection: q1Pg)
    
    let q2 = Question2Pg()
    try! app.register(collection: q2)
    
    let helloPg = HelloPg()
    try! app.register(collection: helloPg)
}

struct Context: Codable
{
    var index: Index
    var page: Page
}

struct Index: Codable
{
    var title: String
    var description: String
}

struct Page: Codable
{
    var content: String
}
