//
//  SerachConnectionView.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct SearchConnectionView: View {
    @EnvironmentObject var dotsModel: DotsModel
    @State var name: String = ""
    
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
                List {
                    ForEach(dotsModel.networkingPeople) { person in
                        CustomConnectionList(entity: person)
                    }
                    .onDelete(perform: removeConnection)
                    .padding(.top,15)
                }
                .listStyle(.plain)
               
            }
        }
        
    }
}

extension SearchConnectionView {
    func removeConnection(at offsets: IndexSet) {
        dotsModel.deleteConnection(offsets: offsets)
    }
}
