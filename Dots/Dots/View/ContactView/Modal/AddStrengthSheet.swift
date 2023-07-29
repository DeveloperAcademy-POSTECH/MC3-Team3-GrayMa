//
//  AddStrengthSheet.swift
//  Dots
//
//  Created by 정승균 on 2023/07/28.
//

import SwiftUI

struct SearchStrengthRowModel: Hashable {
    var title: String
    var isSelected: Bool
}

struct AddStrengthSheet: View {
    @EnvironmentObject var dotsModel: DotsModel
    @State private var strengthName: String = ""
    @State private var isError: Bool = false
    @State private var isKeyboardVisible = false
    
    // 선택된 강점은 여기 다 저장
    @Binding var selectedStrength: [String]
    
    @State private var strengthList: [SearchStrengthRowModel] = []
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 19) {
                SearchBar
                    .padding(.horizontal,16)
                
                SelectedStrengthList
                
                ExistStrengthList
                
                Spacer()
            }
            // MARK: 키보드가 나타났을때를 감지
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
            .allowsTightening(true)
            .frame(width: UIScreen.main.bounds.width)
            .alert("중복에러", isPresented: $isError) {
                Button("확인") {
                    isError = false
                }
            } message: {
                Text("이미 나의 강점에 추가된 강점이거나, 존재하는 강점입니다.")
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") {
                        strengthList = []
                        presentation.wrappedValue.dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("완료") {
                        //Arr를 들고 나가야함
                        presentation.wrappedValue.dismiss()
                        
                    }
                }
            }
        }
    }
}

extension AddStrengthSheet {
    private var Title: some View {
        HStack {
            Text("강점 추가")
                .modifier(semiBoldTitle3(colorName: .theme.gray5Dark))
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 23)
        .padding(.bottom, 31)
    }
    
    private var SearchBar: some View {
        RoundedRectangle(cornerRadius: 40)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .shadow(radius: 1)
            .foregroundColor(.white)
            .overlay() {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.black)
                        .padding(.leading,14)
                    ZStack {
                        TextField("예) 디자인 시스템", text: $strengthName)
                            .onChange(of: strengthName) {
                                newvalue in if strengthName.count > 20 {
                                    strengthName = String(strengthName.prefix(20))
                                }
                            }
                            .onSubmit {
                                selectedStrength.append(strengthName)
                                isKeyboardVisible = false
                                strengthName = ""
                            }
                    }
                    
                    Spacer()
                    
                    Text("\(selectedStrength.isEmpty ? strengthName.count : selectedStrength.count)/20")
                        .modifier(regularCallout(colorName: .theme.gray))
                        .padding(.trailing,21)

                }
            }
    }
    
    private var SelectedStrengthList: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(selectedStrength, id: \.self) { strength in
                    HStack {
                        Text(strength)
                            .modifier(regularBody(colorName: .theme.text))
                            .padding(.leading, 9)
                        Button {
                            withAnimation(.easeIn(duration: 0.1)) {
                                deleteSelectedStrength(name: strength)
                            }
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24)
                                .foregroundColor(.theme.disabled)
                        }
                    }
                    .padding(.horizontal, 18)
                    .padding(.vertical, 9)
                    .background(Color.theme.secondary)
                    .cornerRadius(12, corners: .allCorners)
                }
            }
        }
        .padding(.horizontal, 16)
        .scrollIndicators(.hidden)
    }
    
    private var ExistStrengthList: some View {
        ZStack(alignment: .center) {
            // db에 있는 값들을 리스트로 띄움
            ScrollView {
                //sample에 filter를 걸어서 포함 되는 단어만 띄우는 반복문 만약 필터에 해당 되는 것이 없다면 직접 입력하라고 리턴
                if dotsModel.strength.filter({ $0.strengthName!.contains(strengthName) || strengthName.isEmpty }).isEmpty {
                    HStack {
                        Button {
                            dotsModel.addStrength(name: strengthName)
                            selectedStrength.append(strengthName)
                            getStrengthList()
                            isKeyboardVisible = false
                        } label: {
                            Label("직접 추가하기", systemImage: "plus.circle.fill")
                                .padding(.top, 18)
                                .padding(.leading, 44)
                                .modifier(regularCallout(colorName: .theme.gray))
                        }
                        
                        Spacer()
                    }
                } else {
                    VStack(spacing: 0) {
                        ForEach(strengthList.filter { $0.title.contains(strengthName) || strengthName == "" }, id:\.self) {
                            filteredStrength in
                            Button {
                                withAnimation(.easeIn(duration: 0.1)) {
                                    guard let idx = strengthList.firstIndex(of: filteredStrength) else { return }
                                    strengthList[idx].isSelected.toggle()
                                    selectAction(strengthModel: strengthList[idx])
                                }
                            } label: {
                                HStack {
                                    Text(filteredStrength.title)
                                        .modifier(boldCallout(colorName: .theme.gray5Dark))
                                        .padding(.leading, 33)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "checkmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 21)
                                        .foregroundColor(filteredStrength.isSelected ? .theme.primary : .clear)
                                        .padding(.trailing, 47)
                                }
                                .frame(height: 44)
                                .background(filteredStrength.isSelected ? Color.theme.secondary : .clear)
                            }
                        }
                    }
                }
            }
            .padding(.top,5)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .onAppear {
            getStrengthList()
        }
        .padding(.top, 10)
    }
}

extension AddStrengthSheet {
    func selectAction(strengthModel: SearchStrengthRowModel) {
        if strengthModel.isSelected && !selectedStrength.contains(strengthModel.title){
            selectedStrength.append(strengthModel.title)
            print("어팬드 \(selectedStrength)")
        } else {
            guard let idx = selectedStrength.firstIndex(of: strengthModel.title) else { return }
            selectedStrength.remove(at: idx)
            print("리무브 \(selectedStrength)")
        }
    }
    
    func deleteSelectedStrength(name: String) {
        guard let selectedIdx = selectedStrength.firstIndex(of: name) else { return }
        guard let strengthIdx = strengthList.firstIndex(where: { $0.title == name }) else { return }
                
        selectedStrength.remove(at: selectedIdx)
        strengthList[strengthIdx].isSelected = false
    }
    
    func getStrengthList() {
        strengthList.removeAll()
        
        for strength in dotsModel.strength {
            guard let name = strength.strengthName else { continue }
            strengthList.append(.init(title: name, isSelected: false))
        }
    }
}

//struct AddStrengthSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        AddStrengthSheet()
//    }
//}
