import Foundation
import Combine

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task1] = []
    @Published var isLoading: Bool = false

    let tasksKey = "tasks_key"

    init() {
        loadTasks()
    }

    func saveTasks() async {
      
      
       
        do {
            
            let encoded = try JSONEncoder().encode(tasks)
          
            UserDefaults.standard.set(encoded, forKey: tasksKey)
            print("Updated Save Task")
            
            
        } catch {
            print("Failed to encode tasks: \(error.localizedDescription)")
        }
        
       
        
    }

    func loadTasks() {
        isLoading = true
        DispatchQueue.global().async {
            if let savedTasks =  UserDefaults.standard.data(forKey: self.tasksKey) {
                if let decodedTasks = try? JSONDecoder().decode([Task1].self, from: savedTasks) {
                    DispatchQueue.main.async {
                        self.tasks = decodedTasks
                        self.isLoading = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
    }

    func addTask(name1: String) {
        let newTask = Task1(name: name1)
        tasks.append(newTask)
        
        Task {
            DispatchQueue.main.async {
                print("True")
                self.isLoading = true
            }
            await saveTasks() 
            DispatchQueue.main.async {
                print("False")
                self.isLoading = false
            }
        }
        
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        
        Task {
            DispatchQueue.main.async {
                print("True")
                self.isLoading = true
            }
            await saveTasks() // Save tasks after deletion
            DispatchQueue.main.async {
                print("false")
                self.isLoading = false
            }
        }
      
    }
}

