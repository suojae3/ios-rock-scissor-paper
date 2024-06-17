
import Foundation

//MARK: - ComputerPlayer
final class ComputerPlayer {
    
    var choice: RPSModel?
    
    func makeRandomChoice() -> RPSModel {
        choice = RPSModel.allCases.randomElement()
        return choice ?? .rock
    }
}
