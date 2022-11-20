//
//  PriceView.swift
//  EPWatch
//
//  Created by Jonas Bromö on 2022-09-16.
//

import SwiftUI
import EPWatchCore

struct PriceView: View {

    let currentPrice: PricePoint
    let prices: [PricePoint]
    let limits: PriceLimits
    let currencyPresentation: CurrencyPresentation
    let chartStyle: PriceChartStyle

    @State private var displayedPrice: PricePoint

    init(
        currentPrice: PricePoint,
        prices: [PricePoint],
        limits: PriceLimits,
        currencyPresentation: CurrencyPresentation,
        chartStyle: PriceChartStyle
    ) {
        self.currentPrice = currentPrice
        self.prices = prices
        self.limits = limits
        self.currencyPresentation = currencyPresentation
        self.chartStyle = chartStyle
        _displayedPrice = .init(initialValue: currentPrice)
    }

    var body: some View {
        VStack(spacing: 8) {
            Text(displayedPrice.formattedPrice(.normal, currencyPresentation))
                .font(.title)
            Text(displayedPrice.formattedTimeInterval(.normal))
                .font(.subheadline)
            PriceChartView(
                displayedPrice: $displayedPrice,
                currentPrice: currentPrice,
                prices: prices,
                limits: limits,
                currencyPresentation: currencyPresentation,
                chartStyle: chartStyle,
                useCurrencyAxisFormat: true
            )
        }
        .padding(.vertical, 8)
    }

}

struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        PriceView(
            currentPrice: .mockPrice,
            prices: .mockPrices,
            limits: .mockLimits,
            currencyPresentation: .automatic,
            chartStyle: .lineInterpolated
        )
    }
}

