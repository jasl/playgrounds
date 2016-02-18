import Foundation

public class Node {
    var literalNodes: [String: LiteralNode] = [:]
    var symbolNode: SymbolNode?
    var starNode: StarNode?

    var optionalLiteralNodes: [String: LiteralNode] = [:]
    var optionalSymbolNode: SymbolNode?
    var optionalStarNode: StarNode?

    var suffixLiteralNodes: [String: LiteralNode] = [:]
    var suffixSymbolNode: SymbolNode?
    var suffixStarNode: StarNode?

    var handler: ([String:String] -> Void)?
}

public class RootNode: Node {

}

public class LiteralNode: Node {
 
}

public class SymbolNode: Node {

}

public class StarNode: Node {

}
