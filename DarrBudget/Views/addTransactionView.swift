//
//  addTransactionView.swift
//  DarrBudget
//
//  Created by Isaac D2 on 10/1/24.
//

import SwiftData
import SwiftUI

struct addTransactionView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var isActive: Field?
    
    @State private var name: String = ""
    // @State private var selectedDate: Date = Date.now
    @State private var date: String = "2024-12-25"
    @State private var amount: String = "420.25"
    @State private var merchant: String = "Walmart"
    @State private var account: String = "Ally"
    @State private var notes: String = "Just a taste test"
    @State private var bucket: String = "Food"
    
    @State private var step: Int = 1
    
    enum Field {
        case dateField
        case amountField
        case merchantField
        case accountField
        case bucketField
        case notesField
    }
    
    var body: some View {
        VStack {
            ZStack {
                Text("Begin adding a transaction")
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 300)
                    .background(.fill, in: .rect(cornerRadius: 12))
                    .offset(x: step == 1 ? 0 : step > 1 ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
                    .animation(.spring(.smooth), value: step)
                
                TextField("Date", text: $date)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 300)
                    .background(.fill, in: .rect(cornerRadius: 12))
                    .focused($isActive, equals: .dateField)
                    .keyboardType(.decimalPad)
                    .autocorrectionDisabled()
                    .offset(x: step == 2 ? 0 : step > 2 ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
                    .animation(.spring(.smooth), value: step)
                
                TextField("Amount", text: $amount)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 300)
                    .background(.fill, in: .rect(cornerRadius: 12))
                    .focused($isActive, equals: .amountField)
                    .keyboardType(.decimalPad)
                    .offset(x: step == 3 ? 0 : step > 3 ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
                    .animation(.spring(.smooth), value: step)
                
                TextField("Merchant", text: $merchant)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 300)
                    .background(.fill, in: .rect(cornerRadius: 12))
                    .focused($isActive, equals: .merchantField)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled()
                    .offset(x: step == 4 ? 0 : step > 4 ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
                    .animation(.spring(.smooth), value: step)
                
                TextField("Account", text: $account)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 300)
                    .background(.fill, in: .rect(cornerRadius: 12))
                    .focused($isActive, equals: .accountField)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled()
                    .offset(x: step == 5 ? 0 : step > 5 ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
                    .animation(.spring(.smooth), value: step)

                TextField("Bucket", text: $bucket)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 300)
                    .background(.fill, in: .rect(cornerRadius: 12))
                    .focused($isActive, equals: .bucketField)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled()
                    .offset(x: step == 6 ? 0 : step > 6 ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
                    .animation(.spring(.smooth), value: step)
                
                TextField("Notes", text: $notes)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .frame(width: 300)
                    .background(.fill, in: .rect(cornerRadius: 12))
                    .focused($isActive, equals: .notesField)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled()
                    .offset(x: step == 7 ? 0 : step > 7 ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
                    .animation(.spring(.smooth), value: step)
            }
            
            HStack {
                Button() {
                    stepdown()
                } label: {
                    ZStack {
                        Text("Back")
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                            .padding(.vertical, 9)
                            .background(Capsule().fill(.blue))
                    }
                }
                
                ForEach(1...7, id: \.self) { index in
                    Circle()
                        .foregroundStyle(index <= step ? .blue : .gray)
                        .frame(width: index == step ? 17 : 15)
                        .animation(.spring(.smooth), value: step)
                }
                
                Button() {
                    stepup()
                } label: {
                    ZStack {
                        Text(step == 7 ? "Submit" : "Next")
                            .bold()
                            .foregroundStyle(.white)
                            .padding(.horizontal)
                            .padding(.vertical, 9)
                            .background(Capsule().fill(.blue))
                    }
                }
            }
            .padding()
        }
        .onChange(of: step) {
            // Automatically focus the correct text field based on the current step
            if step == 2 {
                isActive = .dateField
            } else if step == 3 {
                isActive = .amountField
            } else if step == 4 {
                isActive = .merchantField
            } else if step == 5 {
                isActive = .accountField
            } else if step == 6 {
                isActive = .bucketField
            } else if step == 7 {
                isActive = .notesField
            }
        }
        .onAppear {
            isActive = .dateField
        }
    }
    
    func stepup() {
        if step < 7 {
            step += 1
        } else if step == 7 {
            sendForm()
            
            // Reset fields other than account
            name = ""
            date = ""
            amount = ""
            merchant = ""
            notes = ""
            bucket = ""
            
            step = 1
        }
    }
    
    func stepdown() {
        if step > 1 {
            step -= 1
        } else {
            print("No more range bro")
        }
    }
    
    func sendForm() {
        let parameters = [
            "submit": "Submit?usp=pp_url",
            "entry.887759140": date,
            "entry.36478665": amount,
            "entry.1081651115": bucket,
            "entry.573719413": account,
            "entry.1051143441": merchant,
            "entry.1116084257": notes
        ] as [String: Any]

        let boundary = "Boundary-\(UUID().uuidString)"
        var body = Data()
        
        // Contructing the request body
        for (key, value) in parameters {
            body += Data("--\(boundary)\r\n".utf8)
            body += Data("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8)
            body += Data("\(value)\r\n".utf8)
        }
        body += Data("--\(boundary)--\r\n".utf8)
        
        // Create request
        var request = URLRequest(url: URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSc9LHixYGaJDG9girByt4AmJwLi_gOv-Yi2OMZbBpLirANgRw/formResponse")!, timeoutInterval: Double.infinity)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = body

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            print(String(data: data, encoding: .utf8)!)
        }

        task.resume()
    }
    
    
//    func onSubmit() {
//        let decimalAmount = Decimal(string: amount)
//        let newTransaction = Transaction(name: name, date: selectedDate, amount: decimalAmount ?? 0.0, merchant: merchant, account: account, notes: notes)
//        modelContext.insert(newTransaction)
//        
//        dismiss()
//    }
}

#Preview {
    addTransactionView()
}

//CustomTextFieldWithKeyboard {
//    TextField("Transaction Amount", text: $amount)
//        .padding(.vertical, 10)
//        .padding(.horizontal, 15)
//        .frame(width: 150)
//        .background(.fill, in: .rect(cornerRadius: 12))
//        .focused($isActive)
//} keyboard: {
//    CustomNumberKeyboard(inputText: $amount, isActive: $isActive, onSubmit: onSubmit)
//}
