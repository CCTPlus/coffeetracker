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
                                Image(uiImage: beans.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: Design.base*10, height: Design.base*10, alignment: .center)
                            } else {
                                Image(systemName: SFSymbols.photo)
                                    .font(.system(size: 75))
                            }
                        }
                        VStack {
                            TextField("Name", text: $beans.name)
                                .textFieldStyle(.roundedBorder)
                                .focused($focusField, equals: .name)
                            TextField("Style", text: $beans.style)
                                .textFieldStyle(.roundedBorder)
                                .focused($focusField, equals: .style)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text("Bean Type")
                        Picker("Bean Type", selection: $beans.beanType) {
                            ForEach(beanTypes, id: \.self) { type in
                                Text(type.capitalized)
                            }
                        }.pickerStyle(.segmented)
                            .padding(.bottom, Design.base*2)
                    }
                }
                Section("Roaster Information") {
                    DatePicker("Roasted On",
                               selection: $beans.roastedOn,
                               displayedComponents: .date)
                    TextField("Roaster", text: $beans.roaster)
                        .textFieldStyle(.roundedBorder)
                        .focused($focusField, equals: .roaster)
                        .padding(.bottom, Design.base*2)
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
                        if beans.name.isEmpty {
                            focusField = .name
                        } else if beans.style.isEmpty {
                            focusField = .style
                        } else if beans.roaster.isEmpty {
                            focusField = .roaster
                        } else {
                            if isEdit {
                                beans.updateBean(context: viewContext)
                                dismiss()
                            } else {
                                beans.addBeansToData(context: viewContext)
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
            ImagePicker(selectedImage: $beans.image, isImageSelected: $isImageSelected)
        }
    }

    func resetBeans() {
        beans = BeanModel(name: "",
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
