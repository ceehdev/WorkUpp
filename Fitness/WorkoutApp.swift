import SwiftUI
import SwiftData

@main
struct WorkoutApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .modelContainer(for: [Workout.self, Exercise.self]) 
        }
    }
}
