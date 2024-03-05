//
//  testView.swift
//  coffeeTest
//
//  Created by Landon West on 3/4/24.
//

import SwiftUI

struct testView: View {
    
    @State private var selectedLetter = ""
    @State private var selection = ""
    @State private var words: [String] = []
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    @State private var randomLetters = ""
    
    @State private var success = true
    
    @State private var score = 0
    @State private var scoreIncrement = 0
    @State private var showIncrement = false
    
    private var wordValidator = WordValidator()
    
    var body: some View {
    
        VStack {
            
            VStack(spacing: 3) {
                
                    ZStack {
                        Text(String(score))
                            .font(.system(size: 50))
                            .frame(width: 150)
                        
                        if showIncrement {
                            Text("+" + String(scoreIncrement))
                                .font(.system(size: 25))
                                .offset(CGSize(width: 100, height: 0))
                                .transition(.scale)
                        }
                    }
                    .fontDesign(.rounded)
                    .fontWeight(.semibold)
                    .shadow(radius: 10)
                
                HStack {
                    ZStack {
                        Text(selection)
                        if selection.count != 0 {
                            HStack {
                                Spacer()
                                Button {
                                    selection = String(selection.dropLast(1))
                                    selectedLetter = ""
                                } label: {
                                    Image(systemName: "delete.backward.fill")
                                        .resizable()
                                        .frame(width: 30, height: 25)
                                        .foregroundStyle(.white)
                                }
                                .padding(.top, 15)
                                .padding(30)
                            }
                        }
                        
                        Image(systemName: "fireworks")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .symbolEffect(.appear, isActive: success)
                            .symbolEffect(.bounce, value: success)
                    }
                }
                .font(.system(size: 75))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .shadow(radius: 10)
                .frame(height: 100)
                
//                Rectangle()
//                    .frame(width: CGFloat(selection.count) * 40, height: 5)
            }
            .frame(height: 100)
            .padding()
            
            ZStack {
                
                Image(systemName: "circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 50)
                    .foregroundStyle(.brown)
                
                Image(systemName: "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal, 50)
                    .fontWeight(.thin)
                    .shadow(radius: 10)
                
                    Text(randomLetters[0])
                    .font(.system(size: 75))
                    .shadow(color: .white, radius: selectedLetter == randomLetters[0] ? 10 : 0)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .rotationEffect(Angle(degrees: -30))
                        .offset(CGSize(width: -60, height: -60))
                        .shadow(radius: 10)
                        .onTapGesture {
                            addLetter(letter: randomLetters[0])
                        }
                    
                    Text(randomLetters[1])
                        .font(.system(size: 75))
                        .shadow(color: .white, radius: selectedLetter == randomLetters[1] ? 10 : 0)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .rotationEffect(Angle(degrees: -10))
                        .offset(CGSize(width: -75, height: 20))
                        .shadow(radius: 10)
                        .onTapGesture {
                            addLetter(letter: randomLetters[1])
                        }
                    
                    Text(randomLetters[2])
                        .font(.system(size: 75))
                        .shadow(color: .white, radius: selectedLetter == randomLetters[2] ? 10 : 0)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .rotationEffect(Angle(degrees: 15))
                        .offset(CGSize(width: 40, height: -60))
                        .shadow(radius: 10)
                        .onTapGesture {
                            addLetter(letter: randomLetters[2])
                        }
                    
                    Text(randomLetters[3])
                        .font(.system(size: 75))
                        .shadow(color: .white, radius: selectedLetter == randomLetters[3] ? 10 : 0)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .rotationEffect(Angle(degrees: -10))
                        .offset(CGSize(width: 75, height: 15))
                        .shadow(radius: 10)
                        .onTapGesture {
                            addLetter(letter: randomLetters[3])
                        }
                    
                    Text(randomLetters[4])
                        .font(.system(size: 75))
                        .shadow(color: .white, radius: selectedLetter == randomLetters[4] ? 10 : 0)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .rotationEffect(Angle(degrees: 15))
                        .offset(CGSize(width: 0, height: 75))
                        .shadow(radius: 10)
                        .onTapGesture {
                            addLetter(letter: randomLetters[4])
                        }
                
            }
            
            ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(words, id: \.self) { word in
                                Text(word)
                                    .font(.system(size: 20))
                                    .fontDesign(.rounded)
                                    .fontWeight(.semibold)
                                    .shadow(radius: 10)
                            }
                        }
                        .padding(.horizontal, 15)
            }
            .ignoresSafeArea()
            .frame(height: 200)
        }
        .onAppear() {
            let sequenceGenerator = RandomLetterSequence()
            randomLetters =  sequenceGenerator.randomLetter(vowelsNeeded: 2, consonantsNeeded: 3)
        }
        .onTapGesture {
            selectedLetter = ""
        }
        .transition(.scale)
        .preferredColorScheme(.dark)
    }
    
    func addLetter(letter: String) {
        if selection.count > 4 {
            return
        }
        
        selectedLetter = letter
        selection += selectedLetter
        
        if selection.count > 2 && !words.contains(selection) {
            wordValidator.isWordValid(selection) { isValid in
                if isValid {
                    scoreIncrement = 100 + Int(pow(Double(5), Double(selection.count)))
                    score += scoreIncrement
                    withAnimation {
                        showIncrement.toggle()
                    }
                    words.append(selection)
                    selection = ""
                    selectedLetter = ""
                    success.toggle()   
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.33) {
                        selection = ""
                        selectedLetter = ""
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.66) {
                            success.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            showIncrement.toggle()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    testView()
}
