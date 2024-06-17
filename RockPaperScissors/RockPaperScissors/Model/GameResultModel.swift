
import Foundation

//MARK: - GameResult enum
enum GameResult: Int {
    case win
    case loss
    case draw
    case error
    case endGame
    
    var message: String {
        switch self {
        case .win:
            return "승리하셨습니다!"
        case .loss:
            return "패배하셨습니다!"
        case .draw:
            return "무승부하셨습니다!"
        case .error:
            return "잘못된 입력입니다! 다시 시도해주세요"
        case .endGame:
            return "게임종료"
        }
    }
}
