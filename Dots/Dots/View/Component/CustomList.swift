//
//  CustomList.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.

import SwiftUI

enum StrengthLevelImage: String, CaseIterable {
    case weakDot
    case moderateDot
    case strongDot
    
    var size: CGFloat {
        switch self {
        case .weakDot:
            return 36
        case .moderateDot:
            return 58
        case .strongDot:
            return 76
        }
    }
    
    var ballSize: CGFloat {
        switch self {
        case .weakDot:
            return 100
        case .moderateDot:
            return 110
        case .strongDot:
            return 120
        }
    }
}

struct CustomList: View {
    @EnvironmentObject var dotsModel: DotsModel
    @State private var isNavigation = false
    @State var isDeleteAlert: Bool = false
    var entity: MyStrengthEntity
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(Color.theme.disabled, lineWidth: 1.5)
            .foregroundColor(.theme.bgPrimary)
            .frame(maxWidth: .infinity)
            .frame(height: 84)
            .overlay() {
                SwipeItemView(content: {
                    HStack {
                        NavigationLink {
                            MyStrengthDetailView(myStrengthEntity: entity)
                        }label: {
                            HStack(alignment: .center){
                                Image(StrengthLevelImage.allCases[Int(entity.strengthLevel)].rawValue)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 36,height: 36)
                                    .padding(.leading,22)
                                
                                Text(entity.ownStrength?.strengthName ?? "이름")
                                    .modifier(semiBoldSubHeadLine(colorName: .theme.gray5Dark))
                                    .padding(.leading, 12)
                                    .padding(.trailing, 17)
                                
                                if let numberOfNotes = entity.notes?.count, numberOfNotes > 0 {
                                    Text("\(numberOfNotes)")
                                        .modifier(mediumCaption1(colorName: .theme.bgPrimary))
                                        .padding(.horizontal, 5)
                                        .padding(.vertical, 2)
                                        .background(Color.theme.primary)
                                        .cornerRadius(4, corners: .allCorners)
                                }
                                
                                Spacer()
                            }
                        }
                        
                    }
                }, right: {
                    HStack(spacing: 0) {
                        Button(action: {
                            isDeleteAlert = true
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
                }, itemHeight: 84)
            }
            .cornerRadius(12, corners: .allCorners)
            .alert("이 강점을 삭제하겠습니까?", isPresented: $isDeleteAlert) {
                HStack {
                    Button("취소") {
                        isDeleteAlert = false
                    }
                    
                    Button("삭제") {
                        isDeleteAlert = false
                        dotsModel.deleteMyStrength(myStrength: entity)
                    }
                    .foregroundColor(.theme.alertRed)
                }
            } message: {
                Text("강점과 강점 기록들이 모두 삭제됩니다.")
            }

    }
}
