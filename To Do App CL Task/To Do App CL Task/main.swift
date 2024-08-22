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
 class JSONFileManagerCache: Cache {
    
    // Get the file URL for saving/loading the ToDo array- courtesy of StackOverflow
        static func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
        
        static func getFileURL() -> URL {
            return getDocumentsDirectory().appendingPathComponent("todos.json")
        }
    
    
    func load() -> [Todo]? {
        let decoder = JSONDecoder()
                do {
                    let data = try Data(contentsOf: JSONFileManagerCache.getFileURL())
                    let todos = try decoder.decode([Todo].self, from: data)
                    print("Loaded successfully")
                    return todos
                } catch {
                    print("Failed to load todos from file system: \(error)")
                    return nil
            }
    }
  
    
    func save(todos: [Todo]) {
        let encoder = JSONEncoder()
                do {
                    let data = try encoder.encode(todos)
                    try data.write(to: JSONFileManagerCache.getFileURL(), options: .atomic)
                    print("Saved successfully")
                } catch {
                    print("Failed to save todos to file system: \(error)")
                }
            }
    }

// `InMemoryCache`: : Keeps todos in an array or similar structure during the session.
// This won't retain todos across different app launches,
// but serves as a quick in-session cache.
 class InMemoryCache: Cache {
    private var todos: [Todo] = []
    func save(todos: [Todo]) {
        self.todos = todos
    }
    
    func load() -> [Todo]? {
        return todos.isEmpty ? nil : todos
    }
    

}

// The `TodosManager` class should have:
// * A function `func listTodos()` to display all todos.
// * A function named `func addTodo(with title: String)` to insert a new todo.
// * A function named `func toggleCompletion(forTodoAtIndex index: Int)`
//   to alter the completion status of a specific todo using its index.
// * A function named `func deleteTodo(atIndex index: Int)` to remove a todo using its index.
  class TodoManager {
     //for cache
     private let cache: Cache
     private(set) var currentToDoList: [Todo] = []

     init(cache: Cache) {
             self.cache = cache
             self.currentToDoList = cache.load() ?? []
         }
     
    func addToDo(toDo: String, isCompleted: Bool = false) {
        let temp = Todo(id: UUID(), title: toDo, isCompleted: isCompleted)
        currentToDoList.append(temp)
        cache.save(todos: currentToDoList)
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
            cache.save(todos: currentToDoList)
        }
        else {
            print("Choice \(choiceToToggle) does not exist.  Please select a valid choice")
        }
        print("Item \(choiceToToggle) has switched status")
    }
    
    func deleteToDo(choiceToDelete : Int) {
        if currentToDoList.indices.contains(choiceToDelete-1) {
            currentToDoList.remove(at: choiceToDelete - 1)
            cache.save(todos: currentToDoList)
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
class App {
    
    private let todoManager: TodoManager
        
        init(todoManager: TodoManager) {
            self.todoManager = todoManager
        }
    
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
                    todoManager.addToDo(toDo: task)
                }
                print("Task Added")
                
            case .list:
                todoManager.listToDos()
                
            case .toggle:
                print("Which item status do you want to switch")
                if let task = readLine() {
                    todoManager.toggleToDo(choiceToToggle: Int(task)!)
                }
                
            case .delete:
                print("Which item do you want to remove")
                if let task = readLine() {
                    todoManager.deleteToDo(choiceToDelete: Int(task)!)
                }
                
            case .exit:
                exit(0)
            }
        }

    }
        
}



// TODO: Write code to set up and run the app.

//Choosing inMemory

let inMemoryCache = InMemoryCache()
let todoManager = TodoManager(cache: inMemoryCache)
let app = App(todoManager: todoManager)
app.run()

