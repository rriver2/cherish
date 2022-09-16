//
//  DateView.swift
//  Cherish
//
//  Created by 이가은 on 2022/09/12.
//

import SwiftUI

struct DateView: View {
    @Environment(\.dismiss) private var dismiss
    @State var date: Date
    @Binding var writingDate: Date
    
    init(date: Date, writingDate: Binding<Date>) {
        self._date = State(initialValue: date)
        self._writingDate = writingDate
    }
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationBar()
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .padding(.horizontal, 20)
            
            HStack(spacing: 0) {
                Text("오늘")
                    .foregroundColor(.gray23)
                    .onTapGesture {
                        date = Date()
                    }
                Spacer()
            }
            .paddingHorizontal()
            .font(.miniRegular)
            Spacer()
        }
        .accentColor(Color.gray23)
        .navigationBarBackButtonHidden(true)
    }
}

extension DateView {
    @ViewBuilder
    private func NavigationBar() -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.gray23)
                    .font(.bodyRegular)
            }
            Spacer()
            Text("날짜 변경")
                .font(.bodySemibold)
                .foregroundColor(Color.gray23)
            Spacer()
            Button(action: {
                writingDate = date
                dismiss()
            }) {
                Text("완료")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundColor(.gray23)
            }
        }
        .paddingHorizontal()
        .padding(.top, 25)
        .padding(.bottom, 28)
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(date: Date(), writingDate: .constant(Date()))
    }
}
