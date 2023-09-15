//
//  ContentView.swift
//  MusicRecap
//
//  Created by Benjamin Alexander on 14/09/2023.
//

import SwiftUI
import MusicKit

struct MusicItem: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var artist: String
    var imageURL: URL?
}

extension MusicItem {
    static let placeholder = MusicItem(name: "name", artist: "artist")
}



struct ContentView: View {
    @State var songs = [MusicItem]()
    var body: some View {
        List {
            ForEach(songs) { song in
                SongView(song: song)
            }
            
        }
        .onAppear {
            fetchData()
        }
        
        
    }
    
    func fetchData() -> Void {
        Task {
            var request = MusicCatalogSearchRequest(term: "Happy", types: [Song.self])
            request.limit = 25
            request.includeTopResults = true
            
            let status = await MusicAuthorization.request()
            switch status {
                case .authorized:
                    
                    do {
                        let result = try await request.response()
                        // map the songs array we recieve from the result into a new initaliser for the songs state. very efficient and swifty
                        songs = result.songs.compactMap({
                            return .init(
                                name: $0.title,
                                artist: $0.artistName,
                                imageURL: $0.artwork?.url(width: 75, height: 75)
                            )
                        })
                    } catch {
                        print(String(describing: error))
                    }
                    
                case .denied:
                    break
                case .notDetermined:
                    break
                case .restricted:
                    break
                @unknown default:
                    break
            }
        }
    }
}

#Preview {
    ContentView()
}
