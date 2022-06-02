//
//  Processhandler.swift
//  Noted
//
//  Created by Tino Purmann on 05.06.22.
//

import Foundation
import SwiftUI
@MainActor class Note: ObservableObject {
    
    @Published public var categories = [String]()
    @Published public var tags = [String]()
    @Published public var previous_processed_text = ""
    @Published public var processing = false
    @Published public var title = ""
    
    func updateviewinput(jsonobject: JsonreturnObject) {
        categories = jsonobject.categories
        tags = jsonobject.tags
        print("View updated")
        print(categories)
        print(tags)
    }

    // declare as a `func`
    func processtext(textoprocess: String) async -> JsonreturnObject {
        let package = JsonsendObject(note: textoprocess)
        let encoder = JSONEncoder()
        let data_send = try! encoder.encode(package)
        let process_url = URL(string: "https://notedapp-spmkhztddq-ew.a.run.app/processnote")!
        var request = URLRequest(url: process_url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        print(data_send)
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: data_send)
            let decodedData = try JSONDecoder().decode(JsonreturnObject.self, from: data)
            print(decodedData)
            updateviewinput(jsonobject: decodedData)
            return decodedData
        }
        catch {
            print("Something went wrong")
        }
        return JsonreturnObject(categories: [], tags: [])
    }
    
}

struct JsonsendObject: Codable {
    var note: String
}

struct JsonreturnObject : Codable {
    var categories: [String]
    var tags: [String]
}
