//
//  Signupui.swift
//  Noted
//
//  Created by Tino Purmann on 16.06.22.
//

import SwiftUI


struct Signupui: View {
    var body: some View {
        
        VStack {
            LogoView()
            Spacer()
            HStack {
                Spacer()
                VStack {
                    ZStack (alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: 13).stroke(Color(UIColor.systemGray5), lineWidth:1).frame(width: 294, height: 48).overlay(
                            Text("Username").font(.caption).foregroundColor(Color(UIColor.systemGray2)).padding(.top, 4.0).padding(.leading, 6.0) , alignment: .topLeading)
                    }
                    ZStack (alignment: .bottomLeading) {
                        RoundedRectangle(cornerRadius: 13).stroke(Color(UIColor.systemGray5), lineWidth:1).frame(width: 294, height: 48).overlay(
                            Text("Password").font(.caption).foregroundColor(Color(UIColor.systemGray2)).padding(.top, 4.0).padding(.leading, 6.0) , alignment: .topLeading)
                    }
                }
                Spacer()
            }
            Spacer()
            Button(action: {}, label:
                    { Text("Log In").fontWeight(.bold).foregroundColor(Color.black).frame(width: 294, height: 48).background(Color.white).cornerRadius(13)
                
            })

            Spacer()
        }.background(Color(UIColor.black))
    }
}

struct Signupui_Previews: PreviewProvider {
    static var previews: some View {
        Signupui()
    }
}


struct LogoView: View {
    var body: some View {
        HStack (spacing: 3) {
            Spacer()
            Text("N O").font(.title).foregroundColor(Color.white)
            Text("T").font(.title).foregroundColor(Color.orange)
            Text("E D").font(.title).foregroundColor(Color.white)
            Spacer()
            
        }.padding()
    }
}
