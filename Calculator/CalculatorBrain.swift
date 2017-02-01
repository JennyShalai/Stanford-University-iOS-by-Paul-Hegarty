//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jenny Shalai on 1/22/17.
//  Copyright © 2017 shalai. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    
    private var internalProgram = [AnyObject]()
    
    var result: Double {
        get {
            return accumulator
        }
    }
    
    typealias PropertyList = AnyObject
    
    var program: PropertyList {
        get {
            return internalProgram as CalculatorBrain.PropertyList
        }
        set {
            clear()
            if let arrayOfOps = newValue as? [AnyObject] {
                for op in arrayOfOps {
                    if let operand = op as? Double {
                        setOperand(operand: operand)
                    } else if let operation = op as? String {
                        performOperation(symbol: operation)
                    }
                }
            }
        }
    }
    
    func clear() {
        accumulator = 0.0
        pending = nil
        internalProgram.removeAll()
    }
    
    func setOperand(operand: Double) {
        accumulator = operand
        internalProgram.append(operand as AnyObject)
    }
    
    private var operations = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.Unary(sqrt),
        "cos": Operation.Unary(cos),
        "x": Operation.Binary({ $0 * $1 }),
        "+": Operation.Binary({ $0 + $1 }),
        "-": Operation.Binary({ $0 - $1 }),
        "÷": Operation.Binary({ $0 / $1 })
    ]
    
    private enum Operation {
        case Constant(Double)
        case Unary((Double) -> Double)
        case Binary((Double, Double) -> Double)
        case Equals
    }
    
    
    
    func performOperation(symbol: String) {
        internalProgram.append(symbol as AnyObject)
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let associatedVal):
                accumulator = associatedVal
            case .Unary(let function):
                accumulator = function(accumulator)
            case .Binary(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo.init(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
        }
    }
    
    private var pending: PendingBinaryOperationInfo?

    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
}


//class Operation {
//
//    private var unaryFunc: (Double) -> Double = nil
//    private var binaryFunc: (Double, Double) -> Double = nil
//    
//    init(funct: @escaping (Double, Double) -> Double) {
//        self.binaryFunc = funct
//    }
//    
//    init(funct: @escaping (Double) -> Double) {
//        self.unaryFunc = funct
//    }
//}
