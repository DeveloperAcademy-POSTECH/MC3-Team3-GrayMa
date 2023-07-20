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
    
    //actionsheet 컨트롤 변수
    @State var actionSheetvisible = false
    
    //인맥추가 navigationLink 컨트롤 변수
    @State var contactsSelectListvisible = false
    @State private var navigationActive = false
    
    var body: some View {
        NavigationStack {
            VStack{
                HStack {
                    Spacer()
                    NavigationLink(destination: EmptyView()) {
                        Image(systemName: "plus")
                            .frame(width: 30,height: 34)
                            .foregroundColor(.black)
                            .onTapGesture {
                                actionSheetvisible = true
                            }
                    }
                }
                .padding(.trailing,20)
            }
            .actionSheet(isPresented: $actionSheetvisible){
                ActionSheet(
                    title: Text("인맥추가"),
                    buttons: [
                        .default(Text("연락처에서 가져오기")) {
                            // Option 1 선택 시 실행할 동작
                            //MARK: 연락처 연동 필요
                            //navigationActive = true
                            contactsSelectListvisible = true
                        },
                        .default(Text("새로 입력하기")) {
                            // Option 2 선택 시 실행할 동작
                            navigationActive = true
                        },
                        .cancel(Text("취소")) {
                            // 취소 버튼 선택 시 실행할 동작
                            print("취소")
                        }
                    ]
                )
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
                    NavigationLink(destination: ConnectionDetailView(person: person)) {
                        CustomConnectionList(entity: person)
                    }
                }
                .onDelete(perform: removeConnection)
                .padding(.top,15)
            }
            .listStyle(.plain)
        }
        .fullScreenCover(isPresented: $contactsSelectListvisible){
            NavigationView{
                ContactsSelectListView()
            }
        }
        .fullScreenCover(isPresented: $navigationActive) {
            NavigationView{
                addContactsView()
            }
        }
    }
}

extension SearchConnectionView {
    func removeConnection(at offsets: IndexSet) {
        dotsModel.deleteConnection(offsets: offsets)
    }
}
