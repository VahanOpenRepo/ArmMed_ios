//
//  PatientCellModel.swift
//  MedUp
//
//  Created by Vahe Makaryan on 25.09.21.
//

import Foundation

public struct PatientCellModel {

    public var id: String

    public var imageURLString: String?
    public var fullName: String
    public var birthdate: String?

    public var visitDateText: String?
    public var visitModeText: String?
    public var timeRangeText: String?

    init(id: String,

         imageURLString: String,
         name: String?,
         lastName: String?,
         birthdate: String?,
         visitMode: String?,

         visitStart: String?,
         visitEnd: String?) {

        self.id = id
        self.imageURLString = imageURLString
        self.fullName = name ?? ""
        self.fullName += " "
        self.fullName += lastName ?? ""


        if let date = birthdate?.toDate(format: .yyyy_mm_dd_mid_line) {
            self.birthdate = date.string(format: .yyyy_mm_dd_dot)
        }

        if let date = visitStart?.toDate() {
            self.visitDateText = date.string(format: .yyyy_mm_dd_dot)
        }

        if let startDate = visitStart?.toDate(), let endDate = visitEnd?.toDate() {
            let start = startDate.string(format: .HH_mm)
            let end = endDate.string(format: .HH_mm)
            self.timeRangeText = start + " - " + end
        }
    }
}

extension String {

    func toDate(format: DateFormat = .yyyy_MM_dd_HH_mm_ss) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = format.rawValue
        return formatter.date(from: self)
    }
}

public enum DateFormat: String {
    case none = ""

    case MM_dd_YYYY = "dd/MM/yyyy"
    case yyyy_mm_dd_dot = "yyyy.MM.dd"
    case yyyy_mm_dd_mid_line = "yyyy-MM-dd"
    case yyyy_MM_dd_HH_mm_ss = "yyyy-MM-dd HH:mm:ss"
    case yyyy_MM_dd_HH_mm = "yyyy-MM-dd HH:mm"
    case HH_mm = "HH:mm"

}


public extension Date {
    // This method is to get the date object mapped to string in specific format
    func string(format: DateFormat) -> String {

        let dateformater = DateFormatter()
        dateformater.dateFormat = format.rawValue
        return dateformater.string(from: self)
    }

    func calculateAge() -> Int {
        let now = Date()

        let calendar = Calendar.current

        let ageComponents = calendar.dateComponents([.year], from: self, to: now)
        let age = ageComponents.year

        return age ?? 0
    }
}


