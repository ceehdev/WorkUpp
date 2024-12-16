import SwiftUI

struct HistoryView: View {
    @State private var completedWorkouts: [CompletedWorkout] = [
        CompletedWorkout(name: "Workout 1", completionDate: Date()),
        CompletedWorkout(name: "Workout 2", completionDate: Date().addingTimeInterval(-86400)) 
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Workout History")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                List(completedWorkouts, id: \.name) { workout in
                    
                    NavigationLink(destination: WorkoutHistoryDetailView(workout: workout)) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(workout.name)
                                    .font(.headline)
                                Text("Completed on \(formattedDate(workout.completionDate))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                        .padding()
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color.white)
            }
            .navigationTitle("History")
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
}
