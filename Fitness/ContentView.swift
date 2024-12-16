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

                List(workouts) { workout in
                    NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                        HStack {
                            Image(systemName: "figure.walk.circle.fill")
                                .foregroundColor(.blue)
                            Text(workout.name)
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        .padding()
                    }
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
                .fullScreenCover(isPresented: $isCreatingWorkout) {
                    WorkoutCreationView()
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
