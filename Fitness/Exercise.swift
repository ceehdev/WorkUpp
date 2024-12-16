import SwiftUI
import SwiftData

@Model
class Exercise {
    @Attribute var id: UUID
    @Attribute var name: String
    @Attribute var repetitions: Int
    @Attribute var sets: Int
    @Attribute var restTime: Int 

    @Relationship var workout: Workout

    init(id: UUID = UUID(), name: String, repetitions: Int, sets: Int, restTime: Int, workout: Workout) {
        self.id = id
        self.name = name
        self.repetitions = repetitions
        self.sets = sets
        self.restTime = restTime
        self.workout = workout
    }
}
