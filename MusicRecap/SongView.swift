//
//  SongView.swift
//  MusicRecap
//
//  Created by Benjamin Alexander on 14/09/2023.
//

import SwiftUI

struct SongView: View {
    @State var song: MusicItem
    var body: some View {
        VStack {
            AsyncImage(url: song.imageURL)
            HStack() {
                VStack() {
                    Text(song.name)
                        .font(.title2)
                        .fontWeight(.bold)
                    Text(song.artist)
                        .font(.caption)
                }
            }
            
        }
    }
}

#Preview {
    SongView(song: .placeholder)
}
