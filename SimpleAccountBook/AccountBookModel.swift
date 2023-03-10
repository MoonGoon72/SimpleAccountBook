import Foundation

enum AccountCategory:String, CaseIterable, Codable {
    // case πΈ, π°, βοΈ, π, π
    case none
    case saving
    case drink
    case food
    case transport
    
    var id:AccountCategory { self }
    
    var ExpenditureDisplayImoji: String {
        
        switch self {
            
        case .saving: return "π°"
            
        case .drink: return "βοΈ"
            
        case .food: return "π"
            
        case .transport: return "π"
            
        default: return "πΈ"
            
        }
    }
    
    var ExpenditureDisplay: String {
        switch self {
            
        case .saving: return "μ μΆνκΈ° μ’μλ "
            
        case .drink: return "μ»€νΌ/μλ£μ μ’μλ "
            
        case .food: return "λ¨ΉκΈ° μ’μλ "
            
        case .transport: return "νκ³  μ΄λνκΈ°"
            
        default: return "λ μ°κΈ° μ’μλ "
        }
    }
    
    var IncomeDisplayImoji: String {
        
        switch self {
            
        case .saving: return "π°"
            
        case .drink: return "βοΈ"
            
        case .food: return "π"
            
        case .transport: return "π"
            
        default: return "πΈ"
            
        }
    }
    
    var IncomeDisplay: String {
        switch self {
            
        case .saving: return "μμΈ μ©λμ΄λΉ"
            
        case .drink: return "μμΈ μκΈμ΄λΉ"
            
        case .food: return "κ°κΏ λΆλ‘μλ"
            
        case .transport: return "μ΄μλ€"
            
        default: return "μ€λ€μ£Όμ λ€"
        }
    }
}

struct AccountData: Codable {
    var category:AccountCategory = .none
    var title:String = ""
    var account:String = "0"
    var date:Date = Date()
    
    init(category: AccountCategory, title: String, account: String) {
        self.category = category
        self.title = title
        self.account = account
    }
    init() {}
}
