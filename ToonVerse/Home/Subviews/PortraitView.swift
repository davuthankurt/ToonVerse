//
//  PortraitView.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 31.05.2025.
//

import SwiftUI

struct PortraitView: View {
    @Binding var selectionModel: SelectionModel
    @Binding var isShowingPicker: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            stackTitle
            scrollView
        }
        .background(.myBackground)
    }
    
    private var stackTitle: some View {
        Text("Top Styles")
            .font(.title.bold())
            .foregroundStyle(.white)
            .padding(.horizontal)
    }
    
    private var scrollView: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                filterStack
            }
            .scrollTargetBehavior(.viewAligned)
            .ignoresSafeArea()
            .onAppear {
                proxy.scrollTo(2, anchor: .leading)
            }
        }
    }
    
    private var filterStack: some View {
        HStack(spacing: .zero) {
//            ForEach(AIFilter.allCases.filter{ $0.category == .portrait }) { filter in
//                filterView(filter)
//            }
            ForEach(AIFilter.portraitFilters) { filter in
                filterView(filter)
                    .id(filter == .gta ? 2 : Int.random(in: 3...1000))
            }
        }
        .padding(.horizontal, 100)
        .scrollTargetLayout()
    }
    
    private func filterView(_ filter: AIFilter) -> some View {
        VStack(spacing: 0) {
            filterImage(filter)
            filterText(filter)
        }
        .visualEffect({ content, proxy in
            content
                .rotation3DEffect(
                    .degrees(Double(proxy.frame(in: .global).midX - proxy.size.width) / -10),
                    axis: (x: 0, y: 1, z: 0)
                )
        })
    }
    
    private func filterImage(_ filter: AIFilter) -> some View {
        Image(filter.image)
            .resizable()
            .scaledToFill()
            .frame(width: 200, height: 300)
            .clipShape(.rect(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 1)
            }
            .onTapGesture {
                isShowingPicker = true
                selectionModel.selectedPrompt = filter
            }
            .safeAreaPadding()
    }
    
    private func filterText(_ filter: AIFilter) -> some View {
        Text(filter.title)
            .font(.title3)
            .bold()
            .foregroundStyle(.white)
            .padding(.bottom)
    }
}

#Preview {
    @State var model = SelectionModel()
    PortraitView(selectionModel: $model, isShowingPicker: .constant(false))
}
