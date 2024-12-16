//
//  ExerciseDetailView.swift
//  Fitness
//
//  Created by Cesare Festa on 16/12/24.
//


import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise // Your Exercise model containing details like name, repetitions, sets, and rest time
    @State private var remainingTime: Int
    @State private var timerActive = false
    @State private var timer: Timer?

    init(exercise: Exercise) {
        self.exercise = exercise
        self._remainingTime = State(initialValue: exercise.restTime) // Initialize with the rest time from the model
    }

    var body: some View {
        VStack(spacing: 24) {
            Text(exercise.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Repetitions:")
                        .font(.headline)
                    Spacer()
                    Text("\(exercise.repetitions)")
                        .font(.body)
                }

                HStack {
                    Text("Sets:")
                        .font(.headline)
                    Spacer()
                    Text("\(exercise.sets)")
                        .font(.body)
                }

                HStack {
                    Text("Rest Time:")
                        .font(.headline)
                    Spacer()
                    Text("\(exercise.restTime) seconds")
                        .font(.body)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(radius: 5)

            VStack(spacing: 16) {
                Text("Remaining Time")
                    .font(.title2)

                Text(remainingTime > 0 ? "\(remainingTime) seconds" : "Done!")
                    .font(.largeTitle)
                    .foregroundColor(remainingTime > 0 ? .primary : .green)
                    .fontWeight(.bold)

                Button(timerActive ? "Reset Timer" : "Start Timer") {
                    if timerActive {
                        resetTimer()
                    } else {
                        startTimer()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(timerActive ? Color.red : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()

            Spacer()
        }
        .padding()
        .navigationTitle("Exercise Details")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            timer?.invalidate() // Stop the timer when the view disappears
        }
    }

    private func startTimer() {
        timerActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                timer?.invalidate()
                timerActive = false
            }
        }
    }

    private func resetTimer() {
        timer?.invalidate()
        remainingTime = exercise.restTime
        timerActive = false
    }
}

let mockWorkout = Workout(name: "Mock Workout", calories: 200, repetitions: 10, sets: 3)

let mockExercise = Exercise(
        name: "Push-Ups",
        repetitions: 10,
        sets: 3,
        restTime: 30,
        workout: mockWorkout
    )


#Preview {
    ExerciseDetailView(
        exercise: Exercise(name: "Push-Ups", repetitions: 10, sets: 3, restTime: 30, workout: mockWorkout)
    )
}
