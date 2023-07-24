//
//  SearchFilterDetailView.swift
//  Dots
//
//  Created by 정승균 on 2023/07/23.
//

import SwiftUI

struct SearchHistoryRowModel: Hashable {
    var title: String
    var isSelected: Bool
}

// MARK: - body
struct SearchFilterDetailView: View {
    @State var searchTextField: String = ""
    @State var selectedHistoryList: [String] = []
    @Binding var isSheetOn: Bool
    let type: String
    
    @State var searchHistory: [SearchHistoryRowModel] = [
        .init(title: "토스트", isSelected: false),
        .init(title: "토스", isSelected: false),
        .init(title: "네이버", isSelected: false),
        .init(title: "LG", isSelected: false),
        .init(title: "우아한 형제들", isSelected: false)
    ]
    @State var selectedOpacityValue: Double = 0.6
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar
                
                SearchHistory
                
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
                        print("완료 ㄱㄱ")
                    }
                }
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
                    ZStack {
                        TextField("\(type) 검색", text: $searchTextField)
                        SelectedBadges
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
                }
            } label: {
                ZStack {
                    Rectangle()
                        .frame(height: 44)
                        .foregroundColor(listRowColor(opacity: history.isSelected ? 0.6 : 0))
                    
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
    
    private var SelectedBadges: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(selectedHistoryList, id: \.self) { history in
                        HStack {
                            Text(history)
                                .modifier(regularBody(colorName: .white))
                                .padding(.trailing, 10)
                            Button {
                                deleteSelectedHistory(historyName: history)
                            } label: {
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal, 18)
                        .padding(.vertical, 9)
                        .background(Color.accentColor)
                        .cornerRadius(12, corners: .allCorners)
                    }
                }
            }
        }
    }
}

// MARK: - Function
extension SearchFilterDetailView {
    func listRowColor(opacity: Double) -> Color {
        return Color(red: 235/255, green: 235/255, blue: 245/255, opacity: opacity)
    }
    
    func selectAction(history: SearchHistoryRowModel) {
        if history.isSelected {
            selectedHistoryList.append(history.title)
        } else {
            guard let idx = selectedHistoryList.firstIndex(of: history.title) else { return }
            selectedHistoryList.remove(at: idx)
        }
        
        checkArray()
    }
    
    func checkArray() {
        if selectedHistoryList.isEmpty {
            searchTextField = ""
        } else {
            searchTextField = " "
        }
    }
    
    func deleteSelectedHistory(historyName: String) {
        guard let selectedIdx = selectedHistoryList.firstIndex(of: historyName) else { return }
        guard let historyIdx = searchHistory.firstIndex(where: { $0.title == historyName }) else { return }
                
        selectedHistoryList.remove(at: selectedIdx)
        searchHistory[historyIdx].isSelected = false
    }
}

struct SearchFilterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilterDetailView(isSheetOn: .constant(true), type: "회사")
    }
}
