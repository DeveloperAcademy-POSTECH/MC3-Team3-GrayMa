
//  SearchFilterListRow.swift
//  Dots
//
//  Created by 정승균 on 2023/07/22.
//

import SwiftUI

struct SearchFilterListRow: View {
    @EnvironmentObject var filterModel : FilterModel
    @Binding var accentName: String 
    @Binding var isSheetOn: Bool
    var type: String
    let imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .stroke(Color.gray, lineWidth: 0.5)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .overlay {
                HStack {
                    Image(systemName: imageName)
                        .scaledToFit()
                        .frame(width: 29)
                        .padding(.trailing, 14)
                        .padding(.leading, 20)
                    Text(type)
                        .modifier(regularSubHeadLine(colorName: .theme.gray5Dark))
                    Spacer()
                    if !accentName.isEmpty{
                        AccentText
                            .padding(.trailing, 15.5)
                    }
                    else {
                        Text("모두")
                            .modifier(regularSubHeadLine(colorName: .theme.gray5))
                            .padding(.trailing, 30)
                    }
                    
                }
                .onChange(of: !isSheetOn) { newValue in
                    if newValue {
                        Configuretype(type: type)
                    }
                }
            }
    }
}
// MARK: - Components
extension SearchFilterListRow {
    private var AccentText: some View {
        HStack{
            Text(accentName)
            Spacer()
            CloseBtn(btncolor: .gray) {
                RemoveFilter(type: type)
                print("\(filterModel.$companyName) 회사 필터")
                print("\(filterModel.$companyName) 직무 필터")
                print("\(filterModel.$companyName) 강점 필터")
            }
        }
        .buttonStyle(.borderless)
        .padding(10)
        .padding(.horizontal,8)
        .background(Color.theme.secondary)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.theme.secondary, lineWidth: 1)
        )
        .fixedSize()
    }
}

// MARK: - function
extension SearchFilterListRow {
    private func clearAccentName() {
        accentName = ""
    }
    
    private func Configuretype(type: String) {
        switch type {
        case "회사":
            return accentName = filterModel.companyName
        case "직무":
            return accentName = filterModel.jobName
        case "강점":
            return accentName = filterModel.strengthName
        default:
            accentName = ""
            break
        }
    }
    
    private func RemoveFilter(type: String) {
        switch type {
        case "회사":
            accentName = ""
            filterModel.companyName = ""
        case "직무":
            accentName = ""
            filterModel.jobName = ""
        case "강점":
            accentName = ""
            filterModel.strengthName = ""
        default:
            accentName = ""
            break
        }
        
    }
    
}


//struct SearchFilterListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchFilterListRow(type: "회사")
//            .previewLayout(.sizeThatFits)
//    }
//}
