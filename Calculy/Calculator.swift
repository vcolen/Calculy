//
//  Calculator.swift
//  Calculy
//
//  Created by Victor Colen on 04/06/22.
//

import Foundation

struct Calculator {
    static func hasParenthesis(s: String) -> Bool {
        s.contains("(")
    }
    
    static func fatorar(s: inout String) -> String {
        var array = [1, 0, 0]
        var x1, x2: Float
        var tmp: String
        var n = 0, q = 0
        
        if s[0] == "x" {
            n += 1
        }
        
        for i in 1..<s.count {
            if s[i] == "x" {
                tmp = s[q..<i]
                if tmp.count > 1 {
                    array[n] = Int(tmp)!
                } else {
                    array[n] = 1
                }
                n += 1
            } else if s[i] == "+" || s[i] == "-" {
                q = i
            }
        }
        tmp = s[q..<s.count]
        
        //Xˆ2-5x+6
        if tmp.count > 1 {
            array[n] = Int(tmp)!
        }
        
        //Calculo do delta
        n = (array[1] * array[1]) - (4 * (array[0] * array[2]))
        
        if n >= 0 {
            x1 = Float(((-1 * array[1]) + Int(sqrtf(Float(n)))) / 2 * array[0])
            x2 = Float(((-1 * array[1]) - Int(sqrtf(Float(n)))) / 2 * array[0])
            
            if x1 > 0 {
                tmp = "(x-\(Int(x1)))"
            } else {
                tmp = "(x-\(Int(-1 * x1)))"
            }
            if x2 > 0 {
                s = tmp + "(x-\(Int(x2)))"
            } else {
                s = tmp + "(x-\(Int(-1 * x2)))"
            }
        } else {
            print("Delta não possui raíz")
        }
        return s
    }
    
    static func calcular(s: String) -> Int {
        var n = 0
        let equation = s[1..<s.count-1]
        for i in stride(from: equation.count - 1, to: 0, by: -1) {
            if equation[i] == "+" {
                n = Int(equation[0..<i])! + Int(equation[i..<equation.count])!
                break
            } else if (equation[i] == "-") {
                n = Int(equation[0..<i])! - Int(equation[i+1..<equation.count])!
                break
            }
        }
        return n
    }
}
