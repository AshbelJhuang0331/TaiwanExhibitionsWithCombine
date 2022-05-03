//
//  ExhibitionRow.swift
//  TaiwanExhibitionsWithCombine
//
//  Created by Chuan-Jie Jhuang on 2022/5/3.
//

import SwiftUI

struct ExhibitionRow: View {
    var exhibition: ExhibitionModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            Text(exhibition.title)
                .font(.title3)
                .lineLimit(nil)
            Text(exhibition.showUnit)
                .font(.caption)
            Text(exhibition.startDate)
                .italic()
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

//struct ExhibitionCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ExhibitionCell()
//    }
//}
