//
//  BubbleSort.swift
//  PracticeProjects
//
//  Created by Purnaman Rai (College) on 28/10/2025.
//

import SwiftUI

struct ColoredNumber: View, Identifiable {
    let id = UUID()
    let number: Int
    let color = Color(
        red: .random(in: 0...1),
        green: .random(in: 0...1),
        blue: .random(in: 0...1)
    )
    
    var body: some View {
        Text("\(number)")
            .frame(width: 20, height: 20)
            .padding(10)
            .background(color.gradient.opacity(0.8))
            .foregroundStyle(.white)
            .shadow(radius: 10)
            .clipShape(.rect(cornerRadius: 15))
            .font(.system(size: 12, weight: .bold, design: .monospaced))
    }
}

struct BubbleSort: View {
    @State private var numbersToSort = [29, 10, 14, 37, 13, 47, 1]
    
    var body: some View {
        HStack {
            ForEach(numbersToSort, id: \.self) { number in
                ColoredNumber(number: number)
            }
        }
        
        Button("Sort") {
            Task {
                var allNumbersSorted = false
                
                while !allNumbersSorted {
                    var sortedCount = 0
                    
                    for i in 0..<numbersToSort.count - 1 {
                        if numbersToSort[i] < numbersToSort[i + 1] {
                            sortedCount += 1
                            continue
                        } else {
                            let temp = numbersToSort[i]
                            withAnimation {
                                numbersToSort[i] = numbersToSort[i + 1]
                                numbersToSort[i + 1] = temp
                            }
                            
                            try? await Task.sleep(for: .seconds(1))
                        }
                    }
                    
                    if sortedCount == numbersToSort.count - 1 {
                        allNumbersSorted = true
                    }
                }
            }
        }
    }
}

#Preview {
    BubbleSort()
}
