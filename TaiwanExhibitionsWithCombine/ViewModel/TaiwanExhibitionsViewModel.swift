//
//  TaiwanExhibitionsViewModel.swift
//  TaiwanExhibitionsWithCombine
//
//  Created by Chuan-Jie Jhuang on 2022/4/29.
//

import Foundation

class TaiwanExhibitionsViewModel: ObservableObject {
    
    private let apiService = API()
    
    @Published var isLoading = false
    @Published var data: [ExhibitionModel] = []
    
    @Published var showError: Error?
    
    func fetchAllExhibitions() {
        isLoading = true
        apiService.requestAllExhibitions { [weak self] allExhibitions in
            self?.isLoading = false
            self?.showError = nil
            self?.data = allExhibitions
        } failure: { [weak self] error in
            self?.isLoading = false
            self?.showError = error
            self?.data = []
        }
    }
}
