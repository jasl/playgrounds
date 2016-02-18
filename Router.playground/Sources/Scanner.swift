import Foundation

public enum TokenType {
    case Slash
    case Literal
    case Symbol
    case LParen
    case RParen
    case Star
    case Dot
}

public struct Token {
    public let type: TokenType
    public let value: String

    public init(type: TokenType, value: String) {
        self.type = type
        self.value = value
    }
}

public struct Scanner {
    private let stopWordsSet: Set<Character> = ["(", ")", "/"]

    public let expression: String

    private(set) var position: String.Index

    public init(expression: String) {
        self.expression = expression
        self.position = self.expression.startIndex
    }

    public var isEOF: Bool {
        return self.position == self.expression.endIndex
    }

    private var unScannedFragment: String {
        return self.expression.substringFromIndex(self.position)
    }

    public mutating func nextToken() -> Token? {
        if self.isEOF {
            return nil
        }

        let firstChar = self.unScannedFragment.characters.first!

        self.position = self.position.advancedBy(1)

        switch firstChar {
        case "/":
            return Token(type: .Slash, value: "/")
        case ".":
            return Token(type: .Dot, value: ".")
        case "(":
            return Token(type: .LParen, value: "(")
        case ")":
            return Token(type: .RParen, value: ")")
        default:
            break
        }

        var fragment = "\(firstChar)"
        var stepPosition = 0
        for char in self.unScannedFragment.characters {
            if stopWordsSet.contains(char) {
                break
            }

            fragment.append(char)
            stepPosition += 1
        }

        self.position = self.position.advancedBy(stepPosition)

        switch firstChar {
        case ":":
            return Token(type: .Symbol, value: fragment)
        case "*":
            return Token(type: .Star, value: fragment)
        default:
            return Token(type: .Literal, value: fragment)
        }
    }
}