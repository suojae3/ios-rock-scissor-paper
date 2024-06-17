
import Foundation

//MARK: - TurnModel enum
enum TurnModel {
    case userTurn
    case computerTurn
    
    var message: String{
        switch self {
        case .userTurn:
            return "[사용자 턴] 묵(1), 찌(2), 빠(3) ! <종료: 0> : "
        case .computerTurn:
            return "[컴퓨터 턴] 묵(1), 찌(2), 빠(3) ! <종료: 0> : "
        }
    }
}
