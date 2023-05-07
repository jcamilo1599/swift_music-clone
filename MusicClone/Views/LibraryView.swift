//
//  LibraryView.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 2/05/23.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                Text("Bibliotecha")
                    .padding(.top, 25)
            })
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
