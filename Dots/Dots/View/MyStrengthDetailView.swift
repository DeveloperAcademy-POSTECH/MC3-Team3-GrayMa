//
//  MyStrengthDetailView.swift
//  Dots
//
//  Created by Jae Ho Yoon on 7/19/23.
//

import SwiftUI

struct MyStrengthDetailView: View {
    @State var levelList: [String] = []
    @State var strengthList : [String] = []
    
    var body: some View {
        NavigationStack{
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            
            
            
            
            
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("레벨 선택") { }
                    }
                    // MARK: - 뒤로가기 버튼 이름 커스텀
                    ToolbarItem(placement: .topBarLeading) {
                        Button("􀯶내 강점") { }
                    }
                }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("UX Design method") // 강점 이름
            .navigationBarTitleDisplayMode(.large)
            
        }
    }
}

struct MyStrengthDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyStrengthDetailView()
    }
}
