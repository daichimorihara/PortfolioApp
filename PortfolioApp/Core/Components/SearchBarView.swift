//
//  SearchBarView.swift
//  PortfolioApp
//
//  Created by Daichi Morihara on 2022/06/06.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    @FocusState var focusedField: Bool
    
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? .theme.secondary : .theme.accent)
            
            TextField("Search by name or symbol...", text: $searchText)
                .focused($focusedField)
                .foregroundColor(.theme.accent)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)

        }
        .overlay(
            Image(systemName: "x.circle.fill")
                .foregroundColor(.theme.accent)
                .opacity(searchText.isEmpty ? 0.0 : 1.0)
                .padding()
                .onTapGesture {
                    searchText = ""
                    focusedField = false
                }
            ,alignment: .trailing
        )
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.theme.background)
                .shadow(color: .theme.accent.opacity(0.3),
                        radius: 10, x: 0, y: 0)
        )
        .padding()
        

    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant("ff"))
    }
}
