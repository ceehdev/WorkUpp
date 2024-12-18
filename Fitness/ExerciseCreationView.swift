import SwiftUI
import SwiftData

struct ExerciseCreationView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    let workout: Workout // The workout to which the exercise belongs.

    @State private var name = ""
    @State private var repetitions = 0
    @State private var sets = 0
    @State private var restTime = 0

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Details")) {
                    TextField("Exercise Name", text: $name)
                        .accessibilityLabel("Exercise Name Field")
                        .accessibilityHint("Enter the name of the exercise.")

                    Stepper("Repetitions: \(repetitions)", value: $repetitions, in: 0...100)
                        .accessibilityLabel("Repetitions Stepper")

                    Stepper("Sets: \(sets)", value: $sets, in: 0...10)
                        .accessibilityLabel("Sets Stepper")
                        .accessibilityHint("Adjust the number of sets.")
                        .accessibilityValue("\(sets) sets")

                    Stepper("Rest Time: \(restTime) seconds", value: $restTime, in: 0...300)
                        .accessibilityLabel("Rest Time Stepper")
                        .accessibilityHint("Adjust the rest time in seconds.")
                        .accessibilityValue("\(restTime) seconds")
                }

                Button("Save Exercise") {
                    saveExercise()
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                .accessibilityLabel("Save Exercise Button")
                .accessibilityHint("Tap to save the exercise.")
            }
            .navigationTitle("New Exercise")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func saveExercise() {
        // 1. Create the new Exercise.
        let newExercise = Exercise(
            name: name,
            repetitions: repetitions,
            sets: sets,
            restTime: restTime,
            workout: workout // Associate with the workout.
        )

        // 2. Add the exercise to the workout's list of exercises.
        workout.exercises.append(newExercise)

        // 3. Save the exercise and the workout.
        do {
            modelContext.insert(newExercise) // Ensure the new exercise is inserted into the context.
            try modelContext.save() // Persist changes.
            dismiss() // Close the view.
        } catch {
            print("Failed to save exercise: \(error)")
        }
    }
}

#Preview {
    let sampleWorkout = Workout(name: "Sample Workout", calories: 200, repetitions: 10, sets: 5)
    
    return ExerciseCreationView(workout: sampleWorkout)
        .modelContainer(for: [Workout.self, Exercise.self])
}
