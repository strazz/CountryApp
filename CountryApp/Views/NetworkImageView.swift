//
//  RemoteImage.swift
//  CountryApp
//
//  Created by Giovanni Romaniello on 02/01/22.
//

import SwiftUI
import Combine

//NOTE: AsyncImage has still some issues with recycled views
@MainActor
struct NetworkImageView: View {
    
    @ObservedObject private var imageModel: ImageModel
    init(url: URL?) {
        imageModel = ImageModel(url: url)
    }
    var body: some View {
        if imageModel.isLoading {
            ProgressView()
        } else {
            imageModel
                .image
                .map { image in
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                }
        }

    }
}
