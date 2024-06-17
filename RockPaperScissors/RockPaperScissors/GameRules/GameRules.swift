
import Foundation

//MARK: - GameRules init & deinit
final class GameRules {
    private let computerPlayer = ComputerPlayer()
    private let rpsLinkedList = CircularRpsLinkedList()
    var onRequstSecondGame: (() -> Void)?
    var onUpdateMessage: ((String) -> Void)?
    var onRestartFirstGame: (() -> Void)?
    var onRestartSecondGame: (() -> Void)?
    var gameTurn: TurnModel
    
    init() {
        gameTurn = .userTurn
    }
    
    deinit { print("GameRules Deinit!!") }
}

//MARK: - Common GameRules method
extension GameRules {
    func convertInputToRPSOption(_ input: String) -> RPSModel? {
        switch Int(input) {
        case RPSModel.scissors.rawValue:
            return .scissors
        case RPSModel.rock.rawValue:
            return .rock
        case RPSModel.paper.rawValue:
            return .paper
        default:
            return nil
        }
    }
}

//MARK: - First GameRules method (가위바위보)
extension GameRules {
    func playFirstGameWithUserInput( input: String) {
        switch input {
        case "0":
            onUpdateMessage?(GameResult.endGame.message)
        case "1","2","3":
            if let userChoice = convertInputToRPSOption(input) {
                let gameResult = determineFirstGameWinner(userChoice: userChoice)
            }
        default:
            onUpdateMessage?(GameResult.error.message)
            onRestartFirstGame?()
        }
    }
    
    private func determineFirstGameWinner(userChoice: RPSModel) {
        let computerChoice = computerPlayer.makeRandomChoice()
        
        onUpdateMessage?("유저 선택:::\(userChoice), 컴퓨터 선택:::\(computerChoice)")
        
        guard let computerNode = rpsLinkedList.node(for: computerChoice)
        else { return }
        
        if computerNode.next?.value == userChoice {
            onUpdateMessage?(GameResult.win.message)
            gameTurn = .userTurn
            onRequstSecondGame?()
        } else if computerNode.value == userChoice {
            onUpdateMessage?(GameResult.draw.message)
            onRestartFirstGame?()
        } else {
            onUpdateMessage?(GameResult.loss.message)
            gameTurn = .computerTurn
            onRequstSecondGame?()
        }
    }
}


//MARK: - Second GameRules method (묵찌빠)
extension GameRules {
    func playSecondGameWithUserInput( input: String) {
        
        switch input {
        case "0":
            onUpdateMessage?(GameResult.endGame.message)
        case "1","2","3":
            if let userChoice = convertInputToRPSOption(input) {
                let secondGamsResult = determineSecondGameWinner(userChoice: userChoice)
            }
            
        default:
            onUpdateMessage?(GameResult.error.message)
            gameTurn = .computerTurn
            onUpdateMessage?(TurnModel.computerTurn.message)
            onRestartSecondGame?()
        }
    }
    
    func dipslaySecondGameComment() {
        switch gameTurn {
        case .userTurn:
            onUpdateMessage?(TurnModel.userTurn.message)
        case .computerTurn:
            onUpdateMessage?(TurnModel.computerTurn.message)
        }
    }
    
    private func determineSecondGameWinner(userChoice: RPSModel)  {
        secondGameRoop: while true {
            let computerChoice = computerPlayer.makeRandomChoice()
        
            switch (gameTurn, userChoice == computerChoice) {
            case (.userTurn, true):
                onUpdateMessage?("사용자 승")
                break secondGameRoop
            case (.userTurn, false):
                onUpdateMessage?("컴퓨터 턴입니다.")
                gameTurn = .computerTurn
            case (.computerTurn, true):
                onUpdateMessage?("컴퓨터 승")
                break secondGameRoop
            default:
                onUpdateMessage?("사용자 턴입니다.")
                gameTurn = .userTurn
            }
            onRequstSecondGame?()
            break secondGameRoop
        }
    }
}
