//
//  ContentView.swift
//  TaiwanExhibitionsWithCombine
//
//  Created by Chuan-Jie Jhuang on 2022/4/28.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = TaiwanExhibitionsViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading == true {
                    ProgressView().scaleEffect(2)
                } else {
                    if let error = viewModel.showError {
                        Text(error.localizedDescription)
                    } else {
                        List {
                            ForEach(viewModel.data) { exhibition in
                                NavigationLink(destination: ExhibitionDetailView(exhibition: exhibition)) {
                                    ExhibitionRow(exhibition: exhibition)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        
                    }
                }
            }
            .navigationTitle("展覽列表")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    viewModel.fetchAllExhibitions()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
        .onAppear {
            viewModel.fetchAllExhibitions()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
