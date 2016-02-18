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
    let stopWordsSet: Set<Character> = ["(", ")", "/"]

    let expression: String

    var position: String.Index
    private let endPosition: String.Index

    var unScannedFragment: String {
        return self.expression.substringFromIndex(self.position)
    }

    public init(expression: String) {
        self.expression = expression
        self.position = self.expression.startIndex
        self.endPosition = self.expression.endIndex
    }

    public var isEOF: Bool {
        return self.position == self.endPosition
    }

    public mutating func nextToken() -> Token? {
        if self.isEOF {
            return nil
        }

        return scan()
    }

    private mutating func scan() -> Token {
        guard let firstChar = self.unScannedFragment.characters.first else {
            fatalError("expression is exhausted")
        }

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