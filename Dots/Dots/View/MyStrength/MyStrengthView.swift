//
//  MyStrengthView.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct MyStrengthView: View {
    
    @EnvironmentObject var dotsModel: DotsModel
    @State var showModal = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                ScrollView {
                    if dotsModel.myStrength.isEmpty {
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.theme.disabled, lineWidth: 1.5)
                            .foregroundColor(.theme.bgPrimary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 84)
                            .overlay() {
                                HStack {
                                    Text("저장된 강점이 없습니다.")
                                        .modifier(regularBody(colorName: .theme.gray))
                                        .padding(.leading, 29)
                                    
                                    Spacer()
                                }
                            }
                            .padding(.horizontal, 16)
                        
                    } else {
                        ForEach(dotsModel.myStrength, id: \.self) { strength in
                            CustomList(entity: strength)
                                .padding(.horizontal, 16)
                        }
                    }
                }
                .padding(.top, 22)
            }
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("내 강점")
                        .modifier(boldTitle1(colorName: .theme.gray5Dark))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { self.showModal = true }) {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 22)
                            .foregroundColor(.theme.gray5Dark)
                            
                        
                    }
                }
            })
            .sheet(isPresented: $showModal){
                StrengthModal()
                    .presentationDetents([.height(UIScreen.main.bounds.height * 0.4)])
            }
            .background(Color.theme.bgMain)
            
        }
        .background(.gray)
        .navigationTitle("강점")
        
    }
}

struct MyStrengthView_Previews: PreviewProvider {
    static var previews: some View {
        MyStrengthView()
            .environmentObject(DotsModel())
    }
}
