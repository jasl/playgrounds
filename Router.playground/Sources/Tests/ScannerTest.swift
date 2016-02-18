import Foundation

let cases1 = ["/", "*omg", "/page", "/page/", "/page!", "/page$", "/page&", "/page'", "/page*", "/page+", "/page,", "/page=", "/page@", "/~page", "/pa-ge", "/:page", "/(:page)", "(/:action)", "(())", "(.:format)"]

public func playScannerTest1() {
    var scanner: Scanner!

    print("\(cases1.count) tests:")

    for expr in cases1 {
        scanner = Scanner(expression: expr)

        var str = "\(expr)"

        var tokens: [Token] = []
        while let token = scanner.nextToken() {
            tokens.append(token)

            str += " [\(token.type): \(token.value)]"
        }

        print(str)
    }

    print("")
}

let cases2 = ["/", "/foo", "/foo/bar", "/foo/:id", "/:foo", "(/:foo)", "(/:foo)(/:bar)", "(/:foo(/:bar))", ".:format", ".xml", "/foo.:bar", "/foo(/:action)", "/foo(/:action)(/:bar)", "/foo(/:action(/:bar))", "*foo", "/*foo", "/bar/*foo", "/bar/(*foo)", "/sprockets.js(.:format)", "/(:locale)(.:format)"]

public func playScannerTest2() {
    var scanner: Scanner!

    print("\(cases2.count) tests:")


    for expr in cases2 {
        scanner = Scanner(expression: expr)

        var tokens: [Token] = []
        while let token = scanner.nextToken() {
            tokens.append(token)
        }

        var reGeneratedExpr = ""
        for token in tokens {
            reGeneratedExpr += token.value
        }


        print("[\(expr == reGeneratedExpr ? "Pass" : "Error")] \(expr) \(reGeneratedExpr)")
    }

    print("")
}