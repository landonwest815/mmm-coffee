//
//  ContentView.swift
//  coffeeTest
//
//  Created by Landon West on 3/4/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @State private var toggle = false
    
    var body: some View {
        
        ZStack {
            if toggle {
                ZStack {
                    VStack {
                        HStack {
                            Button { 
                                withAnimation { toggle.toggle()
                                }
                            } label: {
                                Image(systemName: "mug.fill")
                                    .resizable()
                                    .frame(width: 25, height: 27.5)
                                    .padding(25)
                                    .foregroundStyle(.white)
                            }
                         Spacer()
                        }
                        Spacer()
                    }
                    testView()
                }
            } else {
                testView2(toggle: $toggle)
            }
        }
        .tint(.brown)
    }
        
}

#Preview {
    ContentView()
}
