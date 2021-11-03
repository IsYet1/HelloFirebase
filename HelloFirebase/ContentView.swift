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
    
    init() {
        db = Firestore.firestore()
    }
    
    var body: some View {
        VStack{
            TextField("Enter Task", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Save") {
                let task = Task(title: title)
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
                //                db.collection("tasks").addDocument(data: ["Test": "Data"])
            }
            Spacer()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
