
import Foundation

//MARK: - RPS Node init
final class RPSNode {
    var value: RPSModel
    var next: RPSNode?
    
    init(value: RPSModel) {
        self.value = value
    }
}

//MARK: - CircularRpsLinkedList init
final class CircularRpsLinkedList {
    private var startNode: RPSNode?
    
    init() {
        startNode = createRPSLinkedList()
    }
}

//MARK: - CircularRpsLinkedList Method
extension CircularRpsLinkedList {
    private func createRPSLinkedList() -> RPSNode {
        let rock = RPSNode(value: .rock)
        let paper = RPSNode(value: .paper)
        let scissors = RPSNode(value: .scissors)
        
        rock.next = paper
        paper.next = scissors
        scissors.next = rock
        
        return rock
    }
    
    func node(for choice: RPSModel) -> RPSNode? {
        var currentNode = startNode
        repeat {
            if currentNode?.value == choice {
                return currentNode
            }
            currentNode = currentNode?.next
        } while currentNode !== startNode
        
        return nil
    }
}
