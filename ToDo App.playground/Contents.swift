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
            print(String(index + 1) +  ". \(item.description)")
        }
    }
    
    func toggleToDo() {
    }
    
    func deleteToDo() {
    }

}

//TEST AREA
var test = TodoManager()
test.addToDo(toDo: "First ToDo")
test.addToDo(toDo: "Second ToDo")
test.addToDo(toDo: "Third ToDo")
print(test.listToDos())

//END OF TEST AREA


// * The `App` class should have a `func run()` method, this method should perpetually
//   await user input and execute commands.
//  * Implement a `Command` enum to specify user commands. Include cases
//    such as `add`, `list`, `toggle`, `delete`, and `exit`.
//  * The enum should be nested inside the definition of the `App` class
final class App {

}


// TODO: Write code to set up and run the app.
