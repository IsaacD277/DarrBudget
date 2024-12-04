//
//  addTransactionTEST.swift
//  DarrBudget
//
//  Created by Isaac D2 on 10/31/24.
//

import SwiftUI
import SwiftData

struct addTransactionTEST: View {
    @Environment(\.modelContext) var modelContext
    @Query var objects: [PaymentMethod]
    
    var modelDescriptor: FetchDescriptor<PaymentMethod> {
        let predicate = #Predicate<PaymentMethod> {
            $0.name.contains(input)
        }
        return FetchDescriptor<PaymentMethod>(predicate: predicate, sortBy: [SortDescriptor(\PaymentMethod.name)])
    }
    
    @State private var input: String = ""
    
    var body: some View {
        VStack {
            TextField("Test", text: $input)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: input) {
                    // This will re-trigger the filtering whenever the account changes
                    print("Searching for payment method with name: \(input)")
                }
            
            DynamicQuery(modelDescriptor) { models in
                ChipStack {
                    ForEach(models) { model in
                        ChipView()
                    }
                }
            }
            
            Button("Add") {
                let temp = objects.first { $0.name == input }
                
                if temp == nil {
                    print("No match found")
                    modelContext.insert(PaymentMethod(input))
                }
            }
        }
        .padding()
    }
}



#Preview {
    addTransactionTEST()
}
