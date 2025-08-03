import Foundation

// Decentralized CLI Tool Simulator

// Node structure
struct Node {
    let id: Int
    var commands: [String: () -> Void] = [:]
    var peers: [Int: Node] = [:]

    init(id: Int) {
        self.id = id
    }

    func addCommand(name: String, action: @escaping () -> Void) {
        commands[name] = action
    }

    func connect-peer(_ peer: Node) {
        peers[peer.id] = peer
    }

    func executeCommand(_ command: String) {
        if let action = commands[command] {
            action()
        } else {
            print("Command not found: \(command)")
        }
    }
}

// CLI Simulator
class CLISimulator {
    let currentNode: Node

    init(node: Node) {
        self.currentNode = node
    }

    func startCLI() {
        print("Welcome to CWQI Decentralized CLI Simulator!")
        print("Type 'help' to see available commands")

        while true {
            print("\n> ", terminator: "")
            if let input = readLine() {
                let commands = input.components(separatedBy: " ")
                executeCommands(commands)
            }
        }
    }

    func executeCommands(_ commands: [String]) {
        if commands.isEmpty {
            return
        }

        let command = commands[0]
        if command == "help" {
            printHelp()
        } else if command == "connect" {
            if commands.count > 1 {
                if let peerId = Int(commands[1]) {
                    let peerNode = Node(id: peerId)
                    currentNode.connect-peer(peerNode)
                    print("Connected to peer \(peerId)")
                } else {
                    print("Invalid peer ID")
                }
            } else {
                print("Usage: connect <peer_id>")
            }
        } else {
            currentNode.executeCommand(command)
        }
    }

    func printHelp() {
        print("Available commands:")
        print("  help      - Display available commands")
        print("  connect   - Connect to a peer node")
        print("  <custom> - Execute a custom command")
    }
}

// Example usage
let node1 = Node(id: 1)
node1.addCommand(name: "hello") {
    print("Hello, world!")
}

let node2 = Node(id: 2)
node2.addCommand(name: "goodbye") {
    print("Goodbye, world!")
}

let cli = CLISimulator(node: node1)
cli.startCLI()