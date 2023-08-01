//
//  MyStrengthView.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct MyStrengthView: View {
    
    @EnvironmentObject var dotsModel: DotsModel
    @State var showModal = false
    @Binding var tab: Tab
    @State var isTapped: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top){
                Color.theme.bgMain
                Group {
                    if dotsModel.myStrength.isEmpty {
                        Image("myStrengthVisual_none")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 50)
                            .frame(maxWidth: .infinity)
                            .scaleEffect(isTapped ? 1.07 : 1.0)
                    } else {
                        MetaballAnimation(isTapped: $isTapped, myStrength: toVisualizeStrength())
                            .frame(height: UIScreen.main.bounds.height/3)
                    }
                }
                .padding(.bottom, 21)
                
                ScrollView{
                    VStack(spacing: 8) {
                        Rectangle()
                            .frame(height: UIScreen.main.bounds.height/3)
                            .foregroundColor(Color.theme.bgMain)
                            .opacity(0.001)
                            .onTapGesture {
                                let hapticFeedback = UIImpactFeedbackGenerator(style: .rigid)
                                hapticFeedback.impactOccurred()
                                
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    isTapped.toggle()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        withAnimation(.easeIn(duration: 0.1)) {
                                            isTapped.toggle()
                                        }
                                    }
                                }
                            }
                        
                        ScrollView {
                            if dotsModel.myStrength.isEmpty {
                                Button(action: { self.showModal = true }) {
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.theme.gray5, lineWidth: 1.5)
                                        .foregroundColor(.theme.bgPrimary)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 84)
                                        .overlay() {
                                            HStack {
                                                Text("저장된 강점이 없습니다.")
                                                    .modifier(regularBody(colorName: .theme.gray))
                                                    .padding(.leading, 29)
                                                
                                                Spacer()
                                            }
                                        }
                                }
                                .padding(.horizontal, 16)
                                
                            } else {
                                let sortedMyStrength = getSortMyStrength()
                                ForEach(sortedMyStrength, id: \.self) { strength in
                                    CustomList(entity: strength)
                                        .padding(.horizontal, 16)
                                }
                            }
                        }
                    }
                    
                }
                .scrollIndicators(.hidden)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("내 강점")
                            .modifier(boldTitle1(colorName: .theme.gray5Dark))
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: { self.showModal = true }) {
                            Image(systemName: "plus")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 22)
                                .foregroundColor(.theme.gray5Dark)
                            
                            
                        }
                    }
                })
                .sheet(isPresented: $showModal){
                    StrengthModal()
                        .presentationDetents([.height(UIScreen.main.bounds.height * 0.35)])
                }
                
                
            }
            .background(Color.theme.bgMain)
        }
    }
}

extension MyStrengthView {
    func getSortMyStrength() -> [MyStrengthEntity] {
        return dotsModel.myStrength.sorted { strength1, strength2 in
            
            guard let strength1Notes = strength1.notes?.allObjects as? [MyStrengthNoteEntity] else { return false }
            
            guard let strength2Notes = strength2.notes?.allObjects as? [MyStrengthNoteEntity] else { return true }
            
            let sortedStrength1Notes = strength1Notes.sorted { $0.date! > $1.date! }
            
            let sortedStrength2Notes = strength2Notes.sorted { $0.date! > $1.date! }
            
            if sortedStrength1Notes.isEmpty {
                return false
            } else if sortedStrength2Notes.isEmpty {
                return true
            } else {
                return sortedStrength1Notes.first!.date! > sortedStrength2Notes.first!.date!
            }
        }
    }
    
    func toVisualizeStrength() -> [MyStrengthEntity] {
        let candidateStrengthList: [MyStrengthEntity] = dotsModel.myStrength
        var resultList: [MyStrengthEntity]
        
        if candidateStrengthList.count > 3 {
            let sortedList = candidateStrengthList.sorted { strength1, strength2 in
                if strength1.strengthLevel == strength2.strengthLevel {
                    guard let strength1NoteCount = strength1.notes?.count else { return false }
                    guard let strength2NoteCount = strength2.notes?.count else { return true}
                    
                    return strength1NoteCount > strength2NoteCount
                } else {
                    return strength1.strengthLevel > strength2.strengthLevel
                }
            }
            
            resultList = Array(sortedList[0...2])
            
            return resultList
        } else {
            resultList = candidateStrengthList
            return resultList
        }
    }
}

//struct MyStrengthView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyStrengthView()
//            .environmentObject(DotsModel())
//    }
//}
