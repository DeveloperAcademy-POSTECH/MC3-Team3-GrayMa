//
//  SerachConnectionView.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct SerachConnectionView: View {
    @State var name: String = ""
    var names: [String] = ["신채은","신채은","신채은","신채은"]
    var companys: [String] = ["토스,LG U+","삼성전자","POSCO","OP.GG","카카오뱅크"]
    var jobs: [String] = ["ios개발","ios개발","안드로이드 개발","ios 개발","ios 개발","ios개발"]
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    Spacer()
                    NavigationLink(destination: EmptyView()) {
                        Image(systemName: "plus")
                            .frame(width: 30,height: 34)
                            .foregroundColor(.black)
                    }
                    .padding(.trailing,20)
                }
                
                RoundedRectangle(cornerRadius: 40)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .shadow(radius: 2)
                    .foregroundColor(.white)
                    .overlay() {
                        HStack {
                            Button {
                                print("검색기능 예정")
                            } label: {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.black)
                            }
                            .padding(.leading,14)
                            TextField("이름 검색", text: $name)
                            Spacer()
                            if(name.count >= 1) {
                                Button {
                                    name = ""
                                } label: {
                                    Text("\(Image(systemName: "x.circle.fill"))")
                                        .foregroundColor(.gray)
                                        .frame(width: 24,height: 24)
                                        .padding(.trailing,5)
                                }
                            }
                            Button {
                                print("ㅇ")
                            } label: {
                                Circle()
                                    .strokeBorder(Color.gray,lineWidth: 1.5)
                                    .frame(width: 36,height: 36)
                                    .foregroundColor(.white)
                                    .overlay(){
                                        Image(systemName: "slider.vertical.3")
                                            .foregroundColor(.black)
                                    }
                            }
                            .padding(.trailing,9)
                        }
                    }
                    .padding(.horizontal,16)
                ScrollView{
                    ForEach(names.indices,id: \.self) {i in
                        CustomConnectionList(name: names[i], company: companys[i], job: jobs[i], strengths: ["논리적 사고", "Core Data"])
                        
                    }
                    .padding(.top,15)
                    
                }
               
            }
        }
        
    }
}

struct SerachConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        SerachConnectionView()
    }
}
