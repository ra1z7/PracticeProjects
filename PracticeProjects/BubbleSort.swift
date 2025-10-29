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
    
    var body: some View {
        Text("\(number)")
            .frame(width: 20, height: 20)
            .padding(10)
            .background(.secondary.opacity(0.2))
            .foregroundStyle(.primary)
            .clipShape(.rect(cornerRadius: 15))
            .font(.system(size: 12, weight: .bold, design: .monospaced))
    }
}

struct BubbleSort: View {
    @State private var numbersToSort = [29, 10, 14, 37, 13, 47, 1]
    @State private var sortingState = ""
    
    var body: some View {
        Text(sortingState)
            .font(.system(size: 16, design: .monospaced))
            .foregroundStyle(.secondary)
            .frame(width: 170, height: 50)
            .contentTransition(.numericText())
            .animation(.default, value: sortingState)
        
        HStack {
            ForEach(numbersToSort, id: \.self) { number in
                ColoredNumber(number: number)
            }
        }
        
        HStack {
            Button("Sort") {
                Task {
                    sortingState = "Sorting..."
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
                            sortingState = "Sorting Complete"
                            allNumbersSorted = true
                        }
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
            
            Button("Shuffle") {
                withAnimation {
                    sortingState = ""
                    numbersToSort.shuffle()
                }
            }
            .buttonStyle(.bordered)
            .tint(.orange)
        }
        .padding()
    }
}

#Preview {
    BubbleSort()
}
