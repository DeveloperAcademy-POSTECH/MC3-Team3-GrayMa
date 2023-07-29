//
//  ContactsCompanyField.swift
//  Dots
//
//  Created by Kim Andrew on 2023/07/26.
//

import SwiftUI

struct ContactsCompanyField: View {
    
    //CompanyField가 가져야할 변수
    @Binding var UserInputCompany : String
    
    //모달 컨트롤 변수
    @State var modalControl = false
    
    //input error 핸들링
    @State var inputError = false
    @State var textColor = Color.theme.gray
    @State var fieldColor = Color("bgBlank")
    let errorMessage = "회사 적어"
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text("회사")
                .foregroundColor(textColor)
            
            ZStack {
                //외각 디자인
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(fieldColor)
                    .frame(width: 361, height: 56)
                    .onTapGesture { modalControl = true }
                    .sheet(isPresented: $modalControl){
                        CompanyModalView(searchTextField: $UserInputCompany)
                    }
                
                HStack{
                    
                    //돋보기 보양
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                    
                    Text("\(UserInputCompany)")
                    
                    Spacer()
                    
                    if !UserInputCompany.isEmpty {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .foregroundColor(Color.theme.alertGreen)
                            .frame(width: 24, height: 24)
                            .onAppear{
                                fieldColor = Color("secondary")
                            }
                    }
                }
                .frame(width: 340)
            }
            
            //모달에서 직무가 하나라도 있는지 리턴 받아야함
            if inputError {
                Text("\(errorMessage)")
                    .foregroundColor(textColor)
                    .opacity(inputError ? 1 : 0)
            }
        }
    }
}


//직업 모달뷰
struct CompanyModalView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dotsModel: DotsModel
    
    @Binding  var searchTextField : String
    @State private var selectedHistoryList: String = ""
    @State private var searchHistory: [SearchHistoryRowModel] = []
    
    // 중복된 값들을 필터링 해서 저장하는 배열
    private var uniqueCompanies: [String] {
        // Use Set to get unique company names and convert it back to an array
        let uniqueCompanySet = Set(dotsModel.networkingPeople.compactMap { $0.company })
        return Array(uniqueCompanySet)
    }
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
                SearchBar
                ExistCompanyList
                Spacer()
            }
            
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        presentationMode.wrappedValue.dismiss()
                        print("취소 ㄱㄱ")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("완료") {
                        presentationMode.wrappedValue.dismiss()
                        //knowFilter()
                        //                        print("\(type) 타입")
                        //                        print("\(companyName) 회사이름")
                        //                        print("\(jobName)  직무이름")
                        //                        print("\(strengthName) 강점이름" )
                        print("완료 ㄱㄱ")
                    }
                }
            }
            .onAppear {
                
                searchHistory = loadRecentSearches(keyName: "recentCompany")
                
            }
        }
    }
}

extension CompanyModalView {
    private var SearchBar: some View {
        RoundedRectangle(cornerRadius: 40)
            .stroke(Color.gray, lineWidth: 0.5)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .overlay {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .scaledToFit()
                        .frame(width: 29)
                        .padding(.trailing, 11)
                        .padding(.leading, 14)
                    VStack {
                        TextField("회사 검색", text: $searchTextField, onCommit: {
                            saveSearch(name: searchTextField, keyName: "recentCompany")
                            selectedHistoryList.append(searchTextField)
                        })
                    }
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 32)
    }
    
    private var ExistCompanyList: some View {
        ScrollView {
            VStack(spacing: 0) {
                if searchTextField.isEmpty || uniqueCompanies.filter({ $0.range(of: searchTextField, options: .caseInsensitive) != nil }).isEmpty {
                    SearchHistory
                } else {
                    ForEach(uniqueCompanies.filter { $0.range(of: searchTextField, options: .caseInsensitive) != nil }, id: \.self) { company in
                        Button {
                            withAnimation(.easeIn(duration: 0.1)) {
                                searchTextField = company
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .frame(height: 44)
                                    .foregroundColor(.theme.secondary)
                                    .opacity(company == searchTextField ? 1 : 0)
                                
                                HStack {
                                    Text(company)
                                        .modifier(semiBoldCallout(colorName: .black))
                                        .padding(.leading, 33)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "checkmark")
                                        .padding(.trailing, 47)
                                        .opacity(company == searchTextField ? 1 : 0)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    private var SearchHistory: some View {
        ForEach(Array(searchHistory.enumerated()), id: \.element) { index, history in
            Button {
                withAnimation(.easeIn(duration: 0.1)) {
                    searchTextField = history.title
                }
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 44)
                        .foregroundColor(.theme.secondary)
                        .opacity(history.title == searchTextField ? 1 : 0)
                    
                    HStack {
                        Text(history.title)
                            .modifier(semiBoldCallout(colorName: .black))
                            .padding(.leading, 33)
                        
                        Spacer()
                        
                        Image(systemName: "checkmark")
                            .padding(.trailing, 47)
                            .opacity(history.title == searchTextField ? 1 : 0)
                    }
                }
            }
        }
    }
    
}

extension CompanyModalView {
    
    func saveSearch(name: String, keyName: String) {
        guard !name.isEmpty else { return }
        
        let newHistory = SearchHistoryRowModel(title: searchTextField, isSelected: false)
        searchHistory.append(newHistory)
        if searchHistory.count > 5 {
            searchHistory.removeFirst()
        }
        UserDefaults.standard.set(searchHistory.map {$0.title}, forKey: keyName)
    }
    
    // MARK: 유저디폴트 값을 State배열에 대입 하고 불러와주는 함수
    func loadRecentSearches(keyName: String) -> [SearchHistoryRowModel] {
        if let savedSearches = UserDefaults.standard.array(forKey: keyName) as? [String] {
            return savedSearches.map { SearchHistoryRowModel(title: $0, isSelected: false) }
        } else {
            return []
        }
    }
    
    func filterJob() {
        if  (searchTextField.isEmpty || dotsModel.networkingPeople.filter { person in
            if let name = person.company {
                return name.range(of: self.searchTextField) != nil || self.searchTextField.isEmpty
            } else {
                return false
            }
        }.isEmpty) {
        }
    }
}
