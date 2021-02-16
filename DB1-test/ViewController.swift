//
//  ViewController.swift
//  DB1-test
//
//  Created by Suporte on 16/02/21.
//

import UIKit
import Charts
import TinyConstraints
 

class ViewController: UIViewController,ChartViewDelegate  {
    
    var APIRequest = APIRequestFetcher()
    var transactionSp : Transaction?
    lazy var lineChartView: LineChartView = {
        
        
        fetchResults()
        let chartView = LineChartView()
        //chartView.backgroundColor = .systemBlue
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .lightGray
        yAxis.axisLineColor = .lightGray
        yAxis.labelPosition = .outsideChart
         
        
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .lightGray
        chartView.xAxis.axisLineColor = .gray
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.animate(xAxisDuration: 2.5)
        
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        setData()
    }

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }

    func setData(){
        let set1 = LineChartDataSet(entries:yValues,label: "something")
        
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 1
        set1.setColor(.blue)
        
        
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.highlightLineDashLengths = [8.0, 4.0]
        set1.highlightColor = UIColor.blue
        set1.highlightLineWidth = 2.0
 
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
        
    }
    var yValues: [ ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 10.0),
        ChartDataEntry(x: 10.0, y: 30.0),
        ChartDataEntry(x: 20.0, y: 10.0),
        ChartDataEntry(x: 30.0, y: 10.0),
        ChartDataEntry(x: 40.0, y: 50.0)]

    func fetchResults() {
        APIRequest.search(completionHandler: {
            
            [weak self] results, error in
            if case .failure = error {
                return
            }
            self!.transactionSp = results
             let Axes:[Axis] =  (self!.transactionSp?.values!)!
            for axe in Axes{
                print(axe.x)
                self!.yValues.append(ChartDataEntry(x:Double(axe.x), y: Double(axe.y)))
                
            }
            //ChartDataEntry(x:Double(axe.x), y: Double(axe.y))
            print( self!.yValues)
         })
    }

}

