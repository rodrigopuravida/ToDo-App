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

}

// `FileSystemCache`: This implementation should utilize the file system
// to persist and retrieve the list of todos.
// Utilize Swift's `FileManager` to handle file operations.
final class JSONFileManagerCache: Cache {

}

// `InMemoryCache`: : Keeps todos in an array or similar structure during the session.
// This won't retain todos across different app launches,
// but serves as a quick in-session cache.
final class InMemoryCache: Cache {

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
        var temp = Todo(id: UUID(), title: toDo, isCompleted: isCompleted)
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
    }
    
    func deleteToDo(choiceToDelete : Int) {
        if currentToDoList.indices.contains(choiceToDelete-1) {
            currentToDoList.remove(at: choiceToDelete - 1)
        }
        else {
            print("Choice \(choiceToDelete) does not exist.  Please select a valid choice")
        }
    }

}



// * The `App` class should have a `func run()` method, this method should perpetually
//   await user input and execute commands.
//  * Implement a `Command` enum to specify user commands. Include cases
//    such as `add`, `list`, `toggle`, `delete`, and `exit`.
//  * The enum should be nested inside the definition of the `App` class
final class App {

    public enum Command {
        case add
        case list
        case toggle
        case delete
        case exit
    }
        
        func run() {
            // Run perpetually
            while true {
                askQuestion()
                
                // Wait for a bit before asking again
                Thread.sleep(forTimeInterval: 5.0)
            }
            
        }
    
    // Function to prompt for a question
    func askQuestion() {
        print("Ask your question: ")
        
        // Simulate user input (replace this with actual input logic)
        if let userInput = readLine() {
            handleQuestion(userInput)
        }
    }

    // Function to handle the question
    func handleQuestion(_ question: String) {
        // Simple logic to respond to a question
        if question.lowercased().contains("hello") {
            print("Hello! How can I help you?")
        } else {
            print("I'm not sure how to answer that.")
        }
    }
        
}



// TODO: Write code to set up and run the app.

var runApp = App()
runApp.run()
