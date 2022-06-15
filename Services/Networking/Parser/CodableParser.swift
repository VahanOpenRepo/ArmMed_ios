//
//  CodableParser.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation
import RxSwift

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}

public class CodableParser: IParser {
    public func parse<T: Decodable>(data: Data) -> Single<T> {
        return Single<T>.create { observer -> Disposable in
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(.iso8601Full)
                let object = try decoder.decode(T.self, from: data)
                observer(.success(object))
            } catch {
                print("Decode error \(error), for type \(T.self)")
                observer(.failure(MedUpError.internalError(error.localizedDescription)))
            }
            return Disposables.create()
        }
    }
}
