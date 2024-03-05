//
//  settingsView.swift
//  coffeeTest
//
//  Created by Landon West on 3/4/24.
//

import SwiftUI

struct settingsView: View {
    
    @Binding var yesCoffee: Bool
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section {
                    Toggle("i don't like coffee", isOn: $yesCoffee)
                }
            }
            .font(.system(size: 25))
            .fontDesign(.rounded)
            .fontWeight(.semibold)
            .shadow(radius: 10)            
        }
        .scrollDisabled(true)
        .presentationDetents([.medium])
        .preferredColorScheme(.dark)
        .tint(.brown)
    }
}

#Preview {
    @State var yes = false
    return settingsView(yesCoffee: $yes)
}
