//
//  NewBeansView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI

struct NewBeansView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var showForm: Bool

    @State var beans = BeanModel(name: "",
                                  style: "",
                                  buyAgain: false,
                                  roaster: "",
                                  roastedOn: Date(),
                                  boughtOn: Date(),
                                  notes: "")
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Section("Bean Information") {
                    TextField("Name", text: $beans.name)
                        .textFieldStyle(.roundedBorder)
                    TextField("Style", text: $beans.style)
                        .textFieldStyle(.roundedBorder)
                }
                Section("Roaster Information") {
                    DatePicker("Roasted On",
                               selection: $beans.roastedOn,
                               displayedComponents: .date)
                    TextField("Roaster", text: $beans.roaster)
                        .textFieldStyle(.roundedBorder)
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
                                .cornerRadius(5)
                            Button("No") {
                                beans.buyAgain = false
                            }.padding()
                            .foregroundColor(beans.buyAgain == true ? Color.accentColor : Color.primary)
                            .background(beans.buyAgain == false ? Color.accentColor : Color.clear)
                            .cornerRadius(5)
                        }
                    }
                }
                HStack{
                    Spacer()
                    Button {
                        beans.addBeansToData(context: viewContext)
                        showForm = false
                        beans = BeanModel(name: "",
                                          style: "",
                                          buyAgain: false,
                                          roaster: "",
                                          roastedOn: Date(),
                                          boughtOn: Date(),
                                          notes: "")
                    } label: {
                        Text("Save").padding(.horizontal, 30)
                    }.buttonStyle(BorderedButtonStyle())
                        .background(Color.green)
                        .cornerRadius(5)
                        .tint(.white)
                    Spacer()
                }

            }.padding()
        }.background(.ultraThickMaterial)
    }
}

struct NewBeansView_Previews: PreviewProvider {
    static var previews: some View {
        NewBeansView(showForm: Binding(projectedValue: .constant(true)))
    }
}
