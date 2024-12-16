import SwiftUI

struct WorkoutHistoryDetailView: View {
    let workout: CompletedWorkout

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                Spacer()

                Text(workout.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top, 20)
                    .accessibilityLabel("Workout Name")
                    .accessibilityValue(workout.name)

                Text("Completed on \(formattedDate(workout.completionDate))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                    .accessibilityLabel("Completion Date")
                    .accessibilityValue(formattedDate(workout.completionDate))

                Divider()
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Workout Summary")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .accessibilityLabel("Workout Summary")

                    HStack {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.blue)
                            .accessibilityHidden(true)
                        Text("This workout included 5 exercises for a total of 45 minutes.")
                            .font(.body)
                            .foregroundColor(.primary)
                            .accessibilityLabel("Workout Duration")
                            .accessibilityValue("5 exercises for 45 minutes")
                    }

                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.red)
                            .accessibilityHidden(true)
                        Text("Calories burned: 400")
                            .font(.body)
                            .foregroundColor(.primary)
                            .accessibilityLabel("Calories Burned")
                            .accessibilityValue("400 calories")
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
    WorkoutHistoryDetailView(workout: CompletedWorkout(name: "Workout D'ESEMPIO", completionDate: Date()))
}
