//
//  HomeResponseModel.swift
//  Radius Agent
//
//  Created by Ravindra Arya on 28/06/23.
//

import Foundation

// MARK: - Welcome
struct HomeResponseModel: Codable {
    let facilities: [Facility]
    let exclusions: [[Exclusion]]
}

// MARK: - Exclusion
struct Exclusion: Codable {
    let facilityID, optionsID: String

    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case optionsID = "options_id"
    }
}

// MARK: - Facility
struct Facility: Codable {
    let facilityID, name: String
    var options: [Option]
    var isFacilitySelected : Bool?


    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case name, options
    }
}

// MARK: - Option
struct Option: Codable {
    let name, icon, id: String
    var isSelected : Bool?
}

