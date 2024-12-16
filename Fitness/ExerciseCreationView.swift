import SwiftUI
import SwiftData

struct ExerciseCreationView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var repetitions = 0
    @State private var sets = 0
    @State private var restTime = 0
    let workout: Workout

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Information")) {
                    TextField("Exercise Name", text: $name)
                    Stepper("Repetitions: \(repetitions)", value: $repetitions, in: 0...100)
                    Stepper("Sets: \(sets)", value: $sets, in: 0...10)
                    Stepper("Rest Time: \(restTime) seconds", value: $restTime, in: 0...600)
                }
                
                Button("Save") {
                    let newExercise = Exercise(
                        name: name,
                        repetitions: repetitions,
                        sets: sets,
                        restTime: restTime,
                        workout: workout
                    )
                    
                    modelContext.insert(newExercise)
                    
                    do {
                        try modelContext.save()
                        print("Exercise created: \(newExercise)")
                        dismiss()
                    } catch {
                        print("Error saving exercise: \(error)")
                    }
                }
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(50)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Create New Exercise")
        }
    }
}

#Preview {
    let sampleWorkout = Workout(name: "Sample Workout", calories: 200, repetitions: 10, sets: 5)
    
    return ExerciseCreationView(workout: sampleWorkout)
        .modelContainer(for: [Workout.self, Exercise.self])
}
