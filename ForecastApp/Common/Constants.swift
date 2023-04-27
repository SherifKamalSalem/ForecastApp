//
//  Constants.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 24/04/2023.
//

import Foundation

struct Constants {
    static let lastSeachedType = "lastSeachedType"
    @SecureSettingsOptionalItem(key: "appID")
    static var appID: String?
}
