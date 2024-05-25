//: [Previous](@previous)

import Foundation
import SwiftUI

// Basic Task.
Task {
  print("Doing some work on a task.")
}

print("Doing work on the main actor.")
print("- - - - - - - - - - - - - - - - - - - - - - - -")

// Changing the order.
Task {
  print("This is first.")
  
  let sum = (1...100).reduce(0, +)
  print("This is second: 1 + 2 + 3 ... 100 = \(sum)")
}

print("This is last.")
print("- - - - - - - - - - - - - - - - - - - - - - - -")


// Canceling a task.
let task = Task {
  print("This is first.")
  
  let sum = (1...100).reduce(0, +)
  try Task.checkCancellation()
  print("This is second: 1 + 2 + 3 ... 100 = \(sum)")
}

print("This is last.")
task.cancel()
print("- - - - - - - - - - - - - - - - - - - - - - - -")

// Suspending a task.
Task {
  print("Starting the task.")
  try await Task.sleep(nanoseconds: 1_000_000_000)
  print("Finishing the task.")
}

// Wrapping a task in a function.
func performTask() async throws {
  print("Starting the task in a function.")
  try await Task.sleep(nanoseconds: 1_000_000_000)
  print("Finishing the task in a function.")
}

Task {
  try await performTask()
}

print("- - - - - - - - - - - - - - - - - - - - - - - -")


// Downloading JSON from the internet.
func fetchDomains() async throws -> [Domain] {
  let url = URL(string: "https://http.cat/[status_code]")! // Use any api url
  let (data, _) = try await URLSession.shared.data(from: url)
  
  return try JSONDecoder().decode(Domains.self, from: data).data
}

Task {
  do {
    let domains = try await fetchDomains()
    for (index, domain) in domains.enumerated() {
      let attr = domain.attributes
      print("\(index + 1)) \(attr.name): \(attr.description) - \(attr.level)")
    }
  } catch {
    print(error)
  }
}
