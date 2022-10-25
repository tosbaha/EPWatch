//
//  RootView.swift
//  EPWatch WatchKit Extension
//
//  Created by Jonas Bromö on 2022-08-25.
//

import SwiftUI
import EPWatchCore
import Charts

struct RootView: View {

    @EnvironmentObject private var state: AppState

    var body: some View {
        NavigationStack {
            TabView {
                if let currentPrice = state.currentPrice {
                    PriceView(
                        currentPrice: currentPrice,
                        prices: state.prices.filterInSameDayAs(currentPrice),
                        limits: state.priceLimits,
                        currencyPresentation: state.currencyPresentation
                    )
                } else if state.isFetching {
                    Text("Fetching prices...")
                        .padding()
                } else {
                    VStack {
                        Image(systemName: "x.circle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.red)
                            .frame(height: 40)
                        Text("\(state.userPresentableError?.localizedDescription ?? "")")
                            .font(.caption)
                    }
                }
                SettingsView()
            }
            .tabViewStyle(.page)
        }
    }

}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(AppState.mocked)
        RootView()
            .environmentObject(AppState.mockedWithError)
            .previewDisplayName("Error")
    }
}