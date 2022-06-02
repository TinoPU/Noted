//
//  Sheetinfoview.swift
//  Noted
//
//  Created by Tino Purmann on 05.06.22.
//
import SwiftUI
import Foundation


struct x: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SheetView()
        }
    }
}
