//: Playground - noun: a place where people can play

import Foundation

//: Scanner Test
//playScannerTest1()
//playScannerTest2()


let expr1 = "/articles(/page/:page(/per_page/:per_page))(/sort/:sort)(.:format)"
let tokens1 = Scanner.tokenize(expr1)
print(tokens1)

let expr2 = "/articles/new"
let tokens2 = Scanner.tokenize(expr2)
print(tokens2)

let expr3 = "/articles/:id"
let tokens3 = Scanner.tokenize(expr3)
print(tokens3)

let handler: RouteVertex.HandlerType = { _ in
    print("terminal")
}

var route = parse(tokens1, terminalHandler: handler)
route = parse(tokens2, context: route, terminalHandler: handler)
route = parse(tokens3, context: route, terminalHandler: handler)

print(route.debugDescription)
