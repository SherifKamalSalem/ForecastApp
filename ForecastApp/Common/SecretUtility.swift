//
//  SecretUtility.swift
//  ForecastApp
//
//  Created by Sherif Kamal on 24/04/2023.
//

import Foundation

final class SecretsUtility {
    
    // MARK: - Secrets
    
    static let appID = Secret(
        encoded: [71, 130, 34, 117, 50, 237, 181, 90, 12, 79, 13, 229, 150, 48, 13, 64, 190, 217, 133, 108, 150, 80, 218, 138, 14, 85, 164, 202, 107, 11, 119, 169],
        cipher: [34, 179, 64, 76, 86, 219, 209, 108, 106, 127, 62, 212, 164, 8, 108, 114, 141, 233, 188, 15, 242, 54, 226, 238, 111, 49, 198, 171, 92, 61, 68, 155])
}

