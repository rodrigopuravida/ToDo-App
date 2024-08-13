//
//  main.swift
//  To Do App CL Task
//
//  Created by Rodrigo Carballo on 8/11/24.
//

import Foundation

// * Create the `Todo` struct.
// * Ensure it has properties: id (UUID), title (String), and isCompleted (Bool).
struct Todo : CustomStringConvertible, Codable {

    let id : UUID
    var title : String
    var isCompleted : Bool
    
    var description: String {
        return "\(title)"
    }
}


// Create the `Cache` protocol that defines the following method signatures:
//  `func save(todos: [Todo])`: Persists the given todos.
//  `func load() -> [Todo]?`: Retrieves and returns the saved todos, or nil if none exist.
protocol Cache {
    
    func save(todos: [Todo])
    
    func load() -> [Todo]?
    
    

}

// `FileSystemCache`: This implementation should utilize the file system
// to persist and retrieve the list of todos.
// Utilize Swift's `FileManager` to handle file operations.
final class JSONFileManagerCache: Cache {
    func load() -> [Todo]? {
        <#code#>
    }
    
    
    func save(todos: [Todo]) {
        
    }
    
    

}

// `InMemoryCache`: : Keeps todos in an array or similar structure during the session.
// This won't retain todos across different app launches,
// but serves as a quick in-session cache.
final class InMemoryCache: Cache {
    func save(todos: [Todo]) {
        <#code#>
    }
    
    func load() -> [Todo]? {
        <#code#>
    }
    

}

// The `TodosManager` class should have:
// * A function `func listTodos()` to display all todos.
// * A function named `func addTodo(with title: String)` to insert a new todo.
// * A function named `func toggleCompletion(forTodoAtIndex index: Int)`
//   to alter the completion status of a specific todo using its index.
// * A function named `func deleteTodo(atIndex index: Int)` to remove a todo using its index.
final class TodoManager {
    var currentToDoList: [Todo] = []
    
    func addToDo(toDo: String, isCompleted: Bool = false) {
        let temp = Todo(id: UUID(), title: toDo, isCompleted: isCompleted)
        currentToDoList.append(temp)
    }
    
    func listToDos() {
        print("Your To Do's")
        for (index,item) in currentToDoList.enumerated() {
            print(String(index + 1) +  ". is Completed: \(item.isCompleted) Item: \(item.description)")
        }
    }
    
    func toggleToDo(choiceToToggle : Int) {
        
        //validate that chice exists
        if currentToDoList.indices.contains(choiceToToggle-1) {
            currentToDoList[choiceToToggle-1].isCompleted.toggle()
        }
        else {
            print("Choice \(choiceToToggle) does not exist.  Please select a valid choice")
        }
        print("Item \(choiceToToggle) has switched status")
    }
    
    func deleteToDo(choiceToDelete : Int) {
        if currentToDoList.indices.contains(choiceToDelete-1) {
            currentToDoList.remove(at: choiceToDelete - 1)
        }
        else {
            print("Choice \(choiceToDelete) does not exist.  Please select a valid choice")
        }
        print("Item \(choiceToDelete) has been deleted")
    }

}



// * The `App` class should have a `func run()` method, this method should perpetually
//   await user input and execute commands.
//  * Implement a `Command` enum to specify user commands. Include cases
//    such as `add`, `list`, `toggle`, `delete`, and `exit`.
//  * The enum should be nested inside the definition of the `App` class
final class App {
    var toDoManager = TodoManager()

    enum Command : String {
        case add
        case list
        case toggle
        case delete
        case exit
    }
        
        func run() {
            // Run for eternity until exit is chosen
            while true {
                askQuestion()
                
                // Wait for a bit before asking again
                Thread.sleep(forTimeInterval: 5.0)
            }
            
        }
    
    // Function to prompt for a question
    func askQuestion() {
        print("What would you like to do? (add, list, toggle, delete, exit): ")
        
        // Simulate user input (replace this with actual input logic)
        if let userInput = readLine()?.lowercased(), let command = Command(rawValue: userInput) {
            
            switch command {
            case .add:
                print("What would you like to add?")
                if let task = readLine() {
                    toDoManager.addToDo(toDo: task)
                }
                print("Task Added")
                
            case .list:
                toDoManager.listToDos()
                
            case .toggle:
                print("Which item status do you want to switch")
                if let task = readLine() {
                    toDoManager.toggleToDo(choiceToToggle: Int(task)!)
                }
                
            case .delete:
                print("Which item do you want to remove")
                if let task = readLine() {
                    toDoManager.deleteToDo(choiceToDelete: Int(task)!)
                }
                
            case .exit:
                exit(0)
            }
        }

    }
        
}



// TODO: Write code to set up and run the app.

var runApp = App()
runApp.run()

