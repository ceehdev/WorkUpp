import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Workout.name) var workouts: [Workout]
    
    @State private var isCreatingWorkout = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Workouts")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                    .accessibilityLabel("Workout List Title")
                    .accessibilityHint("Displays a list of all workouts.")

                List(workouts) { workout in
                    NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                        HStack {
                            Image(systemName: "figure.walk.circle.fill")
                                .foregroundColor(.blue)
                                .accessibilityHidden(true) // Decorative image, no label needed
                            Text(workout.name)
                                .font(.title2)
                                .foregroundColor(.black)
                                .accessibilityLabel("Workout: \(workout.name)")
                        }
                        .padding()
                    }
                    .accessibilityHint("Tap to view details of the workout named \(workout.name).")
                }
                .listStyle(PlainListStyle())
                
                Spacer()

                Button(action: {
                    isCreatingWorkout = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.gray)
                        .padding(.bottom, 80)
                }
                .accessibilityLabel("Add Workout Button")
                .accessibilityHint("Tap to create a new workout.")
                .fullScreenCover(isPresented: $isCreatingWorkout) {
                    WorkoutCreationView()
                        .accessibilityLabel("Workout Creation Screen")
                }
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Workout.self, Exercise.self])
}
