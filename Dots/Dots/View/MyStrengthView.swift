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
        NavigationStack{
            VStack {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 282)
                    .padding(.horizontal,16)
                    .shadow(radius: 2)
                ScrollView {
                    if dotsModel.myStrength.isEmpty {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 62)
                            .padding(.horizontal,16)
                            .overlay(){
                                HStack(alignment: .center){
                                    Text("저장된 강점이 없습니다.")
                                        .font(.system(size: 17,weight: .regular))
                                        .foregroundColor(.gray)
                                        .padding(.leading,22)
                                    Spacer()
                                }
                            }
                    }
                    else {
                        ForEach(dotsModel.myStrength, id: \.self) { strength in
                            NavigationLink {
                                MyStrengthDetailView(myStrengthEntity: strength)
                            } label: {
                                CustomList(entity: strength)
                            }
                        }
                    }
                    
                }
                
                
            }
            .navigationBarItems(leading: HStack { Text("강점").font(.system(size: 24)) })
            .navigationBarItems(trailing: HStack { Button(action: { self.showModal = true }) { Image(systemName: "plus").foregroundColor(.black) } })
            .sheet(isPresented: $showModal){
                StrengthModal()
                    .presentationDetents([.height(UIScreen.main.bounds.height * 0.4)])
            }
            
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
