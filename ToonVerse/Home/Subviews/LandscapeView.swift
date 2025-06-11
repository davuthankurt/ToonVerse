//
//  LandscapeView.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 30.05.2025.
//

import SwiftUI

struct LandscapeView: View {
    @Environment(SelectionModel.self) var selectionModel
    @Binding var isShowingPicker: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            stackTitle
            scrollView
        }
        .background(.myBackground)
    }
    
    private var stackTitle: some View {
        Text("Editor's Picks")
            .font(.title.bold())
            .foregroundStyle(.white)
            .padding([.horizontal, .top])
    }
    
    private var scrollView: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            filterStack
//        }
//        .scrollTargetBehavior(.paging)
//        .ignoresSafeArea()
        TabView {
            filterView(AIFilter.landscapeFilters[0])
            filterView(AIFilter.landscapeFilters[1])
            filterView(AIFilter.landscapeFilters[2])
        }
        .tabViewStyle(.page)
        .frame(maxWidth: .infinity)
        .frame(height: 330)
    }
//    
//    private var filterStack: some View {
//        HStack(spacing: .zero) {
//            ForEach(AIFilter.landscapeFilters) { filter in
//                filterView(filter)
//            }
//        }
//    }
    
    private func filterView(_ filter: AIFilter) -> some View {
        ZStack(alignment: .bottom) {
            filterImage(filter)
            filterText(filter)
        }
        .padding(.bottom)
//        .containerRelativeFrame(.horizontal)
    }
    
    private func filterImage(_ filter: AIFilter) -> some View {
        Image(filter.image)
            .resizable()
            .scaledToFill()
            .clipped()
            .frame(maxWidth: .infinity)
            .frame(height: 250)
            .clipShape(.rect(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 1)
            }
            .onTapGesture {
                isShowingPicker = true
                selectionModel.selectedPrompt = filter
            }
            .padding(.horizontal)
    }
    
    private func filterText(_ filter: AIFilter) -> some View {
        Text(filter.title)
            .font(.title3)
            .bold()
            .frame(maxWidth: .infinity)
            .padding(8)
            .foregroundStyle(.white)
            .background(
                ZStack {
                    Color.myBackground.opacity(0.5).blur(radius: 10)
                }
            )
    }
}

#Preview {
    @State var model = SelectionModel()
    LandscapeView(isShowingPicker: .constant(false))
        .environment(model)
}
