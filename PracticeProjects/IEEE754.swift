//
//  IEEE754.swift
//  PracticeProjects
//
//  Created by Purnaman Rai (College) on 16/10/2025.
//

import SwiftUI

struct CustomKeyStyle: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle)
            .tint(color)
    }
}

extension View {
    func applyCustomKeyStyle(ofColor color: Color) -> some View {
        self.modifier(CustomKeyStyle(color: color))
    }
}

struct Key: View {
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .fontDesign(.monospaced)
                .fontWeight(.semibold)
                .frame(width: 50, height: 30)
        }
        .applyCustomKeyStyle(ofColor: .secondary)
    }
}

struct IEEE754: View {
    @State private var inputToConvert = ""
    
    @State private var beforeConversionText = ""
    @State private var beforeConversionTextPosition = 0.0
    @State private var beforeConversionTextSize = 25.0
    
    @State private var convertButtonPressed = false
    
    var body: some View {
        VStack {
            ZStack {
                Text(beforeConversionText)
                    .font(.system(size: beforeConversionTextSize, weight: .semibold, design: .monospaced))
                    .foregroundStyle(.secondary)
                    .offset(y: beforeConversionTextPosition)
                    .contentTransition(.numericText())
                    .onTapGesture {
                        withAnimation {
                            inputToConvert = beforeConversionText
                            beforeConversionText = ""
                        }
                    }
                
                Text(inputToConvert)
                    .font(.system(size: 25, weight: .semibold, design: .monospaced))
                    .contentTransition(.numericText())
                    .animation(.bouncy, value: inputToConvert)
            }
            .frame(height: 50)
            
            HStack {
                ForEach(1..<4) {
                    let number = String($0)
                    Key(label: number) {
                        if inputToConvert.count < 15 {
                            inputToConvert += number
                        }
                    }
                }
            }
            
            HStack {
                ForEach(4..<7) {
                    let number = String($0)
                    Key(label: number) {
                        if inputToConvert.count < 15 {
                            inputToConvert += number
                        }
                    }
                }
            }
            
            HStack {
                ForEach(7..<10) {
                    let number = String($0)
                    Key(label: number) {
                        if inputToConvert.count < 15 {
                            inputToConvert += number
                        }
                    }
                }
            }
            
            HStack {
                Key(label: ".") {
                    if inputToConvert.count < 15 {
                        inputToConvert += "."
                    }
                }
                
                Key(label: "0") {
                    if inputToConvert.count < 15 {
                        inputToConvert += "0"
                    }
                }
                
                Button {
                    if convertButtonPressed && !beforeConversionText.isEmpty {
                        inputToConvert = ""
                        beforeConversionText = ""
                        convertButtonPressed = false
                    }
                    
                    if inputToConvert.count > 0 {
                        inputToConvert.removeLast()
                    }
                } label: {
                    Image(systemName: beforeConversionText.isEmpty ? "delete.left" : "trash")
                        .fontWeight(.semibold)
                        .frame(width: 50, height: 30)
                        .contentTransition(.symbolEffect(.replace))
                }
                .applyCustomKeyStyle(ofColor: .red)
            }
            
            Button {
                withAnimation {
                    if beforeConversionText.isEmpty {
                        beforeConversionText = inputToConvert
                    }
                    
                    beforeConversionTextPosition = -50.0
                    beforeConversionTextSize = 15.0
                    
                    convertButtonPressed = true
                }
                
                // Temporary Value To Show
                var convertedValueSample = ""
                for i in 0..<inputToConvert.count {
                    if i % 2 == 0 {
                        convertedValueSample += "1"
                    } else {
                        convertedValueSample += "0"
                    }
                }
                inputToConvert = convertedValueSample
                
            } label: {
                Text("CONVERT")
                    .font(.system(size: 16, weight: .semibold, design: .monospaced))
                    .frame(width: 212, height: 30)
            }
            .buttonStyle(.borderedProminent)
            .applyCustomKeyStyle(ofColor: .green)
        }
    }
}

#Preview {
    IEEE754()
}
