//
//  SerachConnectionView.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI
import Contacts


struct SearchConnectionView: View {
    @EnvironmentObject var dotsModel: DotsModel
    private let keyName: String = "recentSearchName"
    @State private var name: String = ""
    @State private var selectedHistoryList: [String] = []
    @State private var recentNameKey: String = ""
    @State private var isKeyboardVisible = false
    @State private var resetSwipe: Bool = false
    @State private var trashPresented: Bool = false
    
    //actionsheet 컨트롤 변수
    @State var actionSheetvisible = false
    
    //인맥추가 navigationLink 컨트롤 변수
    @State var contactsSelectListVisible = false
    @State private var navigationActive = false
    
    // sheet 컨트롤 변수
    @State var isFilterSheetOn = false
    
//    init () {
//        _selectedHistoryList = State(initialValue: loadRecentSearches(keßyName: keyName))
//    }
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
                                //dotsModel.addExampleNetworkingPeople()
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
                            contactsSelectListVisible = true
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
                        
                        TextField("이름 검색", text: $name, onCommit: {
//                            saveSearch(name: name, selectedHistoryList: &selectedHistoryList, keyName: "recentSearchName")
                        })
                        
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
                            isFilterSheetOn = true
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
            
            if  isKeyboardVisible && (name.isEmpty || dotsModel.networkingPeople.filter { person in
                if let name = person.name {
                    return name.range(of: self.name) != nil || self.name.isEmpty
                } else {
                    return false
                }
            }.isEmpty) {
                // 검색 결과가 없을때 최근 검색 표시
                SearchHistory
            }else {
                ScrollView {
                    ForEach(dotsModel.networkingPeople.filter {
                        if let name = $0.name {
                            print(name)
                            if name.range(of: self.name) != nil || self.name.isEmpty {
                                return true
                            } else {
                                return false
                            }
                        } else {
                            return false
                        }
                    }) { person in
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 0.5)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 84)
                            .overlay() {
                                SwipeItemView(content: {
                                    NavigationLink {
                                        ConnectionDetailView(person: person)
                                    } label: {
                                        CustomConnectionList(entity: person)
                                        
                                    }
                                }, right: {
                                    HStack(spacing: 0) {
                                        Button(action: {
                                            print("삭제 완")
                                            dotsModel.deleteConnection(person: person)
                                        }, label: {
                                            Rectangle()
                                                .fill(.red)
                                                .cornerRadius(12, corners: .topRight)
                                                .cornerRadius(12, corners: .bottomRight)
                                                .overlay(){
                                                    Image(systemName: "trash.fill")
                                                        .font(.system(size: 17))
                                                        .foregroundColor(.white)
                                                }
                                        })
                                    }
                                }, itemHeight: 84, resetSwipe: $resetSwipe, trashPresented: $trashPresented)
                            }
                            .cornerRadius(12, corners: .allCorners)
                    }
                    .padding(.horizontal, 16)
                }
                
                .sheet(isPresented: $isFilterSheetOn, content: {
                    SearchFilterView()
                })
                .fullScreenCover(isPresented: $contactsSelectListVisible){
                    NavigationView{
                        ContactsSelectListView(modalControl: $contactsSelectListVisible)
                    }
                }
                .fullScreenCover(isPresented: $navigationActive) {
                    NavigationView{
                        addContactsView(modalComtrol: $navigationActive)
                    }
                    
                }
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                        isKeyboardVisible = true
                    }
                    
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                        Notification in isKeyboardVisible = false
                    }
                    
                }
                .onDisappear {
                    NotificationCenter.default.removeObserver(self)
                }
            }
        }
    }
    
    func fetchContacts() {
        let store = CNContactStore()
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch as [CNKeyDescriptor])
        
        do {
            try store.enumerateContacts(with: request) { contact, stop in
                let name = contact.familyName + contact.givenName
                print("\(name)")
            }
        } catch {
            print("Error fetching contacts: \(error)")
        }
    }
}
// MARK: Components
extension SearchConnectionView {
    private var SearchHistory: some View {
        ForEach(Array(selectedHistoryList.enumerated()), id: \.element) { index, history in
            Button {
                withAnimation(.easeIn(duration: 0.1)) {
                    name = history
                }
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 44)
                    HStack {
                        Text(history)
                            .modifier(semiBoldCallout(colorName: .black))
                            .padding(.leading, 33)
                        Spacer()
                    }
                }
            }
            .foregroundColor(.clear)
        }
    }
    
}


//struct SearchConnection_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchConnectionView()
//    }
//}
