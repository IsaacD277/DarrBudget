//
//  Year:Month Picker.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/30/24.
//
//  Source: https://gamma-point.com/2023/03/21/how-to-create-a-month-year-picker-in-swiftui/
//

import SwiftUI

// Date extension to extract year and month
extension Date {
    func year() -> Int {
        return Calendar.current.component(.year, from: self)
    }

    func monthName() -> String {
        let monthIndex = Calendar.current.component(.month, from: self) - 1
        return Calendar.current.shortMonthSymbols[monthIndex]
    }
}

struct YearMonthPickerView: View {
    @Binding var selectedDate: Date
    
    let months: [String] = Calendar.current.shortMonthSymbols
    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]
    
    var body: some View {
        VStack {
            // Year picker
            HStack {
                Image(systemName: "chevron.left")
                    .frame(width: 24.0)
                    .onTapGesture {
                        var dateComponent = DateComponents()
                        dateComponent.year = -1
                        selectedDate = Calendar.current.date(byAdding: dateComponent, to: selectedDate)!
                        print(selectedDate)
                    }
                
                Text("\(selectedDate.year())") // Fixed the issue by extracting year
                    .fontWeight(.bold)
                    .transition(.move(edge: .trailing))
                
                Image(systemName: "chevron.right")
                    .frame(width: 24.0)
                    .onTapGesture {
                        var dateComponent = DateComponents()
                        dateComponent.year = 1
                        selectedDate = Calendar.current.date(byAdding: dateComponent, to: selectedDate)!
                        print(selectedDate)
                    }
            }
            .padding(15)
            
            // Month picker
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(months, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .frame(width: 60, height: 33)
                        .bold()
                        .background(item == selectedDate.monthName() ? Color(.blue) : Color(.gray))
                        .cornerRadius(8)
                        .onTapGesture {
                            var dateComponent = DateComponents()
                            dateComponent.day = 1
                            dateComponent.month = months.firstIndex(of: item)! + 1
                            dateComponent.year = selectedDate.year()
                            print(item)
                            selectedDate = Calendar.current.date(from: dateComponent)!
                            print(selectedDate)
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}


//#Preview {
//    YearMonthPickerView()
//}
