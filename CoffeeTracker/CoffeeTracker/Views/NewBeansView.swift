//
//  NewBeansView.swift
//  CoffeeTracker
//
//  Created by Jay Wilson on 2/21/22.
//

import SwiftUI
import PhotosUI
import CoreData

struct NewBeansView: View {

    private enum Field {
        case name
        case style
        case roaster
    }

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var beanOO: NewBeanOO

    @State var beans = BeanModel(name: "",
                                 style: "",
                                 buyAgain: false,
                                 roaster: "",
                                 roastedOn: Date(),
                                 boughtOn: Date(),
                                 notes: "",
                                 beanType: "beans",
                                 image: UIImage())

    @State private var isImageSelected = false
    @State private var selectedPhoto: PhotosPickerItem?

    @FocusState private var focusField: Field?

    var isEdit = false
    var onAdded: () -> Void = {}

    let beanTypes = ["pods", "beans", "grounds"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Design.base*2) {
                Section("Bean Information") {
                    HStack(spacing: 10) {
                        PhotosPicker(selection: $selectedPhoto, matching: .images) {
                            if isImageSelected {
                                Image(uiImage: beanOO.coffee.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: Design.base*10, height: Design.base*10, alignment: .center)
                            } else {
                                Image(systemName: SFSymbols.photo)
                                    .font(.system(size: 75))
                            }
                        }
                        VStack {
                            TextField("Name", text: $beanOO.coffee.name)
                                .textFieldStyle(.roundedBorder)
                                .focused($focusField, equals: .name)
                            TextField("Style", text: $beanOO.coffee.style)
                                .textFieldStyle(.roundedBorder)
                                .focused($focusField, equals: .style)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Bean Type")
                        Picker("Bean Type", selection: $beanOO.coffee.beanType) {
                            ForEach(beanTypes, id: \.self) { type in
                                Text(type.capitalized)
                            }
                        }.pickerStyle(.segmented)
                            .padding(.bottom, Design.base*2)
                    }
                }
                Section("Roaster Information") {
                    DatePicker("Roasted On",
                               selection: $beanOO.coffee.roastedOn,
                               displayedComponents: .date)
                    TextField("Roaster", text: $beanOO.coffee.roaster)
                        .textFieldStyle(.roundedBorder)
                        .focused($focusField, equals: .roaster)
                        .padding(.bottom, Design.base*2)
                }
                Section("Purchase Information") {
                    DatePicker("Purchased on",
                               selection: $beanOO.coffee.boughtOn,
                               displayedComponents: .date)
                    if isEdit {
                        HStack {
                            Text("Would buy again?")
                            Spacer()
                            HStack {
                                Button("Yes") {
                                    beanOO.coffee.buyAgain = true
                                }.padding()
                                    .foregroundColor(beanOO.yesButtonFGColor)
                                    .background(beanOO.yesButtonBGColor)
                                    .cornerRadius(24)
                                Button("No") {
                                    beanOO.coffee.buyAgain = false
                                }.padding()
                                    .foregroundColor(beanOO.noButtonFGColor)
                                    .background(beanOO.noButtonBGColor)
                                    .cornerRadius(24)
                            }
                        }
                    }
                }
                Section("Notes") {
                    TextEditor(text: $beanOO.coffee.notes)
                        .frame(height: 100.0)
                        .cornerRadius(10)
                }

            }.padding()

        }.background(.thinMaterial)
        .task(id: selectedPhoto) {
            guard let selectedPhoto,
                  let data = try? await selectedPhoto.loadTransferable(type: Data.self),
                  let image = UIImage(data: data) else { return }
            beanOO.coffee.image = image
            isImageSelected = true
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel", role: .close) {
                    if !isEdit {
                        Analytics.coffeeAddCancelled.send()
                    }
                    dismiss()
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save", role: .confirm) {
                    save()
                }
            }
        }
    }

    func save() {
        if beanOO.coffee.name.isEmpty {
            focusField = .name
        } else if beanOO.coffee.style.isEmpty {
            focusField = .style
        } else if beanOO.coffee.roaster.isEmpty {
            focusField = .roaster
        } else {
            if isEdit {
                beanOO.coffee.updateBean(context: viewContext)
                Analytics.coffeeEdited.send()
                dismiss()
            } else {
                beanOO.coffee.addBeansToData(context: viewContext)
                Analytics.coffeeAdded(beanOO.coffee).send()
                onAdded()
                resetBeans()
                dismiss()
            }
            focusField = nil // dismisses keyboard
        }
    }

    func resetBeans() {
        beanOO.coffee = BeanModel(name: "",
                          style: "",
                          buyAgain: false,
                          roaster: "",
                          roastedOn: Date(),
                          boughtOn: Date(),
                          notes: "",
                          beanType: "",
                          image: UIImage())
    }
}

#Preview {
    NavigationStack {
        NewBeansView(isEdit: true)
    }
}
