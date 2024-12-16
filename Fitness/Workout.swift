import SwiftUI
import SwiftData

@Model
class Workout {
    @Attribute var id: UUID
    @Attribute var name: String
    @Attribute var date: Date
    @Attribute var calories: Int
    @Attribute var repetitions: Int
    @Attribute var sets: Int
    @Relationship var exercises: [Exercise]

    init(id: UUID = UUID(), name: String, date: Date = Date(), calories: Int, repetitions: Int, sets: Int, exercises: [Exercise] = []) {
        self.id = id
        self.name = name
        self.date = date
        self.calories = calories
        self.repetitions = repetitions
        self.sets = sets
        self.exercises = exercises
    }
}
