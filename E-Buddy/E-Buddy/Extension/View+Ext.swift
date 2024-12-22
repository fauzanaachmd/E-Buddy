//
//  View+Ext.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 22/12/2024.
//

import Combine
import SwiftUI

struct PublishedDataStateModifier<TheValue>: ViewModifier {
    var data: Published<DataState<TheValue>>.Publisher
    var onSuccess: ((TheValue) -> Void)?
    var onLoading: ((Bool) -> Void)?
    var onFailed: ((Error) -> Void)?

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(data) { state in
                switch state {
                case .success(let value):
                    onLoading?(false)
                    onSuccess?(value)
                case .loading:
                    onLoading?(true)
                case .failed(let error):
                    onLoading?(false)
                    onFailed?(error)
                default:
                    break
                }
            }
    }
}

struct DBPLoadingModifier: ViewModifier {
    @Binding var isLoading: Bool
    @State var isIndicatorShown = false

    func body(content: Content) -> some View {
        ZStack {
            content
            
            ProgressView()
                .opacity(isIndicatorShown ? 1 : 0)
        }
        .onChange(of: isLoading) { _ in
            isIndicatorShown.toggle()
        }
    }
}

extension View {
    func onChange<TheValue>(
        dataState: Published<DataState<TheValue>>.Publisher,
        success: ((TheValue) -> Void)? = nil,
        loading: ((Bool) -> Void)? = nil,
        failed: ((Error) -> Void)? = nil
    ) -> some View {
        modifier(PublishedDataStateModifier(
            data: dataState,
            onSuccess: success,
            onLoading: loading,
            onFailed: failed
        ))
    }

    func showLoading(isShowing: Binding<Bool>) -> some View {
        self.modifier(DBPLoadingModifier(isLoading: isShowing))
    }
}
