//
//  testView2.swift
//  coffeeTest
//
//  Created by Landon West on 3/4/24.
//

import SwiftUI

struct testView2: View {
    
    @Binding var toggle: Bool
    @State var shouldPresentSheet = false
    @State var yesCoffee = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    ZStack {
                        Text("mmm... ")
                        + Text("coffee")
                            .strikethrough(yesCoffee, color: .brown)
                    }
                    .font(.system(size: 50))
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
                    .shadow(radius: 10)
                    
                    if yesCoffee {
                        Text("hot chocolate")
                            .font(.system(size: 50))
                            .fontDesign(.rounded)
                            .fontWeight(.semibold)
                            .shadow(radius: 10)
                            .foregroundStyle(.brown)
                            .transition(.scale)
                    }
                }
                .frame(height: 150)
                ZStack {
                    Image(systemName: "wind")
                        .resizable()
                        .frame(width: 75, height: 75)
                        .rotationEffect(.degrees(270))
                        .fontWeight(.light)
                        .opacity(0.75)
                        .shadow(radius: 10)
                    
                    HStack(spacing: 5) {
                        Image(systemName: "arrow.turn.left.down")
                            .resizable()
                            .frame(width: 15, height: 25)
                            .rotationEffect(.degrees(35))
                            .fontWeight(.regular)
                            .padding(.top, 5)
                        
                        Text("Tap Me!")
                            .font(.system(size: 20))
                            .fontDesign(.rounded)
                            .fontWeight(.semibold)
                            .shadow(radius: 10)
                            .padding(.leading, 8)
                    }
                    .offset(CGSize(width: 110, height: 30))
                }
                
                ZStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 165, height: 60)
                        .foregroundStyle(.brown)
                        .padding(.bottom, 150)
                    
                    Image(systemName: "mug.fill")
                        .resizable()
                        .frame(width: 200, height: 220)
                        .padding(.leading, 35)
                        .fontWeight(.light)
                    
                }
                .onTapGesture {
                    withAnimation {
                        toggle.toggle()
                    }
                }
                
                Text("by landon west")
                    .font(.system(size: 25))
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
                    .shadow(radius: 10)
                    .padding(25)
            }
            .offset(CGSize(width: 0, height: -25))
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                            Button {
                                shouldPresentSheet.toggle()
                            } label: {
                                Image(systemName: "gear")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                            .sheet(isPresented: $shouldPresentSheet) {
                                                print("Sheet dismissed!")
                                            } content: {
                                                settingsView(yesCoffee: $yesCoffee)
                                            }

                        }
                ToolbarItemGroup(placement: .topBarTrailing) {
                            Button {
                                print("Pressed settings")
                            } label: {
                                Image(systemName: "info.circle")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                        }
            }
        }
        .transition(.scale)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    @State var test = false
    return testView2(toggle: $test)
}
