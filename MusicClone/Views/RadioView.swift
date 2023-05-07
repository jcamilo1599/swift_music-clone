//
//  RadioView.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 2/05/23.
//

import SwiftUI

struct RadioView: View {
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false, content: {
                Text("Radio")
                    .padding(.top, 25)
            })
        }
    }
}

struct RadioView_Previews: PreviewProvider {
    static var previews: some View {
        RadioView()
    }
}
