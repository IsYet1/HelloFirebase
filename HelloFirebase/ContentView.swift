//
//  ContentView.swift
//  HelloFirebase
//
//  Created by Don McKenzie on 10/31/21.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import simd

struct ContentView: View {
    private var db: Firestore
    @State private var title: String = ""
    @State private var tasks: [Task] = []
    
    init() {
        db = Firestore.firestore()
    }
    
    private func saveTask(task: Task) {
        do {
            _ = try db.collection("tasks").addDocument(from: task) {err in
                if let err = err {
                    print(err.localizedDescription)
                } else {
                    print("Document has been saved")
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func fetchAllTasks() {
        db.collection("tasks")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    if let snapshot = snapshot {
                        tasks = snapshot.documents.compactMap { doc in
                            return try? doc.data(as: Task.self)
                        }
                    }
                }
                
            }
    }
    
    var body: some View {
        VStack{
            TextField("Enter Task", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save") {
                let task = Task(title: title)
                saveTask(task: task)
            }
            List(tasks, id: \.title) { task in
                Text(task.title)
            }
            Spacer()
            
            .onAppear(perform:  {
                fetchAllTasks()
            })
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
