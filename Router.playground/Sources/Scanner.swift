import Foundation

public enum Token {
    case Slash
    case Dot

    case Literal(String)
    case Symbol(String)
    case Star(String)

    case LParen
    case RParen
}

extension Token: CustomStringConvertible, CustomDebugStringConvertible {
    public var description: String {
        switch self {
        case .Slash:
            return "/"
        case .Dot:
            return "."
        case .LParen:
            return "("
        case .RParen:
            return ")"
        case .Literal(let value):
            return value
        case .Symbol(let value):
            return ":\(value)"
        case .Star(let value):
            return "*\(value)"
        }
    }

    public var debugDescription: String {
        switch self {
        case .Slash:
            return "[Slash]"
        case .Dot:
            return "[Dot]"
        case .LParen:
            return "[LParen]"
        case .RParen:
            return "[RParen]"
        case .Literal(let value):
            return "[Literal \"\(value)\"]"
        case .Symbol(let value):
            return "[Symbol \"\(value)\"]"
        case .Star(let value):
            return "[Star \"\(value)\"]"
        }
    }
}

extension Token: Equatable { }

public func ==(lhs: Token, rhs: Token) -> Bool {
    switch (lhs, rhs) {
    case (.Slash, .Slash):
        return true
    case (.Dot, .Dot):
        return true
    case (let .Literal(lval), let .Literal(rval)):
        return lval == rval
    case (let .Symbol(lval), let .Symbol(rval)):
        return lval == rval
    case (let .Star(lval), let .Star(rval)):
        return lval == rval
    case (.LParen, .LParen):
        return true
    case (.RParen, .RParen):
        return true
    default:
        return false
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
            return .Slash
        case ".":
            return .Dot
        case "(":
            return .LParen
        case ")":
            return .RParen
        default:
            break
        }

        var fragment = ""
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
            return .Symbol(fragment)
        case "*":
            return .Star(fragment)
        default:
            return .Literal("\(firstChar)\(fragment)")
        }
    }

    public static func tokenize(expression: String) -> [Token] {
        var scanner = Scanner(expression: expression)

        var tokens: [Token] = []
        while let token = scanner.nextToken() {
            tokens.append(token)
        }

        return tokens
    }
}