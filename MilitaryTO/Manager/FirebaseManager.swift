//
//  FirebaseManager.swift
//  MilitaryTO
//
//  Created by 장혜준 on 05/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import FirebaseDatabase
import ObjectMapper

enum FirebaseChild: String {
    case version
    case industry
    case professional
}

enum FirebaseDatabaseVersion: String, CaseIterable {
    case industry_database_version
    case professional_database_version
    case app_version
    case app_update_message
}

class FirebaseManager {
    static let shared = FirebaseManager()
    private var ref: DatabaseReference? = nil
    
    func initialize() {
        self.ref = Database.database().reference()
    }
    
    func request<T>(child: String, completion: @escaping (T?) -> Void) {
        ref?.child(child).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let data = snapshot.value as? T else {
                completion(nil)
                return
            }
            completion(data)
        }, withCancel: { (error) in
            ERROR_LOG(error.localizedDescription)
            completion(nil)
        })
    }
}

func firebaseManager() -> FirebaseManager {
    return FirebaseManager.shared
}

extension FirebaseManager {
    func isNeedToUpdateDatabaseVersion(_ version: Float, _ key: String) -> Bool {
        if version > myUserDefaults.float(forKey: key) {
            myUserDefaults.set(version, forKey: key)
            return true
        } else {
            return false
        }
    }
    
    func updateDatabase(_ kind: MilitaryServiceKind, _ data: [String: Any], _ completion: @escaping (Bool) -> Void) {
        FirebaseDatabaseVersion.allCases.forEach {
            if let floatValue = data[$0.rawValue] as? Float {
                myUserDefaults.set(floatValue, forKey: $0.rawValue)
            } else if let stringValue = data[$0.rawValue] as? String {
                myUserDefaults.set(stringValue, forKey: $0.rawValue)
            }
        }
        
        switch kind {
        case .Industry:
            databaseManager().industryObjectDelete()
            request(child: FirebaseChild.industry.rawValue) { (data: [[String: Any]]?) in
                guard let data = data else {
                    completion(false)
                    return
                }
                databaseManager().industryObjectWrite(data)
                completion(true)
            }
        case .Professional:
            databaseManager().professionalObjectDelete()
            request(child: FirebaseChild.professional.rawValue) { (data: [[String: Any]]?) in
                guard let data = data else {
                    completion(false)
                    return
                }
                databaseManager().professionalObjectWrite(data)
                completion(true)
            }
        }
    }
}