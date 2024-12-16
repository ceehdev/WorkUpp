import SwiftUI
import SwiftData

struct WorkoutDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var workout: Workout
    @State private var isCreatingExercise = false

    init(workout: Workout) {
        self._workout = State(initialValue: workout)
    }

    var body: some View {
        VStack {
            Text(workout.name)
                .font(.title)
                .padding()

            
            List(workout.exercises, id: \.id) { exercise in
                VStack(alignment: .leading) {
                    Text(exercise.name)
                        .font(.headline)
                    Text("Repetitions: \(exercise.repetitions) - Sets: \(exercise.sets)")
                    Text("Rest Time: \(exercise.restTime) seconds")
                }
                .padding()
            }

            Spacer()
            
           
            Button(action: {
                isCreatingExercise = true
            }) {
                Text("Add Exercise")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(30)
            }
            .fullScreenCover(isPresented: $isCreatingExercise) {
                ExerciseCreationView(workout: workout) // Pass the selected workout
            }
        }
        .navigationTitle(workout.name)
    }
}

#Preview {
    WorkoutDetailView(workout: Workout(name: "WORKOUT DI ESEMPIO", calories: 200, repetitions: 20, sets: 5))
}
