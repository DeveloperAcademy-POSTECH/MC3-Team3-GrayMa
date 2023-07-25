//
//  SearchFilterDetailView.swift
//  Dots
//
//  Created by 정승균 on 2023/07/23.
//

import SwiftUI
import UIKit

struct SearchHistoryRowModel: Hashable {
    var title: String
    var isSelected: Bool
    
    init(title: String, isSelected: Bool) {
        self.title = title
        self.isSelected = isSelected
    }
}

// MARK: - body
struct SearchFilterDetailView: View {
    @EnvironmentObject var dotsModel: DotsModel
    
    @State private var searchTextField: String = ""
    @State private var selectedHistoryList: String = ""
    @State private var searchHistory: [SearchHistoryRowModel] = []
    @State private var selectedOpacityValue: Double = 0.6
    
    @Binding var isSheetOn: Bool
    @Binding var companyName: String
    @Binding var jobName: String
    @Binding var strengthName: String
    @Binding var type: String
    @Binding var keyName : String

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar
                if  (searchTextField.isEmpty || dotsModel.networkingPeople.filter { person in
                    if let name = person.job {
                        return name.range(of: self.searchTextField) != nil || self.searchTextField.isEmpty
                    } else {
                        return false
                    }
                }.isEmpty) {
                    SearchHistory
                }
                else {
                    //MARK: 리스트 예정
                }
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        isSheetOn = false
                        print("취소 ㄱㄱ")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("완료") {
                        isSheetOn = false
                        knowFilter()
                        print("\(type) 타입")
                        print("\(companyName) 회사이름")
                        print("\(jobName)  직무이름")
                        print("\(strengthName) 강점이름" )
                        print("완료 ㄱㄱ")
                    }
                }
            }
            .onAppear {

                searchHistory = loadRecentSearches(keyName: keyName)
                
            }
        }
    }
}

// MARK: - Components
extension SearchFilterDetailView {
    
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
                        TextField("\(type) 검색", text: $searchTextField, onCommit: {
                            saveSearch(name: searchTextField, keyName: keyName)
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
    
    private var SearchHistory: some View {
        ForEach(Array(searchHistory.enumerated()), id: \.element) { index, history in
            Button {
                withAnimation(.easeIn(duration: 0.1)) {
                    searchHistory[index].isSelected.toggle()
                    selectAction(history: searchHistory[index])
                    searchTextField = history.title
                }
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 44)
                        .foregroundColor(.theme.secondary)
                        .opacity(history.isSelected ? 1 : 0)
                    
                    HStack {
                        Text(history.title)
                            .modifier(semiBoldCallout(colorName: .black))
                            .padding(.leading, 33)
                        
                        Spacer()
                        
                        Image(systemName: "checkmark")
                            .padding(.trailing, 47)
                            .opacity(history.isSelected ? 1 : 0)
                    }
                }
            }
        }
    }
    
//    private var SelectedBadges: some View {
//        HStack {
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack {
//                    ForEach(selectedHistoryList, id: \.self) { history in
//                        HStack(spacing: 0) {
//                            Text(history)
//                                .modifier(regularBody(colorName: .theme.text))
//                                .padding(.trailing, 10)
//                            Button {
//                                withAnimation(.easeIn(duration: 0.1)) {
//                                    deleteSelectedHistory(historyName: history)
//                                }
//                            } label: {
//                                Image(systemName: "x.circle.fill")
//                                    .foregroundColor(.theme.disabled)
//                            }
//                        }
//                        .padding(.horizontal, 18)
//                        .padding(.vertical, 9)
//                        .background(Color.theme.secondary)
//                        .cornerRadius(12, corners: .allCorners)
//                    }
//                }
//            }
//        }
//    }
}

// MARK: - Function
extension SearchFilterDetailView {
    func selectAction(history: SearchHistoryRowModel) {
        if history.isSelected {
            selectedHistoryList = history.title
        } else {
            selectedHistoryList = ""
        }
        
       // checkArray()
    }
    
//    func checkArray() {
//        if selectedHistoryList.isEmpty {
//            searchTextField = ""
//        } else {
//            searchTextField = " "
//        }
//    }
    
//    func deleteSelectedHistory(historyName: String) {
//        guard let selectedIdx = selectedHistoryList.firstIndex(of: historyName) else { return }
//        guard let historyIdx = searchHistory.firstIndex(where: { $0.title == historyName }) else { return }
//
//        selectedHistoryList.remove(at: selectedIdx)
//        searchHistory[historyIdx].isSelected = false
//    }
//
    // MARK: 유저디폴트 값에 저장 하는 함수
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
    
    func filterCompany() {
        if  (searchTextField.isEmpty || dotsModel.networkingPeople.filter { person in
            if let name = person.company {
                return name.range(of: self.searchTextField) != nil || self.searchTextField.isEmpty
            } else {
                return false
            }
        }.isEmpty) {
        }
    }
    
    func knowFilter() {
        switch type {
        case "회사":
            companyName = searchTextField
            break
        case "직무":
            jobName = searchTextField
            break
        case "강점":
            strengthName = searchTextField
            break
        default:
            break
        }
    }
    
//    func filterStrength() {
//        if  (searchTextField.isEmpty || dotsModel.strength.filter { person in
//            if let name = strengt {
//                return name.range(of: self.searchTextField) != nil || self.searchTextField.isEmpty
//            } else {
//                return false
//            }
//        }.isEmpty) {
//        }
//
//    }
}

