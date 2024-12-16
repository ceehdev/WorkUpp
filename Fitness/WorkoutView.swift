    import SwiftUI
    import SwiftData

    struct WorkoutView: View {
        @Environment(\.modelContext) private var modelContext
        @Query var workouts: [Workout] 
        @State private var showingCreateWorkout = false

        var body: some View {
            NavigationView {
                VStack {
                    List {
                        ForEach(workouts) { workout in
                            NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                                Text(workout.name)
                            }
                        }
                    }
                    .navigationTitle("Workouts")
                    .toolbar {
                       
                        ToolbarItem(placement: .bottomBar) {
                            Button(action: {
                                showingCreateWorkout.toggle()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 60, height: 80)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
                .sheet(isPresented: $showingCreateWorkout) {
                    WorkoutCreationView()
                }
            }
        }
    }

    #Preview {
        WorkoutCreationView()
            .modelContainer(for: [Workout.self, Exercise.self])
    }
