//
//  Testview.swift
//  Noted
//
//  Created by Tino Purmann on 03.06.22.
//

import SwiftUI

struct Testview: View {
    var body: some View {
        VStack (alignment: .leading) {
            Titlebox()
            RoundedRectangle(cornerRadius: 13).stroke(Color(UIColor.systemGray5), lineWidth:1).frame(width: 294, height: 48).overlay(
                Text("Categories").font(.caption).foregroundColor(Color(UIColor.systemGray2)).padding(.top, 4.0).padding(.leading, 6.0) , alignment: .topLeading
            )
            HStack () {
                Dateviewbox()
                Pageviewbox()
                
            }
        
        
    }
    }
}

struct Testview_Previews: PreviewProvider {
    static var previews: some View {
        Testview().environmentObject(Note())
    }
}

struct Titlebox: View {
    @EnvironmentObject var note: Note
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 13).stroke(Color(UIColor.systemGray5), lineWidth:1).frame(width: 294, height: 48).overlay(
                Text("Title").font(.caption).foregroundColor(Color(UIColor.systemGray2)).padding(.top, 4.0).padding(.leading, 6.0) , alignment: .topLeading
            )
            TextField("Add a Title", text: $note.title).padding(.leading, 8.0).padding(.bottom, 8.0).frame(width: 294, height: 40, alignment: .bottomLeading)
        }
    }
}

struct Dateviewbox: View {
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 13).stroke(Color(UIColor.systemGray5), lineWidth:1).frame(width: 160, height: 48)
            HStack (alignment: .bottom) {
                DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, displayedComponents: .date, label: { Text("") }).padding(.bottom, 8.0).frame( height: 40)
                Image(systemName: "calendar").frame( height: 48)
            }.labelsHidden().padding(.leading, 5)
        }
    }
}

struct Pageviewbox: View {
    var body: some View {
        ZStack (alignment: .bottomLeading) {
            RoundedRectangle(cornerRadius: 13).stroke(Color(UIColor.systemGray5), lineWidth:1).frame(width: 120
                                                                                                     , height: 48).overlay(
                                                                                                        Text("Multipage?").font(.caption).foregroundColor(Color(UIColor.systemGray2)).padding(.top, 4.0).padding(.leading, 6.0) , alignment: .topLeading
                                                                                                     )
            Text("No").padding(.leading, 8.0).padding(.bottom, 8.0).frame( height: 40, alignment: .bottomLeading)
        }
    }
}

