import Foundation

enum AccountCategory:String, CaseIterable, Codable {
    // case 💸, 💰, ☕️, 🍖, 🚘
    case none
    case saving
    case drink
    case food
    case transport
    
    var id:AccountCategory { self }
    
    var ExpenditureDisplayImoji: String {
        
        switch self {
            
        case .saving: return "💰"
            
        case .drink: return "☕️"
            
        case .food: return "🍖"
            
        case .transport: return "🚘"
            
        default: return "💸"
            
        }
    }
    
    var ExpenditureDisplay: String {
        switch self {
            
        case .saving: return "돈아끼기좋은날"
            
        case .drink: return "커피/음료수 좋은날"
            
        case .food: return "먹기좋은날"
            
        case .transport: return "타고이동하기"
            
        default: return "돈쓰기좋은날"
        }
    }
    
    var IncomeDisplayImoji: String {
        
        switch self {
            
        case .saving: return "💰"
            
        case .drink: return "☕️"
            
        case .food: return "🍖"
            
        case .transport: return "🚘"
            
        default: return "💸"
            
        }
    }
    
    var IncomeDisplay: String {
        switch self {
            
        case .saving: return "아싸 용돈이당"
            
        case .drink: return "아싸 월급이당"
            
        case .food: return "개꿀 불로소득"
            
        case .transport: return "이자다"
            
        default: return "오다주웠다"
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
