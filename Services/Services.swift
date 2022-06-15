//
//  Services.swift
//  Services
//
//  Created by Hrant on 09.05.21.
//

import Foundation

public final class Services {
    private static var services: [Any] = []

    public static func setup() {
        registerFirstService()
        registerQRService()
        registerPatientListService()
        registerQuestionService()
        registerGetOrganizationService()
        registerAddVisitService()
    }

    static private func registerFirstService() {
        let service = FirstService()
        Services.register(service: service)
    }

    static private func registerQRService() {
        let service = ScanQRService()
        Services.register(service: service)
    }

    static private func registerPatientListService() {
        let service = PatientListService()
        Services.register(service: service)
    }

    static private func registerQuestionService() {
        let service = QuestionService()
        Services.register(service: service)
    }
    
    static private func registerAddVisitService() {
        let service = AddVisitService()
        Services.register(service: service)
    }
    
    static private func registerGetOrganizationService() {
        let service = GetOrganizationService()
        Services.register(service: service)
    }
    
    public static func get<T>() -> T {
        let service = services.first(where: { $0 is T })
        if let currentResult = service as? T {
            return currentResult
        } else {
            fatalError("Couldn't find registered service \(T.self)")
        }
    }

    static func deleteAll() {
        services.removeAll()
    }

    static func register<T>(service: T) {
        return services.append(service)
    }
}
