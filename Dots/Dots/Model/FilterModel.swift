//
//  FilterModel.swift
//  Dots
//
//  Created by 김다빈 on 2023/07/27.
//

import Foundation

class FilterModel : ObservableObject {
    @Published var companyName: String
    @Published var jobName: String
    @Published var strengthName: String
    
    init(companyName: String, jobName: String, strengthName: String) {
        self.companyName = companyName
        self.jobName = jobName
        self.strengthName = strengthName
    }
}
