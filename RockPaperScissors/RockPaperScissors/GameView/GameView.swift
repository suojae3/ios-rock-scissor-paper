
import Foundation

//MARK: - GameView init & deinit
final class GameView {
    private let gameRules: GameRules
    
    init(gameRules: GameRules) {
        self.gameRules = gameRules
        displayMessageHandler()
        startSecondGameHandler()
        restartFirstGameHandler()
        restartSecondGameHandler()
    }
    
    deinit { print("gameView deinit") }
}

//MARK: - GameView Method
extension GameView {
    func startGame() {
        print("가위(1), 바위(2), 보(3) ! <종료: 0> : ", terminator: "")
        if let playerInput = readLine() {
            gameRules.playFirstGameWithUserInput(input: playerInput)
        }
    }
    
    private func startSecondGameHandler() {
        gameRules.onRequstSecondGame = { [weak self] in
            self?.gameRules.dipslaySecondGameComment()
            
            if let playerInput = readLine() {
                self?.gameRules.playSecondGameWithUserInput(input: playerInput)
            }
        }
    }
    
    private func restartFirstGameHandler() {
        gameRules.onRestartFirstGame = { [weak self]  in
            self?.startGame()
        }
    }
    
    private func restartSecondGameHandler() {
        gameRules.onRestartSecondGame = { [weak self] in
            if let playerInput = readLine() {
                self?.gameRules.playSecondGameWithUserInput(input: playerInput)
            }
        }
    }
    
    private func displayMessageHandler() {
        gameRules.onUpdateMessage = { message in
            print(message)
        }
    }
}


