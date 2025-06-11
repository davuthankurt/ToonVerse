//
//  SquareView.swift
//  ToonVerse
//
//  Created by Davuthan Kurt on 1.06.2025.
//

import SwiftUI

struct SquareView: View {
    @Environment(SelectionModel.self) var selectionModel
    @Binding var isShowingPicker: Bool
}

extension SquareView {
    
    var body: some View {
        VStack(alignment: .leading) {
            stackTitle("Must-Try Filters")
            scrollView(AIFilter.mustTry)
            
            stackTitle("Explore the Collection")
            scrollView(AIFilter.defaultFilters)
        }
        .background(.myBackground)
    }
    
    private func stackTitle(_ str: String) -> some View {
        Text(str)
            .font(.title.bold())
            .foregroundStyle(.white)
            .padding([.horizontal, .top])
    }
    
    private func scrollView(_ filters: [AIFilter]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            filterStack(filters)
        }
        .ignoresSafeArea()
    }
    
    private func filterStack(_ filters: [AIFilter]) -> some View {
        HStack {
//            ForEach(AIFilter.allCases.filter{ $0.category == .square}) { filter in
//                filterView(filter)
//            }
            ForEach(filters) { filter in
                filterView(filter)
            }
        }
    }
    
    private func filterView(_ filter: AIFilter) -> some View {
        VStack {
            filterImage(filter)
            filterText(filter)
        }
        .padding(.horizontal, 5)
//        .containerRelativeFrame(.horizontal, count: 2, spacing: 0)
    }
    
    private func filterImage(_ filter: AIFilter) -> some View {
        Image(filter.image)
            .resizable()
            .scaledToFit()
            .frame(height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 1)
            )
            .onTapGesture {
                isShowingPicker = true
                selectionModel.selectedPrompt = filter
            }
            
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
    SquareView(isShowingPicker: .constant(false))
        .environment(model)
}
