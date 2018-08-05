import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    
    let trialController = TrialController()
    router.get("trials", use: trialController.index)
    
}
