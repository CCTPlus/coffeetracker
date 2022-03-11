//
//  NewBeansView.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI
import Photos

struct NewBeansView: View {
    enum Field {
        case name
        case style
        case roaster
        case notes
    }

    @Environment(\.managedObjectContext) private var viewContext
    @Binding var showForm: Bool

    @State var beans = BeanModel(name: "",
                                  style: "",
                                  buyAgain: false,
                                  roaster: "",
                                  roastedOn: Date(),
                                  boughtOn: Date(),
                                 notes: "", image: UIImage())

    @State private var isImageSelected = false
    @State var selectedImage = UIImage()
    @State private var showingPhotoPicker = false
    @FocusState private var focusedField: Field?

    var isEdit = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
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
                                    print("IDK WHAT HAPPENED")
                                }
                            }
                        } label: {
                            if isImageSelected {
                                Image(uiImage: beans.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100, alignment: .center)
                            } else {
                                Image(systemName: SFSymbols.photo)
                                    .font(.system(size: 75))
                            }
                        }
                        VStack {
                            TextField("Name", text: $beans.name)
                                .textFieldStyle(.roundedBorder)
                                .focused($focusedField, equals: .name)
                            TextField("Style", text: $beans.style)
                                .textFieldStyle(.roundedBorder)
                                .focused($focusedField, equals: .style)
                        }
                    }
                }
                Section("Roaster Information") {
                    DatePicker("Roasted On",
                               selection: $beans.roastedOn,
                               displayedComponents: .date)
                    TextField("Roaster", text: $beans.roaster)
                        .textFieldStyle(.roundedBorder)
                        .focused($focusedField, equals: .roaster)
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
                        if isEdit {
                            beans.updateBean(context: viewContext)
                        } else {
                            beans.addBeansToData(context: viewContext)
                            resetBeans()
                        }
                        focusedField = nil
                        showForm = false
                    } label: {
                        Text("Save").padding(.horizontal, 30)
                    }.buttonStyle(BorderedButtonStyle())
                        .background(Color.green)
                        .cornerRadius(5)
                        .tint(.white)
                    Spacer()
                }

            }.padding()
            Spacer()
        }.background(.ultraThickMaterial).sheet(isPresented: $showingPhotoPicker) {
                                ImagePicker(selectedImage: $beans.image, isImageSelected: $isImageSelected)
        }
            .onDisappear {
                focusedField = nil
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
                          image: UIImage())
    }
}

struct NewBeansView_Previews: PreviewProvider {
    static var previews: some View {
        NewBeansView(showForm: Binding(projectedValue: .constant(true)))
    }
}
