//
//  StatusChart.swift
//  poke-poke-dex
//
//  Created by kohsaka on 2023/10/04.
//

import DGCharts

class StatusChart: BarChartView {

    var stats: [Int] = [] {
        didSet {
            self.data = BarChartData(dataSet: BarChartDataSet(entries:
                stats.enumerated().map {
                    BarChartDataEntry(x: Double($0.offset), y: Double($0.element))
                })
            )
            self.leftAxis.axisMaximum = Double(stats.max()! > 130 ? stats.max()! : 130)
        }
    }

    override func awakeFromNib() {
        self.animate(yAxisDuration: 1.5)
        self.legend.enabled = false
        self.rightAxis.enabled = false
        self.leftAxis.axisMinimum = 0
        self.leftAxis.axisMaximum = 130
        self.xAxis.valueFormatter = IndexAxisValueFormatter(values: AppConstant.statusLabel)
        self.xAxis.labelPosition = .bottom
        self.xAxis.drawGridLinesEnabled = false
        self.xAxis.granularity = 1
        self.highlightPerTapEnabled = false
        self.pinchZoomEnabled = false
        self.doubleTapToZoomEnabled = false
        self.extraTopOffset = 0
        self.extraRightOffset = 0
        self.extraLeftOffset = 0
        self.extraBottomOffset = 0
    }
}
