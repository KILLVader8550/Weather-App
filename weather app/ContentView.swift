//
//  ContentView.swift
//  weather app
//
//  Created by Narat tassawil on 28/12/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PostViewModel()
    var icons: [String: String] = ["clear sky": "sun.max",
                                  "few clouds": "cloud.sun",
                                  "scattered clouds": "cloud",
                                  "broken clouds": "cloud",
                                  "rain": "cloud.sun.rain",
                                  "thunderstrom": "cloud.bolt.rain",
                                  "shower rain": "cloud.rain",
                                  "snow": "cloud.snow",
                                  "mist": "cloud.fog"]
    
    var body: some View {
        VStack (alignment: .leading) {
            VStack (alignment: .leading) {
                Text("\(viewModel.post?.name ?? "N/A")")
                    .bold()
                    .font(.system(size: 40));
                
                Text("Today,\(Date().formatted(.dateTime.month().day().hour().minute()))")
                    .font(.system(size: 24))
            }
            
             HStack {
                VStack(alignment: .leading) {
                    if let icon = icons[(viewModel.post?.weather.first?.description ?? "N/A")] {
                        Image(systemName: "\(icon)")
                            .font(.system(size: 40))
                    } else {
                        Text("Loading...")
                    }
                
                    Text("\(viewModel.post?.weather.first?.description ?? "N/A")")
                        .bold()
                        .font(.system(size: 20))
                }
                Spacer()
                Text("\(String(format: "%.0f", viewModel.post?.main.temp ?? 0.0))°C")
                    .font(.system(size: 60))
    
            }
             .padding(.top, 15)
            
            Spacer()
            VStack (alignment: .leading) {
                Text("Today's Weather")
                    .bold()
                    .font(.system(size: 24))
            }
            VStack (alignment: .leading) {
                HStack{
                    Image(systemName: "thermometer.low")
                        .imageScale(.large)
                    VStack (alignment: .leading) {
                        Text("Min Temp")
                            .font(.system(size: 18))
                        Text("\(String(format: "%.0f", viewModel.post?.main.temp_min ?? 0.0)) °C")
                            .font(.system(size: 18))
                    }
                    Spacer()
                    
                    Image(systemName: "thermometer.high")
                        .imageScale(.large)
                    VStack (alignment: .leading) {
                        Text("Max Temp")
                            .font(.system(size: 18))
                        Text("\(String(format: "%.0f", viewModel.post?.main.temp_max ?? 0.0)) °C")
                            .font(.system(size: 18))
                    }
                }
                
                HStack{
                    Image(systemName: "wind")
                        .imageScale(.large)
                    VStack (alignment: .leading) {
                        Text("Wind Speed")
                            .font(.system(size: 18))
                        Text("\(String(format: "%.2f", viewModel.post?.wind.speed ?? 0.0))")
                            .font(.system(size: 18))
                    }
                    Spacer()
                    
                    Image(systemName: "humidity")
                        .imageScale(.large)
                    VStack (alignment: .leading) {
                        Text("Humidity")
                            .font(.system(size: 18))
                        Text("\(String(format: "%.2f", viewModel.post?.main.humidity ?? 0.0))")
                            .font(.system(size: 18))
                    }
                }
                .padding(.top, 3)
                
                HStack{
                    Image(systemName: "barometer")
                        .imageScale(.large)
                    VStack (alignment: .leading) {
                        Text("Pressure")
                        Text("\(String(format: "%.2f", viewModel.post?.main.pressure ?? 0.0))")
                            .font(.system(size: 18))
                    }
                }
                .padding(.top, 3)
                
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(25)
        .onAppear {
            viewModel.fetchPost() }
    }
    
}

#Preview {
    ContentView()
}
