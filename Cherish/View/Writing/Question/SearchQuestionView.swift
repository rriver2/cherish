//
//  SearchQuestionView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/16.
//

import SwiftUI

struct SearchQuestionView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    @Binding var isModalShow: Bool
    @FocusState private var isKeyboardOpen: Bool
    @State private var searchText: String = ""
    @State var isEditMode = false
    @State private var searchedQuestionList: [String] = QuestionData.randomQuestion(amount: 3)
    @ObservedObject var questionViewModel: QuestionViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            NavigationBar()
            SearchBar()
                .padding(.bottom, searchText == "" ? 20 : 11)
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0) {
                    if searchText == "" {
                        Text("오늘의 추천 질문")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.miniSemibold)
                            .foregroundColor(.gray8A)
                            .padding(.horizontal, 38)
                            .padding(.bottom, 15)
                    }
                    QuestionList()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: searchText) { newValue in
            if newValue == "" {
                searchedQuestionList = QuestionData.randomQuestion(amount: 3)
            } else {
                searchedQuestionList = QuestionData.allList.filter { question in
                    question.contains(searchText)
                }
            }
        }
        .onAppear {
            isKeyboardOpen = true
        }
        .tint(Color.gray23)
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
            Rectangle()
                .frame(width: 13, height: 9)
                .font(.bodyRegular)
                .foregroundColor(.clear)
        }
        .foregroundColor(.gray23)
        .padding(.top, 25)
        .paddingHorizontal()
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
        .paddingHorizontal()
    }
    @ViewBuilder
    private func QuestionList() -> some View {
        ForEach(searchedQuestionList, id: \.self) { question in
            NavigationLink {
                QuestionView(questionViewModel: questionViewModel, isModalShow: $isModalShow, isEditMode: $isEditMode )
                    .onAppear {
                        questionViewModel.title = question
                    }
            } label: {
                VStack(alignment: .leading, spacing: 0){
                    Text(question)
                        .padding(.vertical, 25)
                        .paddingHorizontal()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .lineSpacing()
                        .font(.bodyRegular)
                        .foregroundColor(.gray23)
                    divider(colorScheme)
                }
            }
        }
    }
}

struct SearchQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        SearchQuestionView(isModalShow: .constant(false), questionViewModel: QuestionViewModel())
            .environmentObject(TimeLineViewModel())
            .environmentObject(SoundViewModel())
            .environmentObject(DarkModeViewModel())
    }
}
