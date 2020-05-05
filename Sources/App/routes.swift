import Fluent
import Vapor

func routes(_ app: Application) throws
{
    let landingPg = LandingPg()
    try! app.register(collection: landingPg)
    
    let jointQPg = JointQPg()
    try! app.register(collection: jointQPg)
    
    let rankQPg = RankQPg()
    try! app.register(collection: rankQPg)
    
    let q2 = DemographicPg()
    try! app.register(collection: q2)
    
    let ePg = EmailPg()
    try! app.register(collection: ePg)
    
    let helloPg = HelloPg()
    try! app.register(collection: helloPg)
}
