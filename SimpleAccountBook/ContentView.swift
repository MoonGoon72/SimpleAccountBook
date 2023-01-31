import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea().opacity(0.2)
            VStack {
                TopArea()
                Spacer()  // Contents Area
                MainScrollView()
                Spacer()
                BottomArea()
            }
            .padding()
        }
    }
}
func numberFormat(price:String) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    if let intValue = Int(price) {
        let num = NSNumber(value: intValue)
        if let result = numberFormatter.string(from: num) {
            return result
        }
    }
    return price
}

struct MainScrollView: View {
    @StateObject var dataManager:AccountDataManager = AccountDataManager.shared
    @State var acCategory:AccountCategory = .none
    
    var body: some View {
        ScrollView() {
            VStack {
                ForEach(Array(dataManager.getList(Category: acCategory).enumerated()), id: \.offset) { idx, data in
                    AccountRow(accountData: data)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .padding()
        }
        .frame(width: .infinity)
        .background(.white)
        .cornerRadius(20)
        .padding()
        CategorySelectionArea(selectionCategory: $acCategory)
    }
}

struct TopArea: View {
    @State private var isShowModal = false
    
    var body: some View {
        HStack {
            Button {
                isShowModal = true
            } label: {
                Text("💸💸💸")
                    .font(.system(size: 33.3))
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .sheet(isPresented: self.$isShowModal) {
                InputAccountModal(isPresented: self.$isShowModal)
            }
        }
        .background(.white)
        .cornerRadius(20)
        .padding()
    }
}
struct BottomArea: View {
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Text("Bottom")
            }
        }
    }
}

struct AccountRow: View {
    
    var accountData:AccountData
    
    var buttonArea: some View {
        VStack {
            Button {
                
            } label: {
                Text("+")
                    .foregroundColor(.black)
            }
            .frame(width: 43, height: 33)
            .background(Color("AccountAdd"))
            .cornerRadius(10)
        }
        .padding()
    }
    
    var body: some View {
        HStack {
            // 로고 자리
            Text("💸")
                .font(.system(size: 45))
                .cornerRadius(0.3)
            VStack(alignment: .leading) {
                Text(accountData.title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(
                    numberFormat(price:accountData.account)
                    + "원")
                    .font(.title3)
            }
            Spacer()
            buttonArea
        }
    }
}

struct InputAccountModal: View {
    var dataManager:AccountDataManager = AccountDataManager.shared
    @Binding var isPresented: Bool

    @Environment(\.dismiss) private var dismiss
    
    @State private var money: String = ""
    @State private var memo:String = ""
    
    @State private var selectedCategory:AccountCategory = .none
    
    func addAccountData() -> Bool {
        let acData = AccountData(category: .none, title: memo, account: money)
        let result = dataManager.add(AccountData: acData)
        return !result
    }
    
    var TopButton: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("돌아가기")
            }
            Spacer()
        }.padding()
    }
    
    var InputArea: some View {
        VStack {
            HStack {
                Text("얼마나 쓰셨나요?")
                    .font(.title)
                Spacer()
                Button(action: {
                    let result = addAccountData()
                    isPresented = result
                }) {
                    Image(systemName: "arrow.up")
                        .imageScale(.large)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                        .background(.gray)
                        .clipShape(Circle())
                }

            }
            
            TextField("금액 입력", text: $money)
                .keyboardType(.decimalPad)
                .font(.title)
            
            Text("")
            
            TextField("메모 입력", text: $memo)
                .font(.title)
            
            Text("")
            
            Picker("지출 종류를 골라주세요",
                   selection: $selectedCategory) {
                ForEach(AccountCategory.allCases, id: \.self) { category in
                    Text(category.DisplayImoji).tag(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            Text("")
            HStack{
                Text("오늘은~")
                Spacer()
            }
            Text(selectedCategory.Display)
                .font(.title)
            Spacer()
        }.padding()
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            TopButton
            InputArea
            Spacer()
//            Button {
////                isPresented = false
////                dismiss.callAsFunction()
//                dismiss()
//            } label: {
//                Text("Dismiss")
//            }
        }.padding()
    }
}

struct CategorySelectionArea: View {
    
    @Binding var selectionCategory:AccountCategory
    
    var body: some View {
        VStack {
            Picker("지출 종류를 골라주세요", selection: $selectionCategory) {
                ForEach(AccountCategory.allCases, id: \.self) { category in
                    Text(category.DisplayImoji).tag(category)
                }
            }.onChange(of: selectionCategory) { newValue in
                
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
        .background(.white)
        .cornerRadius(20)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
