import SwiftUI
import SwiftData

struct WorkoutCreationView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var calories = 0
    @State private var repetitions = 0
    @State private var sets = 0

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Workout Information")) {
                    TextField("Nome del Workout", text: $name)
                    HStack {
                                            Text("Calorie: \(calories)")
                                            Slider(value: Binding(
                                                get: { Double(calories) },
                                                set: { calories = Int($0) }
                                            ), in: 0...1000, step: 1)
                                        }
                }
                
                Button("Salva") {
                    let newWorkout = Workout(
                        name: name,
                        calories: calories,
                        repetitions: 0,
                        sets: 0
                    )
                    
                    modelContext.insert(newWorkout)

                    do {
                        try modelContext.save()
                        dismiss()
                    } catch {
                        print("Errore durante il salvataggio: \(error)")
                    }
                }
                .padding()
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(50)
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("Crea Nuovo Workout")
        }
    }
}

#Preview {
    WorkoutCreationView()
        .modelContainer(for: [Workout.self])
}
