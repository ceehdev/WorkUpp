import SwiftUI

struct WorkoutDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showingCreateExercise = false

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

            Button(action: {
                showingCreateExercise.toggle()
            }) {
                Text("Add Exercise")
                    .frame(maxWidth: 150)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }
            .padding()
            .sheet(isPresented: $showingCreateExercise) {
                ExerciseCreationView(workout: workout)
            }
        }
    }
}


#Preview {
    WorkoutDetailView(workout: Workout(name: "WORKOUT DI ESEMPIO", calories: 200, repetitions: 20, sets: 5))
}
