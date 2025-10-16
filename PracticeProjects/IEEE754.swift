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
    
    var body: some View {
        VStack {
            Text(display)
                .font(.system(size: 25, weight: .semibold, design: .monospaced))
                .animation(.bouncy, value: display)
                .contentTransition(.numericText())
                .padding()
            
            HStack {
                ForEach(1..<4) {
                    let number = String($0)
                    Key(label: number) {
                        display += number
                    }
                }
            }
            
            HStack {
                ForEach(4..<7) {
                    let number = String($0)
                    Key(label: number) {
                        display += number
                    }
                }
            }
            
            HStack {
                ForEach(7..<10) {
                    let number = String($0)
                    Key(label: number) {
                        display += number
                    }
                }
            }
            
            HStack {
                Key(label: ".") { display += "." }
                Key(label: "0") { display += "0" }
                Button {
                    if display.count > 0 {
                        display.removeLast()
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
                }
            }
        }
    }
}

#Preview {
    IEEE754()
}
