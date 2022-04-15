//
//  CoffeeTrackerMain.swift
//  CoffeeTracker
//
//  Created by Maegan Wilson on 2/21/22.
//

import SwiftUI

struct CoffeeTrackerMain: View {
    @AppStorage("showNewView") var showNewView: Bool = true
    @AppStorage("lastSeenVersion") var version: String = "1.0"

    @Environment(\.managedObjectContext) private var viewContext

    @StateObject var navRouter: NavigationRouter

    @State private var showButtons = false
    @StateObject var beanOO = NewBeanOO(bean: nil)

    var plusRotation: Double {
        return navRouter.currentPage == .newBeans ? 45 : 0
    }

    var addButtonColor: Color {
        return navRouter.currentPage == .newBeans ? Color.red : Color.accentColor
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    switch navRouter.currentPage {
                    case .coffees:
                        CoffeeListView()
                            .popover(isPresented: $showNewView) {
                                WhatsNewView()
                                    .onDisappear {
                                        showNewView = false
                                    }
                            }
                    case .info:
                        AboutView()
                    case .newBeans:
                        NewBeansView(navRouter: navRouter)
                            .environmentObject(beanOO)
                    }
                }.onAppear {
                    let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                    guard let currentVersion = currentVersion else {
                        return
                    }
                    if currentVersion != version {
                        showNewView = true
                        version = currentVersion
                    } else {
                        showNewView = false
                        version = currentVersion
                    }
                }
                HStack(alignment: .bottom) {
                    TabBarIcon(navRouter: navRouter,
                               assignedPage: .coffees,
                               width: geometry.size.width/5,
                               height: geometry.size.height/28,
                               systemIcon: SFSymbols.list,
                               tabName: "Coffee")
                    ZStack {
                        Button {
                            if navRouter.currentPage == .newBeans {
                                navRouter.currentPage = .coffees
                            } else {
                                navRouter.currentPage = .newBeans
                            }
                        } label: {
                            Image(systemName: SFSymbols.plus)
                                .font(.largeTitle)
                                .foregroundColor(.bone)
                                .background(Circle()
                                    .fill(addButtonColor)
                                    .frame(width: geometry.size.width/7, height: geometry.size.width/7))
                                .padding(12)
                                .shadow(radius: 8, x: 4, y: 4)
                                .rotationEffect(Angle.degrees(plusRotation))
                        }.padding(20)
                            .tint(.white)
                    }
                    .offset(y: -geometry.size.height/8/2)
                    TabBarIcon(navRouter: navRouter,
                               assignedPage: .info,
                               width: geometry.size.width/5,
                               height: geometry.size.height/28,
                               systemIcon: SFSymbols.info,
                               tabName: "About")

                }.frame(width: geometry.size.width, height: geometry.size.height/8)
                    .background(.ultraThinMaterial)
            }
            .edgesIgnoringSafeArea(.bottom)
            .padding(.horizontal, -4)
        }
    }
}

struct CoffeeTrackerMain_Previews: PreviewProvider {
    static var previews: some View {
        CoffeeTrackerMain(navRouter: NavigationRouter())
    }
}
