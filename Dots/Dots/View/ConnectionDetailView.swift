//
//  ConnectionDetailView.swift
//  Dots
//
//  Created by Chaeeun Shin on 2023/07/20.
//

import SwiftUI

struct ConnectionDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showProfile = false
    let person: NetworkingPersonEntity
    
    // 데이터 연동 필요 - 강점(StrengthEntity)
    
    var body: some View {
        ZStack {
            Color.yellow  // 이미지 대체 자리
            VStack {
                CompareStrenth(person: person)
                    .padding(.top, 20)
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(.white)
                        .frame(height: 203)
                        .gesture(
                            // TODO: 세로 제스쳐만 인식하도록 개선 필요
                            DragGesture()
                                .onEnded{ _ in showProfile.toggle() }
                        )
                        .overlay(
                            VStack {
                                BasicProfile(name: person.name, company: person.company, job: person.job)
                                Spacer()
                            }
                        )
                }
            }
        }
        // MARK: Custom NavigationBar
        .navigationBarBackButtonHidden()
        .navigationBarItems(leading: BackButton)
        // TODO: 인맥 편집 화면 연결 필요(인맥 등록뷰와 동일)
        .navigationBarItems(trailing: Button(action: {}, label: {Text("편집")}))
        .edgesIgnoringSafeArea([.bottom])
        .sheet(isPresented: $showProfile) {
            ConnectionProfileModal(person: person)
//                .presentationDetents([.height(203), .large])
//                .presentationBackgroundInteraction(.enabled(upThrough: .height(203)))
//                .interactiveDismissDisabled()
                
        }
    }
    
    private var BackButton: some View {
        Button {
            dismiss()
        } label: {
            HStack(spacing: 3) {
                Image(systemName: "chevron.backward")
                Text("인맥관리")
            }
        }
    }
}

enum StrenthViewType: String, CaseIterable, Identifiable {
    case take, common, give
    
    var id: String { self.rawValue }
}

struct CompareStrenth: View {
    let person: NetworkingPersonEntity
    @State private var isSelected: StrenthViewType = .take
    
    var body: some View {
        VStack {
            Picker("Strenth Comparison", selection: $isSelected) {
                ForEach(StrenthViewType.allCases) { viewType in
                    Text(viewType.rawValue).tag(viewType)
                }
            }
            CompareStrenthItem(strenthType: isSelected.rawValue, person: person)
        }
    }
}

struct CompareStrenthItem: View {
    // strenthType에 따른 강점 필터링 필요
    let strenthType: String
    let person: NetworkingPersonEntity

    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        ZStack {
            HStack {
                VStack(alignment: .leading) {
                    Spacer()
                    // TODO: 텍스트 길이에 따라 유동적인 배치 필요
                    if let strengthList = person.strengthSet?.allObjects as? [StrengthEntity] {
                        ForEach(strengthList) { strength in
                            StrenthName(strenthText: strength.strengthName)
                        }
                    }
                   
                }
                .padding(.bottom, 15)
                
                Spacer()
            }
            .padding(.leading, 15)
        }
    }
}

struct StrenthName: View {
    let strenthText: String?
    
    var body: some View {
        Text(strenthText ?? "")
            .padding(10)
            .padding(.leading, 8)
            .padding(.trailing, 8)
            .background(.white.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .strokeBorder(Color.gray, lineWidth: 1)
            )
            .fixedSize()
    }
}

//struct ConnectionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConnectionDetailView(person: NetworkingPersonEntity())
//    }
//}
