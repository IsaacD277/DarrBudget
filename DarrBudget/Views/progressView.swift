////
////  progressView.swift
////  DarrBudget
////
////  Created by Isaac D2 on 10/8/24.
////
//
//import SwiftUI
//
//struct progressView: View {
//    @State private var step: Int = 1
//    let max: Int
//    
//    init(_ max: Int) {
//        self.max = max
//    }
//    
//    @State private var date: String = ""
//    @State private var amount: String = ""
//    @State private var merchant: String = ""
//    @State private var account: String = ""
//    @State private var bucket: String = ""
//    @State private var notes: String = ""
//    @FocusState private var isActive: Field?
//    
//    enum Field {
//        case dateField
//        case amountField
//        case merchantField
//        case accountField
//        case bucketField
//        case notesField
//    }
//    
//    var body: some View {
//        VStack {
//            ZStack {
//                ForEach(1...max, id: \.self) { index in
//                    if index == 1 {
//                        Text("Begin adding a transaction")
//                            .padding(.vertical, 10)
//                            .padding(.horizontal, 15)
//                            .frame(width: 300)
//                            .background(.fill, in: .rect(cornerRadius: 12))
//                            .offset(x: step == index ? 0 : step > index ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
//                            .animation(.spring(.smooth), value: step)
//                    } else if index == 2 {
//                        TextField("Date", text: $date)
//                            .padding(.vertical, 10)
//                            .padding(.horizontal, 15)
//                            .frame(width: 300)
//                            .background(.fill, in: .rect(cornerRadius: 12))
//                            .focused($isActive, equals: .nameField)
//                            .keyboardType(.alphabet)
//                            .autocorrectionDisabled()
//                            .offset(x: step == index ? 0 : step > index ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
//                            .animation(.spring(.smooth), value: step)
//                    } else if index == 3 {
//                        TextField("Amount", text: $amount)
//                            .padding(.vertical, 10)
//                            .padding(.horizontal, 15)
//                            .frame(width: 300)
//                            .background(.fill, in: .rect(cornerRadius: 12))
//                            .focused($isActive, equals: .amountField)
//                            .keyboardType(.decimalPad)
//                            .offset(x: step == index ? 0 : step > index ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
//                            .animation(.spring(.smooth), value: step)
////                    } else if index == 4 {
////                        TextField("Merchant", text: $merchant)
////                            .padding(.vertical, 10)
////                            .padding(.horizontal, 15)
////                            .frame(width: 300)
////                            .background(.fill, in: .rect(cornerRadius: 12))
////                            .focused($isActive, equals: .merchantField)
////                            .keyboardType(.alphabet)
////                            .autocorrectionDisabled()
////                            .offset(x: step == index ? 0 : step > index ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
////                            .animation(.spring(.smooth), value: step)
////                    } else if index == 5 {
////                        TextField("Account", text: $account)
////                            .padding(.vertical, 10)
////                            .padding(.horizontal, 15)
////                            .frame(width: 300)
////                            .background(.fill, in: .rect(cornerRadius: 12))
////                            .focused($isActive, equals: .merchantField)
////                            .keyboardType(.alphabet)
////                            .autocorrectionDisabled()
////                            .offset(x: step == index ? 0 : step > index ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
////                            .animation(.spring(.smooth), value: step)
////                        } else if index == 6 {
////                            TextField("Bucket", text: $bucket)
////                                .padding(.vertical, 10)
////                                .padding(.horizontal, 15)
////                                .frame(width: 300)
////                                .background(.fill, in: .rect(cornerRadius: 12))
////                                .focused($isActive, equals: .bucketField)
////                                .keyboardType(.alphabet)
////                                .autocorrectionDisabled()
////                                .offset(x: step == index ? 0 : step > index ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
////                                .animation(.spring(.smooth), value: step)
////                        } else if index == 7 {
////                            TextField("Notes", text: $notes)
////                                .padding(.vertical, 10)
////                                .padding(.horizontal, 15)
////                                .frame(width: 300)
////                                .background(.fill, in: .rect(cornerRadius: 12))
////                                .focused($isActive, equals: .notesField)
////                                .keyboardType(.alphabet)
////                                .autocorrectionDisabled()
////                                .offset(x: step == index ? 0 : step > index ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
////                                .animation(.spring(.smooth), value: step)
//                    } else {
//                        Text("Step \(index)")
//                            .frame(width: 300)
//                            .offset(x: step == index ? 0 : step > index ? -UIScreen.main.bounds.width : UIScreen.main.bounds.width, y: 0)
//                            .animation(.spring(.smooth), value: step)
//                    }
//                }
//            }
//            
//            Spacer()
//        
//            HStack {
//                Button() {
//                    stepdown()
//                } label: {
//                    ZStack {
//                        Text("Back")
//                            .bold()
//                            .foregroundStyle(.white)
//                            .padding(.horizontal)
//                            .padding(.vertical, 9)
//                            .background(Capsule().fill(.blue))
//                    }
//                }
//                
//                ForEach(1...max, id: \.self) { index in
//                    Circle()
//                        .foregroundStyle(index <= step ? .blue : .gray)
//                        .frame(width: index == step ? 17 : 15)
//                        .animation(.spring(.smooth), value: step)
//                }
//                
//                Button() {
//                    stepup()
//                } label: {
//                    ZStack {
//                        Text("Next")
//                            .bold()
//                            .foregroundStyle(.white)
//                            .padding(.horizontal)
//                            .padding(.vertical, 9)
//                            .background(Capsule().fill(.blue))
//                    }
//                }
//            }
//            .padding()
//        }
//        .onChange(of: step) {
//            // Automatically focus the correct text field based on the current step
//            if step == 2 {
//                isActive = .dateField
//            } else if step == 3 {
//                isActive = .amountField
//            } else if step == 4 {
//                isActive = .merchantField
//            } else if step == 5 {
//                isActive = .accountField
//            } else if step == 6 {
//                isActive = .bucketField
//            } else if step == 7 {
//                isActive = .notesField
//            }
//        }
//    }
//    
//    func stepup() {
//        if step < max {
//            step += 1
//        } else {
//            print("No more range bro")
//        }
//    }
//    
//    func stepdown() {
//        if step > 1 {
//            step -= 1
//        } else {
//            print("No more range bro")
//        }
//    }
//}
//
//#Preview {
//    progressView(6)
//}
