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
    
    @State private var success = true
    
    var body: some View {
        
        
        VStack {
            
            VStack(spacing: 3) {
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
                            .symbolEffect(.appear, isActive: success)
                            .symbolEffect(.bounce, value: success)
                    }
                }
                .font(.system(size: 75))
                .fontDesign(.rounded)
                .fontWeight(.semibold)
                .shadow(radius: 10)
                
//                Rectangle()
//                    .frame(width: CGFloat(selection.count) * 40, height: 5)
            }
            .frame(height: 100)
            
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
                
                    Text("a")
                    .font(.system(size: 75))
                    .shadow(color: .white, radius: selectedLetter == "a" ? 10 : 0)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .rotationEffect(Angle(degrees: -30))
                        .offset(CGSize(width: -60, height: -60))
                        .shadow(radius: 10)
                        .onTapGesture {
                            addLetter(letter: "a")
                        }
                    
                    Text("c")
                        .font(.system(size: 75))
                        .shadow(color: .white, radius: selectedLetter == "c" ? 10 : 0)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .rotationEffect(Angle(degrees: -10))
                        .offset(CGSize(width: -75, height: 20))
                        .shadow(radius: 10)
                        .onTapGesture {
                            addLetter(letter: "c")
                        }
                    
                    Text("t")
                        .font(.system(size: 75))
                        .shadow(color: .white, radius: selectedLetter == "t" ? 10 : 0)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .rotationEffect(Angle(degrees: 15))
                        .offset(CGSize(width: 40, height: -60))
                        .shadow(radius: 10)
                        .onTapGesture {
                            addLetter(letter: "t")
                        }
                    
                    Text("p")
                        .font(.system(size: 75))
                        .shadow(color: .white, radius: selectedLetter == "p" ? 10 : 0)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .rotationEffect(Angle(degrees: -10))
                        .offset(CGSize(width: 75, height: 15))
                        .shadow(radius: 10)
                        .onTapGesture {
                            addLetter(letter: "p")
                        }
                    
                    Text("n")
                        .font(.system(size: 75))
                        .shadow(color: .white, radius: selectedLetter == "n" ? 10 : 0)
                        .fontDesign(.rounded)
                        .fontWeight(.semibold)
                        .rotationEffect(Angle(degrees: 15))
                        .offset(CGSize(width: 0, height: 75))
                        .shadow(radius: 10)
                        .onTapGesture {
                            addLetter(letter: "n")
                        }
                
            }
            
            ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(words, id: \.self) { word in
                                Text(word)
                                    .font(.system(size: 25))
                                    .fontDesign(.rounded)
                                    .fontWeight(.semibold)
                                    .shadow(radius: 10)
                            }
                        }
                        .padding() // Add padding around the grid for better appearance
            }
            .frame(height: 150)
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
            isWordValid(selection) { isValid in
                if isValid {
                    words.append(selection)
                    selection = ""
                    selectedLetter = ""
                    success.toggle()                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.66) {
                            success.toggle()
                    }
                }
            }
        }
    }
    
    func isWordValid(_ word: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)") else {
            completion(false)
            return
        }
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                // If the API returns a 200 status code, the word is valid.
                completion(true)
            } else {
                // If the status code is not 200, the word might not be valid.
                completion(false)
            }
        }
        
        task.resume()
    }
}

#Preview {
    testView()
}
