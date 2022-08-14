//
//  FreeView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct FreeView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var timeLineViewModel: TimeLineViewModel
    @State private var title = ""
    @State private var context = "내용"
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TextField("제목", text: $title)
                    .font(.miniTitle)
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                    .padding(.leading, 10)
                    .padding(.horizontal, 20)
                WritingView(context: $context)
                    .padding(.top, 20)
                    .padding(.horizontal, 20)
                Spacer()
            }
            .navigationBarTitle(Record.free.writingMainText, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    SoundView()
                    Spacer()
                    Button {
                        timeLineViewModel.addRecord(date: Date(), title: title, context: context, kind: Record.free)
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
            .textInputAutocapitalization(.never)
        }
    }
}

struct FreeView_Previews: PreviewProvider {
    static var previews: some View {
        FreeView()
            .environmentObject(TimeLineViewModel())
    }
}
