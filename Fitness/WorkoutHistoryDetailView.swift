import SwiftUI

struct WorkoutHistoryDetailView: View {
    let workout: WorkoutHistory // Change from CompletedWorkout to WorkoutHistory

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                Spacer()

                Text(workout.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                Text("Completed on \(formattedDate(workout.completionDate))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)

                Divider()

                VStack(alignment: .leading, spacing: 12) {
                    Text("Workout Summary")
                        .font(.headline)
                        .foregroundColor(.blue)

                    HStack {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.blue)
                        Text("Duration: \(workout.duration) minutes") // Adjust property names as needed
                            .font(.body)
                            .foregroundColor(.primary)
                    }

                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.red)
                        Text("Calories burned: \(workout.caloriesBurned)")
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(maxWidth: 600)

                Spacer()
            }
            .padding()
            .navigationTitle("Workout Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}


#Preview {
    WorkoutHistoryDetailView(
        workout: WorkoutHistory(
            id: UUID(), // Generate a UUID
            name: "Example Workout",
            completionDate: Date(),
            caloriesBurned: 300,
            duration: 45 // If `duration` is part of the model
        )
    )
}
