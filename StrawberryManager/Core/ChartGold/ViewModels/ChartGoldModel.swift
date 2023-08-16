//
//  ChartGoldModel.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 15/08/2023.
//

import Foundation

class ChartGoldModel: ObservableObject {
    @Published var gold: [RowItemGold] = []
    @Published var maxY: Double = 6.6
    @Published var minY: Double = 5.5
    func clearData(){
        self.gold = []
    }
    func fileExists(atPath path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    func fetchAPIGold() {
        // Tạo đối tượng DateFormatter để định dạng ngày
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHH"
        guard let url = URL(string: "http://api.btmc.vn/api/BTMCAPI/getpricebtmc?key=3kd8ub1llcg9t45hnoh8hmn7t5kc2v") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    do {
                        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                        
                        // Lấy ngày hiện tại và định dạng thành chuỗi
                        let currentDateString = dateFormatter.string(from: Date())
                            
                        // Đặt tên tệp dựa trên ngày hiện tại
                        let nameFileDataBase = "\(currentDateString).txt"
                      
                        // Đường dẫn tới tệp văn bản .txt
                        let fileURL = URL(fileURLWithPath: "/Users/nguyenngoctrantien/Desktop/Study Swift/Strawberry Manager/StrawberryManager/Data/\(nameFileDataBase)")
                        if self.fileExists(atPath: fileURL.path) {
                            print("File exists")
                        } else {
                            // Ghi dữ liệu vào tệp
                            try data.write(to: fileURL)
//                            // Mở tệp ở chế độ ghi tiếp (append mode)
//                            if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
//                                // Di chuyển con trỏ tới cuối tệp
//                                fileHandle.seekToEndOfFile()
//
//                                // Ghi dữ liệu vào tệp
//                                fileHandle.write(data)
//
//                                // Đóng tệp
//                                fileHandle.closeFile()
//
//                                print("JSON data has been appended to file successfully.")
//                            } else {
//                                print("Could not open file for writing.")
//                            }
                        }
                       
                        for item in apiResponse.DataList.Data {
                            if item.name == "VÀNG MIẾNG VRTL (Vàng Rồng Thăng Long)" {
                                self.gold.append(item)
                            }
                        }
                        let itemMax = self.gold.max{ item1, item2 in
                            return item1.sellPrice < item2.sellPrice
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
        }
        
        task.resume()
    }
}
//{
//    DataList =     {
//        Data =         (
//            {
//                "@d_1" = "15/08/2023 17:25";
//                "@h_1" = "999.9";
//                "@k_1" = 24k;
//                "@n_1" = "V\U00c0NG MI\U1ebeNG VRTL (V\U00e0ng R\U1ed3ng Th\U0103ng Long)";
//                "@pb_1" = 5628000;
//                "@ps_1" = 5713000;
//                "@pt_1" = 5517000;
//                "@row" = 1;
//            },
//             {
//                "@d_2" = "15/08/2023 17:25";
//                "@h_2" = "999.9";
//                "@k_2" = 24k;
//                "@n_2" = "V\U00c0NG MI\U1ebeNG VRTL (V\U00e0ng R\U1ed3ng Th\U0103ng Long)";
//                "@pb_2" = 5628000;
//                "@ps_2" = 5713000;
//                "@pt_2" = 5517000;
//                "@row" = 2;
//            }
//        )
//    }
//}
