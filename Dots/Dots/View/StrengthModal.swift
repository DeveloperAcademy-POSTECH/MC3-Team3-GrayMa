//
//  StrengthModal.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/19.
//

import SwiftUI

struct StrengthModal: View {
    @EnvironmentObject var dotsModel: DotsModel
    
    @State var pagenum: Int = 0
    @State var strengthName : String = ""
    @State var selectedLevel = 0
    
    var body: some View {
        ZStack {
            if pagenum == 0 {
                AddStrengthModal(strengthName: $strengthName, pagenum: $pagenum)
            }
            else if pagenum == 1 {
                SelectLevelModal(strengthName: $strengthName, pageNum: $pagenum, selectedLevel: $selectedLevel)
            }
            
        }
    }
}
