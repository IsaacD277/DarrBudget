//
//  SwiftDataViewers.swift
//  DarrBudget
//
//  Created by Isaac D2 on 9/30/24.
//

import Foundation
import SwiftData

extension ModelContext {
    var sqliteCommand: String {
        if let url = container.configurations.first?.url.path(percentEncoded: false) {
            "sqlite3 \"\(url)\""
        } else {
            "No SQLite database found."
        }
    }
}
