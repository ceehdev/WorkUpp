import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query var workoutHistories: [WorkoutHistory] // Correct Query syntax

    var body: some View {
        NavigationView {
            List {
                ForEach(workoutHistories, id: \.self) { history in
                    NavigationLink(destination: WorkoutHistoryDetailView(workout: history)) {
                        VStack(alignment: .leading) {
                            Text(history.name)
                                .font(.headline)
                            Text("Completed on \(formattedDate(history.completionDate))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Workout History")
        }
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

#Preview {
    HistoryView()
        .modelContainer(for: [WorkoutHistory.self])
}
