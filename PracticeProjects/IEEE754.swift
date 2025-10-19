//
//  IEEE754.swift
//  PracticeProjects
//
//  Created by Purnaman Rai (College) on 16/10/2025.
//

import SwiftUI

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
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle)
        .tint(.secondary)
    }
}

struct IEEE754: View {
    @State private var inputToConvert = ""
    
    @State private var beforeConversionText = ""
    @State private var convertButtonPressed = false
    
    var body: some View {
        VStack {
            ZStack {
                Text(beforeConversionText)
                    .font(.system(size: convertButtonPressed ? 15 : 25, weight: .semibold, design: .monospaced))
                    .foregroundStyle(.secondary)
                    .contentTransition(.numericText())
                    .offset(y: convertButtonPressed ? -50 : 0)
                    .onTapGesture {
                        withAnimation {
                            convertButtonPressed = false
                            inputToConvert = beforeConversionText
                            beforeConversionText = ""
                        }
                    }
                
                Text(inputToConvert)
                    .font(.system(size: 25, weight: .semibold, design: .monospaced))
                    .animation(.bouncy, value: inputToConvert)
                    .contentTransition(.numericText())
                    .padding()
            }
            
            HStack {
                ForEach(1..<4) {
                    let number = String($0)
                    Key(label: number) {
                        inputToConvert += number
                    }
                }
            }
            
            HStack {
                ForEach(4..<7) {
                    let number = String($0)
                    Key(label: number) {
                        inputToConvert += number
                    }
                }
            }
            
            HStack {
                ForEach(7..<10) {
                    let number = String($0)
                    Key(label: number) {
                        inputToConvert += number
                    }
                }
            }
            
            HStack {
                Key(label: ".") {
                    inputToConvert += "."
                }
                
                Key(label: "0") {
                    inputToConvert += "0"
                }
                
                Button {
                    beforeConversionText = ""
                    
                    if inputToConvert.count > 0 {
                        inputToConvert.removeLast()
                    }
                } label: {
                    Image(systemName: "delete.left")
                        .fontWeight(.semibold)
                        .frame(width: 50, height: 30)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
                .tint(.secondary)
            }
            
            HStack {
                Button {
                    withAnimation {
                        convertButtonPressed = true
                        beforeConversionText = inputToConvert
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
                        .frame(width: 132, height: 30)
                }
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(.borderedProminent)
                .tint(.green)
                
                Button {
                    inputToConvert = ""
                    beforeConversionText = ""
                } label: {
                    Image(systemName: "trash")
                        .fontWeight(.semibold)
                        .frame(width: 50, height: 30)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
                .tint(.red)
            }
        }
    }
}

#Preview {
    IEEE754()
}
