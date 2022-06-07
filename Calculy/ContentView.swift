//
//  ContentView.swift
//  Calculy
//
//  Created by Victor Colen on 03/06/22.
//

import SwiftUI

struct ContentView: View {
    @State private var errorMessage = ""
    @State private var showError = false
    @State private var result = ""
    
    @State private var a = 0
    @State private var b = 0
    @State private var c = 0
    @State private var d = 0
    @State private var n = 0
    @State private var m = 0
    @State private var q = 1
    @State private var lmtBaixo = 0
    @State private var lmtCima = 1
    @State private var array = [0, 0, 0]
    @State private var num = ""
    @State private var deno = ""
    @State private var numAux = "3x"
    @State private var denoAux = "(x + 1)(x + 2)"
    @State private var tmp = ""
    @State private var numA = ""
    @State private var numB = ""
    @State private var numC = ""
    @State private var partes = ["", "", ""]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 40) {
                HStack {
                    ZStack(alignment: .trailing) {
                        Image(uiImage: UIImage(named: "integral")!)
                            .resizable()
                            .frame(width: 100, height: 100)
                        
                        VStack(alignment: .trailing, spacing: 50) {
                            TextField("1", value: $lmtCima, format: .number)
                                .frame(width: 20)
                            TextField("0", value: $lmtBaixo, format: .number)
                                .frame(width: 20)
                        }
                    }
                    
                    VStack {
                        TextField("3x", text: $numAux)
                            .multilineTextAlignment(.center)
                        Rectangle()
                            .fill(.black)
                            .frame(height: 3)
                        TextField("(x + 1)(x + 2)", text: $denoAux)
                            .multilineTextAlignment(.center)
                    }
                    
                    Text("dx")
                        .italic()
                }
                .padding()
                
                Button {
                    
                    if higherBoundIsLowerThanLowerBound() {
                        errorMessage = "Limite superior é menor que o limite inferior"
                        showError = true
                    } else {
                        
                        num = numAux.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "X", with: "x")
                        deno = denoAux.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "X", with: "x")
                        
                        if Calculator.hasParenthesis(s: deno) == false {
                            deno = Calculator.fatorar(s: &deno)
                        }
                        
                        //Extrai as constantes do numerador
                        for i in 0..<num.count {
                            if i != 0 && num[i] == "x" {
                                q = Int(num[0..<i])!
                            }
                            if num[i] == "+" || num[i] == "-" {
                                a = Int(num[i..<num.count])!
                                break
                            } else {
                                a = 0
                            }
                        }
                        
                        // Extrai as constantes do denominador
                        n = 0
                        tmp = deno.replacingOccurrences(of: "x", with: "")
                        for i in 0..<tmp.count {
                            if tmp[i] == "(" {
                                m = i + 1
                            } else if m != 0 && tmp[i] == ")" {
                                array[n] = Int(tmp[m..<i])!
                                n += 1
                                m = 0
                            }
                        }
                        
                        b = array[0]
                        c = array[1]
                        d = array[2]
                        
                        // Separar cada par de parenteses do denominador
                        
                        n = 0
                        for i in 0..<deno.count {
                            if deno[i] == "(" {
                                m = i
                            } else if deno[i] == ")" {
                                partes[n] = deno[m...i]
                                n += 1
                            }
                        }
                        
                        tmp = ""
                        
                        //Calcula o número referente a A
                        
                        m = a - (b * q)
                        
                        if d == 0 {
                            n = c - b
                        } else {
                            n = (c - b) * (d - b)
                        }
                        
                        if m != 0 || !(partes[0].isEmpty) {
                            if n < 0 {
                                n *= -1
                                m *= -1
                            }
                            if n == 0 {
                                numA = String(m)
                            } else if m % n == 0 {
                                numA = String(m/n)
                            } else {
                                numA = "\(m)/\(n)"
                            }
                            if m > 0 {
                                numA = " + \(numA)"
                            }
                            tmp += "\(numA)*ln\(partes[0]) "
                        }
                        
                        // Calcula o número referente a B
                        m = a - (c * q)
                        
                        if d == 0 {
                            n = b - c
                        } else {
                            n = (b - c) * (d - c)
                        }
                        
                        if m != 0 || !(partes[1].isEmpty) {
                            if n < 0 {
                                n *= -1
                                m *= -1
                            }
                            if n == 0 {
                                numB = String(m)
                            } else if m % n == 0 {
                                numB = String(m/n)
                            } else {
                                numB = "\(m)/\(n)"
                            }
                            if m > 0 {
                                numB = " + \(numB)"
                            }
                            tmp += "\(numB)*ln\(partes[1]) "
                        }
                        
                        // Calcula o número referente a C
                        
                        if !(partes[2].isEmpty) {
                            m = a - (d * q)
                            n = (b - d) * (c - d)
                            
                            if m != 0 {
                                if n < 0 {
                                    n *= -1
                                    m *= -1
                                }
                                
                                if n == 0 {
                                    numC = String(m)
                                } else if m % n == 0 {
                                    numC  = String(m / n)
                                } else {
                                    numC = "\(m)/\(n)"
                                    if m >= 0 {
                                        numC = "+ \(numC)"
                                    }
                                }
                                if m > 0 {
                                    numC = " + \(numC)"
                                }
                                
                                tmp += "\(numC) *ln\(partes[2]) "
                            }
                        }
                        
                        // Calculo do limite
                        
                        if lmtCima != 0 || lmtBaixo != 0 {
                            tmp = ""
                            array[0] = Calculator.calcular(
                                s: partes[0].replacingOccurrences(
                                    of: "x", with: String(lmtCima)
                                )
                            )
                            
                            array[1] = Calculator.calcular(
                                s: partes[1].replacingOccurrences(
                                    of: "x",
                                    with: String(lmtCima)
                                )
                            )
                            
                            if !(partes[2].isEmpty) {
                                array[2] = Calculator.calcular(s: partes[2].replacingOccurrences(of: "x", with: String(lmtCima)))
                            }
                            
                            if array[0] != 0 {
                                tmp += "\(numA)*ln(\(array[0]))"
                            }
                            if array[1] != 0 {
                                tmp += "\(numB)*ln(\(array[1]))"
                            }
                            if array[2] != 0 {
                                tmp += "\(numC)*ln(\(array[0]))"
                            }
                            
                            array[0] = Calculator.calcular(s: partes[0].replacingOccurrences(of: "x", with: String(lmtBaixo)))
                            array[1] = Calculator.calcular(s: partes[1].replacingOccurrences(of: "x", with: String(lmtBaixo)))
                            
                            if !partes[2].isEmpty {
                                array[2] = Calculator.calcular(s: partes[2].replacingOccurrences(of: "x", with: String(lmtBaixo)))
                            }
                            
                            tmp += "- ("
                            if array[0] != 0 {
                                tmp += "\(numA)*ln(\(array[0]))"
                            }
                            if array[1] != 0 {
                                tmp += "\(numB)*ln(\(array[1]))"
                            }
                            if array[2] != 0 {
                                tmp += "\(numC)*ln(\(array[0]))"
                            }
                            
                            tmp += ") "
                        }
                        result = "\(tmp) + C"
                    }
                    
                } label: {
                    Text("Calcular")
                        .foregroundColor(.white)
                        .padding()
                        .background(.blue)
                        .cornerRadius(16)
                }
                
                Text("Seu resultado é:")
                Text(result)
                    .font(.headline)
            }
            .navigationTitle("Calculy")
            .alert("Ocorreu um erro", isPresented: $showError) {
                
            } message: {
                Text(errorMessage)
            }
        }
        
    }
    
    func higherBoundIsLowerThanLowerBound() -> Bool {
        return Int(exactly: lmtCima)! < Int(exactly: lmtBaixo)!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
