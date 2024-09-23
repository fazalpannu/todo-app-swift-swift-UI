//
//  ContentView.swift
//  userlist
//
//  Created by Ml Bench on 18/09/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TaskViewModel()
  
    @State private var newTaskName = ""
    
    var body: some View {
        NavigationStack  {
            ZStack{
                
                VStack {
                    HStack {
                        
                        TextField("Please  Enter new task", text: $newTaskName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(
                            action: {
                                if !newTaskName.isEmpty {
                                    viewModel.addTask(name1: newTaskName)
                                    
                                    
                                    
                                    newTaskName = ""
                                }
                            }) {
                                Image(systemName: "plus")
                                
                            }
                            .padding()
                    }
                    .padding()
                    
                    List {
                        ForEach(viewModel.tasks) { task in
                            Text(task.name)
                           
                        }
                        .onDelete(perform: viewModel.deleteTask(at:))
                    }
                    
                }
                
                if viewModel.isLoading {
                    
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 100, height: 100)
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                                .scaleEffect(2)
                        )
                        .background(Color.gray.opacity(0.18))
                        .cornerRadius(10)
                }
            }
            .navigationTitle("To-Do List")
            //            .onAppear(){
            //                print("appearing")
            //                viewModel.loadTasks()
            //            }
            //            .onDisappear() {
            //                viewModel.saveTasks()
            //                print("Disappearing")
            //            }
        
            
            
        }
    }
}

#Preview {
    ContentView()
}

