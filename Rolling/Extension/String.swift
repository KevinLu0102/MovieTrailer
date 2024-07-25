//
//  String.swift
//  Rolling
//
//  Created by Kevin Lu on 2024/7/15.
//

import Foundation

extension String{
    func toMonthAndDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
            
        guard let date = dateFormatter.date(from: self) else { return self }
            
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: date)
    }
}
