//
//  Loadingview.swift
//  Noted
//
//  Created by Tino Purmann on 06.06.22.
//

import SwiftUI

struct Loadingview: View {
    var body: some View {
        
        HStack {Spacer()
            VStack{Spacer()
                Text("N").font(.largeTitle).fontWeight(.bold).foregroundColor(Color.orange).padding()
                Text("Processing...").font(.title3).foregroundColor(Color.white).padding()
                Spacer()
            }
            Spacer()
        }.background(Color.black)
        
        
    }
}

struct Loadingview_Previews: PreviewProvider {
    static var previews: some View {
        Loadingview()
    }
}
