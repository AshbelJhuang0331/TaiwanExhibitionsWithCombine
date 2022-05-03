//
//  ExhibitionDetailView.swift
//  TaiwanExhibitionsWithCombine
//
//  Created by Chuan-Jie Jhuang on 2022/5/3.
//

import SwiftUI

struct ExhibitionDetailView: View {
    
    var exhibition: ExhibitionModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(exhibition.title).font(.title3).lineLimit(nil)
            HStack {
                Text("展覽單位:")
                Text(exhibition.showUnit)
            }
            HStack {
                Text("展覽期間:")
                Text(exhibition.startDate + " ~ " + exhibition.endDate)
            }
            HStack {
                Text("展覽概要：")
                Text(exhibition.descriptionFilterHtml)
            }
            HStack {
                Text("展覽地點：")
                let showInfo = exhibition.showInfo.first
                if let location = showInfo?.location,
                   location.count > 0,
                   let locationName = showInfo?.locationName {
                    Text(location + " " + locationName)
                } else {
                    Text(exhibition.showUnit)
                }
            }
        }
        .navigationTitle("展覽資訊")
    }
}

//struct ExhibitionDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExhibitionDetailView()
//    }
//}
