//
//  Date+Extt.swift
//  GHFollowers
//
//  Created by "Khalid Olowe-Makorie, Vodafone" on 14/10/2024.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String{
        return formatted(.dateTime.month().year())
    }
    
}
