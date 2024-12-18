import SwiftUI
import SwiftData

struct WorkoutDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showingCreateExercise = false
    @State private var showingCompletionAlert = false

    var workout: Workout

    var body: some View {
        VStack {
            List(workout.exercises, id: \.id) { exercise in
                NavigationLink(destination: ExerciseDetailView(exercise: exercise)) {
                    VStack(alignment: .leading) {
                        Text(exercise.name)
                            .font(.headline)
                        Text("Repetitions: \(exercise.repetitions), Sets: \(exercise.sets)")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle(workout.name)

            HStack {
                Button(action: {
                    showingCreateExercise.toggle()
                }) {
                    Text("Add Exercise")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .sheet(isPresented: $showingCreateExercise) {
                    ExerciseCreationView(workout: workout)
                }

                Button(action: {
                    finishWorkout()
                }) {
                    Text("Finish Workout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .alert("Workout Finished", isPresented: $showingCompletionAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("Workout Saved to the History!")
                }
            }
        }
    }

    private func finishWorkout() {
        // Create a new WorkoutHistory based on this workout.
        let workoutHistory = WorkoutHistory(
            name: workout.name,
            completionDate: Date(),
            caloriesBurned: workout.calories, duration: 5
        )

        // Save the new workout history.
        do {
            modelContext.insert(workoutHistory)
            try modelContext.save()
            showingCompletionAlert = true
        } catch {
            print("Failed to save workout history: \(error)")
        }
    }
}


#Preview {
    WorkoutDetailView(workout: Workout(name: "WORKOUT DI ESEMPIO", calories: 200, repetitions: 20, sets: 5))
}
