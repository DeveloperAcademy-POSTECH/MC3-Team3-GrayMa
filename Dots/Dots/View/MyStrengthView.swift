//
//  MyStrengthView.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct MyStrengthView: View {
    @State var levelList: [String] = []
    @State var strengthList : [String] = []
    @State var showModal = false
    var body: some View {
        NavigationStack{
            VStack {
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 282)
                    .padding(.horizontal,16)
                    .shadow(radius: 2)
                ScrollView{
                    if levelList.count == 0{
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
                    else{
                        ForEach(strengthList.indices,id: \.self){index in
                            CustomList(imageName: levelList[index], strength: strengthList[index])
                        }
                    }
                    
                }
                
                
            }
            .navigationBarItems(leading: HStack { Text("강점").font(.system(size: 24)) })
            .navigationBarItems(trailing: HStack { Button(action: { self.showModal = true }) { Image(systemName: "plus").foregroundColor(.black) } })
            .sheet(isPresented: $showModal){
                StrengthModal(levelList: $levelList, strengthList: $strengthList)
                    .presentationDetents([.height(UIScreen.main.bounds.height * 0.25)])
            }
            
        }
        .background(.gray)
        .navigationTitle("강점")
        
    }
}

struct MyStrengthView_Previews: PreviewProvider {
    static var previews: some View {
        MyStrengthView()
    }
}
