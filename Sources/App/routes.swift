import Fluent
import Vapor

func routes(_ app: Application) throws
{
    try! app.register(collection: LandingPg())
    try! app.register(collection: JointQPg())
    try! app.register(collection: RankQPg())
    try! app.register(collection: DemographicPg())
    try! app.register(collection: EmailPg())
    try! app.register(collection: HelloPg())
    try! app.register(collection: PinkBxPg())
    try! app.register(collection: OrgGrnBxPg())
    try! app.register(collection: RspsvPg())
}
