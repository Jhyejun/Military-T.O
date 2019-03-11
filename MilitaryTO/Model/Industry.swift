//
//  Industry.swift
//  MilitaryTO
//
//  Created by 장혜준 on 26/02/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import ObjectMapper

class Industry: Object, Mappable {
    required convenience init?(map: Map) {
        self.init()
    }
    
    @objc dynamic var idx: Int = 0
    @objc dynamic var kind: String?
    @objc dynamic var scale: String?
    @objc dynamic var name: String?
    @objc dynamic var location: String?
    @objc dynamic var phoneNumber: String?
    @objc dynamic var mainSubject: String?
    @objc dynamic var selectionYear: String?
    @objc dynamic var totalTO: Int = 0
    @objc dynamic var beforeThreeConventionTO: Int = 0
    @objc dynamic var beforeTwoConventionTO: Int = 0
    @objc dynamic var threeConventionTO: Int = 0
    @objc dynamic var isLimit: String?
    @objc dynamic var region: String?
    
    override static func primaryKey() -> String? {
        return "idx"
    }
    
    func mapping(map: Map) {
        idx <- map[IndustryKey.idx.keyString]
        kind <- map[IndustryKey.kind.keyString]
        scale <- map[IndustryKey.scale.keyString]
        name <- map[IndustryKey.name.keyString]
        location <- map[IndustryKey.location.keyString]
        phoneNumber <- map[IndustryKey.phoneNumber.keyString]
        mainSubject <- map[IndustryKey.mainSubject.keyString]
        selectionYear <- map[IndustryKey.selectionYear.keyString]
        totalTO <- map[IndustryKey.totalTO.keyString]
        beforeThreeConventionTO <- map[IndustryKey.beforeThreeConventionTO.keyString]
        beforeTwoConventionTO <- map[IndustryKey.beforeTwoConventionTO.keyString]
        threeConventionTO <- map[IndustryKey.threeConventionTO.keyString]
        isLimit <- map[IndustryKey.isLimit.keyString]
        region <- map[IndustryKey.region.keyString]
    }
}

enum IndustryKey: String {
    case idx = "연번"
    case kind = "업종"
    case scale = "기업규모"
    case name = "업체명"
    case location = "소재지"
    case phoneNumber = "전화번호"
    case mainSubject = "주생산품목"
    case selectionYear = "선정년도"
    case totalTO = "배정인원(현역)-특성화고·마이스터고 졸업생 계"
    case beforeThreeConventionTO = "99년생 이전(3자 협약)"
    case beforeTwoConventionTO = "99년생 이전(2자 협약)"
    case threeConventionTO = "00년생 (3자 협약)"
    case isLimit = "배정제한여부"
    case region = "해당지방병무청"
    
    var keyString: String {
        return self.rawValue
    }
}