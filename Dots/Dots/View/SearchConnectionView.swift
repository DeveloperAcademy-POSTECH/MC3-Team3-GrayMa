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
    
    //필터를 통해 검색이 가능하게 해주는 변수
    @State var isFilterd: Bool = false
    @Binding var companyName: String
    @Binding var jobName: String
    @Binding var strengthName: String
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBar
                    .actionSheet(isPresented: $actionSheetvisible){
                        AddContactActionSheet
                    }
                    .sheet(isPresented: $isFilterSheetOn, content: {
                        SearchFilterView(isFilterd: $isFilterd)
                    })
                
                if isFilterd {
                    FilteredPerson
                }
                else {
                    if  isKeyboardVisible && (name.isEmpty || dotsModel.networkingPeople.filter { person in
                        if let name = person.name {
                            return name.range(of: self.name) != nil || self.name.isEmpty
                        } else {
                            return false
                        }
                    }.isEmpty) {
                        // 검색 결과가 없을때 최근 검색 표시
                        SearchHistory
                    } else {
                        ScrollView {
                            SearchResultContacts
                        }
                    }
                }
            }
            .background(Color.theme.bgPrimary)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        actionSheetvisible = true
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 22)
                            .foregroundColor(.theme.gray5Dark)
                    }

                }
            }
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
                //                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notification in
                //                        isKeyboardVisible = true
                //                    }
                //
                //                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                //                        Notification in isKeyboardVisible = false
                //                    }
                
                selectedHistoryList = loadRecentSearches(keyName: keyName)
                
            }
            .onDisappear {
                NotificationCenter.default.removeObserver(self)
            }
        }
    }
}


// MARK: - Components
extension SearchConnectionView {
    private var SearchBar: some View {
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
                        saveSearch(name: name, selectedHistoryList: &selectedHistoryList, keyName: "recentSearchName")
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
    }
    
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
    
    private var FilteredPerson: some View {
        ScrollView {
            if FilteredList.isEmpty {
                RoundedRectangle(cornerRadius: 12)
                    .overlay {
                        Text("검색 결과가 없습니다.")
                    }
            } else {
                ForEach(FilteredList, id: \.self)
                { person in
                    RoundedRectangle(cornerRadius: 12)
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
                        .overlay(content: {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.theme.gray5, lineWidth: 2)
                        })
                        .cornerRadius(12, corners: .allCorners)
                }
                .padding(.horizontal, 16)
                
            }
        }
    }
    
    private var SearchResultContacts: some View {
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
                .foregroundColor(.theme.bgPrimary)
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
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.theme.gray5, lineWidth: 2)
                })
                .cornerRadius(12, corners: .allCorners)
        }
        .padding(.horizontal, 16)
    }
    
    private var AddContactActionSheet: ActionSheet {
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
}


//MARK: functions
extension SearchConnectionView {
    private var FilteredList: [NetworkingPersonEntity] {
        return dotsModel.networkingPeople.filter { person in
            let hasJob = person.job?.contains(jobName) ?? false
            let hasStrength = person.strengthSet?.allObjects.contains { (strengthObject: Any) -> Bool in
                if let strength = strengthObject as? StrengthEntity {
                    return strength.strengthName?.contains(strengthName) ?? false
                }
                return false
            } ?? false
            let hasCompany = person.company?.contains(companyName) ?? false
            
            return hasJob || hasStrength || hasCompany
        }
    }
    
    
    func removeConnection(at offsets: IndexSet) {
        dotsModel.deleteConnection(offsets: offsets)
    }
    
    // MARK: 유저디폴트 값에 저장 하는 함수
    func saveSearch(name: String, selectedHistoryList: inout [String], keyName: String) {
        guard !name.isEmpty else { return }
        selectedHistoryList.insert(name, at: 0)
        if selectedHistoryList.count > 5 {
            selectedHistoryList.removeLast()
        }
        UserDefaults.standard.set(selectedHistoryList, forKey: keyName)
    }
    // MARK: 유저디폴트 값을 State배열에 대입 하고 불러와주는 함수
    func loadRecentSearches(keyName: String) -> [String] {
        if let savedSearches = UserDefaults.standard.array(forKey: keyName) as? [String] {
            return savedSearches
        } else {
            return []
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
