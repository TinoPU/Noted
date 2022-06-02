//
//  ContentView.swift
//  Noted
//
//  Created by Tino Purmann on 03.06.22.
//

import SwiftUI
import CTScanText
import AudioToolbox

struct ContentView: View {
    init() {
            UITextView.appearance().backgroundColor = .clear
        }
    @EnvironmentObject var note: Note
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack {
            Infobar()
                .padding(.horizontal)
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Titlebox()
                    Categoriesviewbox()
                    HStack() {
                        Dateviewbox()
                        Spacer()
                        Pageviewbox()
                    }.frame(width: 294)
                }
                NotedStack()
                
            }.padding(.horizontal)
            Scannedtextpreview()
            Tagsviewbox()
            Button(action: {}, label:
                    { Text("Save").fontWeight(.bold).foregroundColor(Color.black).frame(width: 294, height: 48).background(Color.white).cornerRadius(13)
                
            })

            }
        }.background(Color(UIColor.systemBackground))

        }
                
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.colorScheme, .dark).environmentObject(Note())
    }
}

struct Infobar: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var note: Note
    @State private var showingSheet = false
    var body: some View {
        HStack {
            Button(action: {
                note.categories = []
                note.tags = []
                note.title = ""
            }, label: {Image(systemName: "delete.backward").font(.system(size: 25))})
            Spacer()
            Button(action: {showingSheet.toggle()}, label: {Image(systemName: "info.circle").font(.system(size: 25)).padding(.trailing,6.0)})
        }.foregroundColor(colorScheme == .dark ? Color.white : Color.black).sheet(isPresented: $showingSheet) {
            SheetView()
        }
    }
}

struct NotedStack: View {
    @State private var Importance_values = ["N", "O", "T", "E", "D"]
    @State private var selectedImportance_value = "T"
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 45).foregroundColor(Color(UIColor.systemGray5))
            VStack(spacing: 6) {
                    ForEach(Importance_values, id:\.self) {Importance_value in
                            Text(Importance_value)
                                .font(.title2)
                                .fontWeight(.bold).foregroundColor(self.selectedImportance_value == Importance_value ? Color.orange : Color.white)
                                .onTapGesture {
                                    selectedImportance_value = Importance_value
                        }
                }
            }
    }
    }
}

struct Categoriesviewbox: View {
    @EnvironmentObject var note: Note
    private var gridItemLayout = [GridItem(.flexible(minimum: 5, maximum: 20))]
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 13).stroke(Color(UIColor.systemGray5), lineWidth:1).frame(width: 294, height: 48).overlay(
                Text("Categories").font(.caption).foregroundColor(Color(UIColor.systemGray2)).padding(.top, 4.0).padding(.leading, 6.0) , alignment: .topLeading)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItemLayout) {
                    ForEach(note.categories, id:\.self) {category in
                        ZStack {
                            Rectangle().stroke(Color.yellow).frame(width:  (CGFloat(category.count) * 8 + 20) ,height: 20)
                            HStack {
                                    Text(category).foregroundColor(Color.yellow).font(.caption).fontWeight(.bold)
                                    Image(systemName: "xmark").font(.system(size: 10)).foregroundColor(Color.yellow)
                        }
                        }
                    }
                    
                }.padding(.leading,8.0).frame(width: 290, height: 35, alignment: .bottomLeading)
            }.frame(width: 290)
        }
    }
}

struct Scannedtextpreview: View {
    @State var scanned_text = ""
    @EnvironmentObject var note: Note
    @State private var processing = false
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 13).foregroundColor(Color(UIColor.systemGray5)).frame(minHeight: 350).padding(.horizontal)
            ScanTextEditor("Add a note...", text: $scanned_text)
                .padding(.horizontal, 20).font(.footnote)
            VStack {
                Spacer()
                HStack (alignment: .bottom) {
                    Spacer()
                    if scanned_text != "" && scanned_text != note.previous_processed_text {
                        Button(action: {
                            print ("pressed")
                            Task {
                                processing.toggle()
                                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                                let decoded = await note.processtext(textoprocess: scanned_text)
                                
                                note.categories = decoded.categories
                                note.tags = decoded.tags
                                note.previous_processed_text = scanned_text
                                processing.toggle()
                                
                            }
                            
                        }
                               , label: {
                            Image(systemName: "checkmark.circle").resizable().frame(width: 25, height: 25).foregroundColor(Color.green)
                        })
                    }
                }.padding(.horizontal, 25)
            }.padding(.bottom, 10)
        }.sheet(isPresented: $processing) {
            Loadingview()
        }
    }
}

struct Tagsviewbox: View {
    @EnvironmentObject var note: Note
    private var gridItemLayout = [GridItem(.flexible(minimum: 5, maximum: 20),alignment: .leading), GridItem(.flexible(minimum: 5, maximum: 20), alignment: .leading), GridItem(.flexible(minimum: 5, maximum: 20), alignment: .leading)]
    @State var textwidth: CGFloat = 0
    var body: some View {
        ZStack (alignment: .bottom){
            RoundedRectangle(cornerRadius: 13).stroke(Color(UIColor.systemGray5), lineWidth:1).frame(height: 100).overlay(
                Text("Tags").font(.caption).foregroundColor(Color(UIColor.systemGray2)).padding(.top, 4.0).padding(.leading, 6.0) , alignment: .topLeading).padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid (rows: gridItemLayout) {
                    ForEach(note.tags, id:\.self) {tag in
                        ZStack {
                            Rectangle().stroke(Color.purple).frame(width: (CGFloat(tag.count) * 8 + 20) ,height: 20)
                            HStack {
                                    Text(tag).foregroundColor(Color.purple).font(.caption).fontWeight(.bold)
                                    Image(systemName: "xmark").font(.system(size: 10)).foregroundColor(Color.purple)
                                }
                    }
                }
                }.padding(.horizontal, 8.0).padding(.bottom, 5)
            }.frame(width: 340, height: 80, alignment: .topLeading)
        }
    }
}

struct SheetView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            LogoView()
            VStack (alignment: .leading){
                Text("Welcome to NOTED! An app that helps you tag and categorize handwritten notes. ").foregroundColor(Color.white)
                Text("How it works").font(.title2).fontWeight(.bold).foregroundColor(Color.white).padding(.vertical,5)
                Text("Using Apples built-in LiveText feature NOTED scans your handwriting and extracts text. Your note then gets sent to an external application for processing. ").foregroundColor(Color.white)
                HStack (spacing: 3) {Text("N O").fontWeight(.bold).foregroundColor(Color.white)
                    Text("T").fontWeight(.bold).foregroundColor(Color.orange)
                    Text("E D").fontWeight(.bold).foregroundColor(Color.white)
                }.padding(.vertical,5)
                Text("NOTED lets you assign a value of importance from 1 (N: Not important) to 5 (D: Determining) to your note.").foregroundColor(Color.white)
                Text("To Start").font(.title2).fontWeight(.bold).foregroundColor(Color.white).padding(.vertical, 5)
                Text("Simply start by entering the 'Add a note' field and press \(Image(systemName: "text.viewfinder")) to scan a note.").foregroundColor(Color.white).padding(.bottom, 2)
                    Text("Hit \(Image(systemName: "checkmark.circle")) in the bottom right corner to process.").foregroundColor(Color.white)
            }
            Spacer()
            Button("Got it") {
                dismiss()
            }
            .font(.title2)
            .foregroundColor(Color.orange).padding()
            Spacer()
        }.padding().background(Color(UIColor.black).edgesIgnoringSafeArea(.all))
    }
}
