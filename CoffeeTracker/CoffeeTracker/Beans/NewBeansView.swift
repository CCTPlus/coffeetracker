//
//  NewBeansView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI

struct NewBeansView: View {
    @State var beans = BeanModel(name: "",
                                  style: "",
                                  buyAgain: false,
                                  roaster: "",
                                  roastedOn: Date(),
                                  boughtOn: Date(),
                                  notes: "")
    var body: some View {
        Form {
            Section("Roast Information") {
                TextField("Name", text: $beans.name)
                TextField("Style", text: $beans.style)
            }
            Section("Roaster Information") {
                DatePicker("Roasted On",
                           selection: $beans.roastedOn,
                           displayedComponents: .date)
                TextField("Roaster", text: $beans.roaster)
            }
            Section("Purchase Information") {
                DatePicker("Purchased on",
                           selection: $beans.boughtOn,
                           displayedComponents: .date)
                HStack {
                    Text("Would buy again?")
                    Spacer()
                    HStack {
                        Button("Yes") {
                            beans.buyAgain = true
                        }.padding()
                            .foregroundColor(beans.buyAgain == false ? Color.accentColor : Color.primary)
                            .background(beans.buyAgain == true ? Color.accentColor : Color.clear)
                        Button("No") {
                            beans.buyAgain = false
                        }.padding()
                        .foregroundColor(beans.buyAgain == true ? Color.accentColor : Color.primary)
                        .background(beans.buyAgain == false ? Color.accentColor : Color.clear)
                        .cornerRadius(5)
                    }
                }
            }
            Section("Notes") {
                TextEditor(text: $beans.notes)
            }
            HStack{
                Spacer()
                Button {
                    print("SAVE")
                } label: {
                    Text("Save").padding(.horizontal, 30)
                }.buttonStyle(BorderedButtonStyle())
                    .foregroundColor(.primary)
                    .background(Color.green)
                    .cornerRadius(5)
                Spacer()
            }.listRowBackground(Color.clear)

        }
    }
}

struct NewBeansView_Previews: PreviewProvider {
    static var previews: some View {
        NewBeansView()
    }
}
