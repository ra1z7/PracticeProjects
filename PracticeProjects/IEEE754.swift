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
                .frame(width: 25, height: 30)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle)
        .tint(.secondary)
    }
}

struct IEEE754: View {
    @State private var display = ""
    @State private var displayCopy = ""
    @State private var displayMove = false
    
    var body: some View {
        VStack {
            ZStack {
                Text(displayCopy)
                    .font(.system(size: displayMove ? 15 : 25, weight: .semibold, design: .monospaced))
                    .animation(.bouncy, value: displayCopy)
                    .contentTransition(.numericText())
                    .padding()
                    .offset(y: displayMove ? -50 : 0)
                
                Text(display)
                    .font(.system(size: 25, weight: .semibold, design: .monospaced))
                    .animation(.bouncy, value: display)
                    .contentTransition(.numericText())
                    .padding()
            }
            
            HStack {
                ForEach(1..<4) {
                    let number = String($0)
                    Key(label: number) {
                        display += number
                        displayCopy += number
                    }
                }
            }
            
            HStack {
                ForEach(4..<7) {
                    let number = String($0)
                    Key(label: number) {
                        display += number
                        displayCopy += number
                    }
                }
            }
            
            HStack {
                ForEach(7..<10) {
                    let number = String($0)
                    Key(label: number) {
                        display += number
                        displayCopy += number
                    }
                }
            }
            
            HStack {
                Key(label: ".") { display += "." }
                Key(label: "0") { display += "0" }
                Button {
                    if display.count > 0 {
                        display.removeLast()
                        displayCopy.removeLast()
                    }
                    
                    if display.count == 0 {
                        displayMove = false
                    }
                } label: {
                    Image(systemName: "delete.left")
                        .fontWeight(.semibold)
                        .frame(width: 25, height: 30)
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
                .tint(.secondary)
                .onLongPressGesture(minimumDuration: 2) {
                    display = ""
                    displayCopy = ""
                }
            }
            
            Button {
                withAnimation {
                    displayMove = true
                }
                
                var newDisplay = ""
                for i in 0..<display.count {
                    if i % 2 == 0 {
                        newDisplay += "1"
                    } else {
                        newDisplay += "0"
                    }
                }
                
                display = newDisplay
            } label: {
                Text("CONVERT")
                    .font(.subheadline)
                    .fontWidth(.expanded)
                    .fontDesign(.monospaced)
                    .frame(width: 138)
            }
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(.borderedProminent)
                .tint(.green)
        }
    }
}

#Preview {
    IEEE754()
}
