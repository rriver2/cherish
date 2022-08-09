//
//  SelectingInspirationView.swift
//  Cherish
//
//  Created by 이가은 on 2022/08/03.
//

import SwiftUI

struct SelectingInspirationView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isModalShow: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text("Chapter1.")
                    .font(.semiboldTitle)
            }
            .navigationBarTitle(Record.inspiration.writingMainText, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .accentColor(.defaultText)
    }
}

struct SelectingInspirationView_Previews: PreviewProvider {
    static var previews: some View {
        SelectingInspirationView(isModalShow: .constant(false))
    }
}
