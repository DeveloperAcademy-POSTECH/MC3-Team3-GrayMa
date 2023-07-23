//
//  ConnectionDetailView.swift
//  Dots
//
//  Created by Chaeeun Shin on 2023/07/20.
//

import SwiftUI

struct ConnectionDetailView: View {
    @State private var showProfile = false
    let person: NetworkingPersonEntity
    
    // 데이터 연동 필요 - 개인정보(NetworkingPersonEntity), 강점(StrengthEntity)
    
    var body: some View {
        ZStack {
            Color(red: 0, green: 50, blue: 50)    // 이미지 대체 자리
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
        .ignoresSafeArea()
        .sheet(isPresented: $showProfile) {
            ConnectionProfileModal(person: person)
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
            .pickerStyle(.segmented)
            .frame(width: 361, height: 44)
            
            CompareStrenthItem(strenthType: isSelected.rawValue, person: person)
        }
    }
}

struct CompareStrenthItem: View {
    // DB연동시 strenthType에 따른 강점 필터링 필요
    let strenthType: String
    let person: NetworkingPersonEntity

    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        ZStack {
            Color.yellow    // 이미지 대체 예정
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

struct ConnectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionDetailView(person: NetworkingPersonEntity())
    }
}
