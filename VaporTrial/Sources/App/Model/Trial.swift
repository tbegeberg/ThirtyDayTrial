
import Vapor
import FluentMySQL

final class Trial: MySQLModel, Content {
    var id: Int?
    
    var trialName: String
    var daysBeforeCancelTime: Int
    
    init(id: Int? = nil, trialName: String, daysBeforeCancelTime: Int) {
        self.trialName = trialName
        self.daysBeforeCancelTime = daysBeforeCancelTime
    }
    
}

extension Trial: Migration {}
