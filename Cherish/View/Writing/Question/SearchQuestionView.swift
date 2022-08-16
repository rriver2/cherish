//
//  SearchQuestionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/16.
//

import SwiftUI

struct SearchQuestionView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isModalShow: Bool
    @GestureState private var dragOffset = CGSize.zero
    @FocusState private var isKeyboardOpen: Bool
    @State private var searchText: String = ""
    @State private var searchedQuestionList: [String] = QuestionData.randomQuestion(amount: 3)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBar()
            SearchBar()
            ScrollView(showsIndicators: false) {
                if searchText == "" {
                        Text("오늘의 추천 질문")
                        .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.miniSemibold)
                            .foregroundColor(.gray8A)
                            .padding(.horizontal, 38)
                            .padding(.top, 20)
                }
                QuestionList()
            }
        }
        .onChange(of: searchText) { newValue in
            if newValue == "" {
                searchedQuestionList = QuestionData.randomQuestion(amount: 3)
            } else {
                searchedQuestionList = QuestionData.allList.filter { question in
                    question.contains(searchText)
                }
            }
        }
        .tint(Color.gray23)
        .gesture(DragGesture().updating($dragOffset) { (value, state, transaction) in
            if (value.startLocation.x < 30 && value.translation.width > 100) {
                dismiss()
            }
        })
        .animation(Animation.easeInOut(duration: 0.2), value: searchText)
    }
}
extension SearchQuestionView {
@ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .font(.bodyRegular)
            }
            Spacer()
            Text("질문 찾아보기")
                .font(.bodySemibold)
                .foregroundColor(Color.gray23)
            Spacer()
                Image(systemName: "checkmark")
                    .font(.bodyRegular)
                    .foregroundColor(.clear)
        }
        .foregroundColor(.gray23)
        .padding(.top, 25)
        .padding(.horizontal, 27)
    }
    @ViewBuilder
    private func SearchBar() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                    .font(.bodyRegular)
                    .foregroundColor(Color.gray23)
                    .padding(.trailing, 7)
                TextField("질문 검색", text: $searchText)
                    .submitLabel(.done)
                    .font(.bodyRegularSmall)
                    .focused($isKeyboardOpen)
                    .foregroundColor(.gray23)
                if searchText != "" {
                    Button(action: {
                        searchText = ""
                        isKeyboardOpen = false
                    }) {
                        Image(systemName: "multiply.circle.fill")
                            .foregroundColor(Color.gray23.opacity(0.5))
                            .padding(.trailing, 15)
                            .frame(width: 18, height: 18)
                            .background(Color.grayF5)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 9)
            .background(Color.grayF5)
            .cornerRadius(5)
        }
        .padding(.top, 34)
        .padding(.horizontal, 27)
    }
    @ViewBuilder
    private func QuestionList() -> some View {
        ForEach(searchedQuestionList, id: \.self) { question in
            NavigationLink {
                QuestionView(title: question, isModalShow: $isModalShow )
            } label: {
                VStack(alignment: .leading, spacing: 0){
                    Text(question)
                        .padding(.vertical, 25)
                        .padding(.horizontal, 27)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .lineSpacing()
                        .font(.bodyRegular)
                        .foregroundColor(.gray23)
                    dividerGrayE8
                }
            }
        }
    }
}

struct SearchQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchQuestionView(isModalShow: .constant(false))
            .preferredColorScheme(.dark)
    }
}
