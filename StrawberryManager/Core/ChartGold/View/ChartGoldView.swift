//
//  ChartGoldView.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 15/08/2023.
//

import SwiftUI
import Charts
struct ChartGoldView: View {
    @ObservedObject var viewModel = ChartGoldModel()
    let refreshInterval: TimeInterval = 60*60*60
    //@State var sampleAnalytics: [RowItemGold] = sample_analytics
    var body: some View {
        NavigationStack {
            VStack {
                //AnimationChart()
                CustomAnimationCharts()
                    .frame(height: 250)
                    .background(charBackground)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .navigationTitle("Biểu Đồ Giá Vàng")
            .padding()
            .onAppear {
                viewModel.fetchAPIGold()
                startTimer()
            }
        }
    }
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: refreshInterval, repeats: true) { _ in
            viewModel.clearData()
            viewModel.fetchAPIGold()
        }
    }
    
    @ViewBuilder
    func AnimationChart() -> some View {
        Chart {
            ForEach(viewModel.gold, id: \.row) { item in
                LineMark(
                    x: .value("Name", item.date),
                    y: .value("$", item.sellPrice)
                )
                
            }
        }
        .chartXAxisLabel(position: .bottom, alignment: .center) {
            Text("Thời gian")
                .font(.headline)
                .foregroundColor(.red)
        }
        .chartYAxisLabel(position: .leading, alignment: .center) {
            Text("Giá Trị")
                .font(.headline)
                .foregroundColor(.blue)
        }
        .padding()
        .frame(width: .infinity,height: 250)
    }
}
struct CustomAnimationCharts: View{
    @ObservedObject var viewModel = ChartGoldModel()
    @State private var percentage: CGFloat = 0
    let data:[Double] = [5.23232,5.111111,5.666666,5.6445555,5.4579788,5.457999,5.777777,5.54545,6.4]
    var maxY: Double = 0
    var minY: Double = 0
    init() {
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
    }
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index+1)
                    let yAxis = maxY - minY
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
                
            }
            .trim(from: 0, to: percentage)
            .stroke(Color.blue, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .overlay(
                VStack(alignment: .leading){
                    Text(viewModel.maxY.formatted())
                    Spacer()
                    Text(viewModel.minY.formatted())
                }, alignment: .leading
            )
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                    withAnimation(.linear(duration: 2.0)){
                        percentage = 1.0
                    }
                }
            }
        }
        
    }
}
extension ChartGoldView{
    private var charBackground : some View {
        VStack{
            Divider()
                .background(Color.black)
            Spacer()
            Divider()
                .background(Color.black)
            Spacer()
            Divider()
                .background(Color.black)
            Spacer()
            Divider()
                .background(Color.black)
            Spacer()
            Divider()
                .background(Color.black)
        }
    }
}
struct ChartGoldView_Previews: PreviewProvider {
    static var previews: some View {
        ChartGoldView()
    }
}

