
import SwiftData
import Foundation

@Model
class WorkoutHistory {
    @Attribute var id: UUID
    @Attribute var name: String
    @Attribute var completionDate: Date
    @Attribute var caloriesBurned: Int
    @Attribute var duration: Int

    init(id: UUID = UUID(), name: String, completionDate: Date, caloriesBurned: Int, duration: Int) {
        self.id = id
        self.name = name
        self.completionDate = completionDate
        self.caloriesBurned = caloriesBurned
        self.duration = duration
    }
}
