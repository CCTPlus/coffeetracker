//
//  NewBeansView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI
import Photos

struct NewBeansView: View {

    private enum Field {
        case name
        case style
        case roaster
    }

    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var beanOO: NewBeanOO

    @StateObject var navRouter: NavigationRouter

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
    @State var selectedImage = UIImage()
    @State private var showingPhotoPicker = false

    @FocusState private var focusField: Field?

    var isEdit = false

    let beanTypes = ["pods", "beans", "grounds"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Design.base*2) {
                Section("Bean Information") {
                    HStack(spacing: 10) {
                        Button {
                            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                                switch status {
                                case .notDetermined:
                                    print("Not determined")
                                case .authorized:
                                    showingPhotoPicker.toggle()
                                case .restricted:
                                    print("Restricted")
                                case .denied:
                                    print("DENIED")
                                default:
                                    print("\(status)")
                                    print("IDK WHAT HAPPENED")
                                }
                            }
                        } label: {
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
                                    .cornerRadius(5)
                                Button("No") {
                                    beanOO.coffee.buyAgain = false
                                }.padding()
                                    .foregroundColor(beanOO.noButtonFGColor)
                                    .background(beanOO.noButtonBGColor)
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
                Section("Notes") {
                    TextEditor(text: $beanOO.coffee.notes)
                        .frame(height: 100.0)
                        .cornerRadius(10)
                }
                HStack {
                    if isEdit {
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .frame(width: Design.base*10, height: Design.base*2, alignment: .center)
                        }.buttonStyle(BorderedButtonStyle())
                            .background(Color.red)
                            .cornerRadius(5)
                            .tint(.white)
                    }
                    Spacer()
                    Button {
                        if beanOO.coffee.name.isEmpty {
                            focusField = .name
                        } else if beanOO.coffee.style.isEmpty {
                            focusField = .style
                        } else if beanOO.coffee.roaster.isEmpty {
                            focusField = .roaster
                        } else {
                            if isEdit {
                                beanOO.coffee.updateBean(context: viewContext)
                                dismiss()
                            } else {
                                beanOO.coffee.addBeansToData(context: viewContext)
                                navRouter.currentPage = .coffees
                                resetBeans()
                            }
                            focusField = nil // dismisses keyboard
                        }

                    } label: {
                        Text("Save")
                            .frame(width: Design.base*10, height: Design.base*2, alignment: .center)
                    }.buttonStyle(BorderedButtonStyle())
                        .background(Color.green)
                        .cornerRadius(5)
                        .tint(.white)
                    Spacer()
                }

            }.padding()

            HStack {
                Spacer()
                    .frame(height: Design.base*13)
            }

        }.background(.thinMaterial).sheet(isPresented: $showingPhotoPicker) {
            ImagePicker(selectedImage: $beanOO.coffee.image, isImageSelected: $isImageSelected)
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

struct NewBeansView_Previews: PreviewProvider {
    static var previews: some View {
        NewBeansView(navRouter: NavigationRouter(), isEdit: true)
    }
}
