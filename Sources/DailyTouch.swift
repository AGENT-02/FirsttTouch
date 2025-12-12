import Foundation
import SwiftData

@Model
final class DailyTouch {
    var timestamp: Date
    // Helper components for easier querying/debugging if needed
    var day: Int
    var month: Int
    var year: Int
    
    init(timestamp: Date = Date()) {
        self.timestamp = timestamp
        let components = Calendar.current.dateComponents([.day, .month, .year], from: timestamp)
        self.day = components.day ?? 0
        self.month = components.month ?? 0
        self.year = components.year ?? 0
    }
    
    var timeString: String {
        timestamp.formatted(date: .omitted, time: .shortened)
    }
    
    var dateString: String {
        timestamp.formatted(date: .abbreviated, time: .omitted)
    }
}
