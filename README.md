# MovieTrailer iOS App

## 概述


## 主要功能

**電影列表**：
  - 熱門電影
  - 即將上映

**電影介紹**：
  - 播放官方預告
  - 電影簡介
  - 受歡迎程度、上映日期、電影長度
  - 電影海報觀賞
  - 相關電影

## 開發框架
  - SwiftUI
  - Combine

## 開發環境
  - Xcode 15.2
  - Swift 5.0
  - iOS 17.0
  - macOS 14.1

## Package Dependencies
  - [SDWebImageSwiftUI](https://github.com/SDWebImage/SDWebImageSwiftUI)
  - [YouTube-Player-iOS-Helper](https://github.com/youtube/youtube-ios-player-helper)

## 安裝應用程式

使用 MovieTrailer ，請按照以下步驟操作

1. 開啟Xcode，選擇上方選單 Integrate -> Clone -> 貼上專案URL  
2. 上方選單 Product -> Run，即可在模擬器或連接的 iOS 設備上運行應用程式

## 專案架構

本專案使用 MVVM 架構，實現數據模型,商業邏輯與UI分離至不同層，以下以專案資料夾分類說明，可直接與專案對照，架構如下:

- ViewModel  
  MovieListViewModel:  
  電影列表，取得熱門電影與即將上映資料  
  MovieIntroViewModel:  
  電影介紹，取得電影資訊、影片、圖片、相關電影  
  
- Model  
  Movie:
  共同資料型別
  XXXResponse:
  即將上映、熱門電影、電影資訊、影片、圖片、相關電影資料型別  
  
- View  
  MovieListContentView:  
  電影列表，依序由 PopularView, UpcomingView 組成  
  MovieIntroContentView:  
   電影介紹，依序由 YouTubePlayerView, OverviewView, PosterView, SimilarView 組成  

- Service  
  NetworkService:  
   網路請求，錯誤時回傳自定義錯誤型別 NetworkError  
  MovieRequestFactory:  
   產出指定 API URLRequest  
  RequestProducer:  
   製造 URLRequest 過程  

## 關於程式碼

**為了提高程式碼的易讀性、維護性、擴展，進行了以下內容**

- 自定義錯誤處理:  
  在 NetworkService 中使用 Enum 定義了自定義的錯誤類型 NetworkError，涵蓋了各種可能的錯誤情況，提供更明確和有意義的錯誤訊息，方便錯誤處理和測試

- 遵循 API 的命名:  
  在定義 Struct 時，將屬性的命名與 API 欄位保持一致，提高程式碼的可讀性，可以輕鬆地將程式碼與 API 文件對照

- XXXContentView 使用獨立 View:  
  代表主要功能頁面，使用 SwiftUI 的 View Composition 特性，將頁面拆分為多個獨立的 View，每個 View 自行去渲染屬於自己的內容

- Combine 處理多支 API:  
  ViewModel 使用了 CombineLatest 來處理多個 API 請求，並在所有請求完成時，一次發送所有結果

- 網路請求使用泛型:  
  NetworkService 類別遵循了 NetworkProtocol 協議， func fetch 使用泛型可處理各種型別的資料，並約束對象為 Decodable 確保所有型別都可以從 JSON 解析

- 輕鬆建立 URLRequest:  
  MovieRequestFactory 專注產生指定 API URLRequest，使用時不需要額外傳入 URL 相關參數， 已調用 RequestProducer 來完成

- 型別擴充:  
  Struct Movie 多了 backdropURL 和 posterURL ，方便取得相關URL，無需在每次使用網址時還要額外組成URL與轉型

- YouTubeiOSPlayerHelper:   
  方便在 iOS 應用程式中嵌入和播放 YouTube 影片的 Framework，省去與 WKWebView 溝通，直接帶入影片 ID 就可以播放、暫停、快轉等等相關設定

**為了提高使用者體驗，進行了以下內容**
  
- 不使用原有 YouTube 進度條控制元件:  
  YouTubePlayerView裡特別設定 controls = 0，特別把控制元件移除，使用自身UI元件來調整播放進度，方便調整

- 熱門電影左右滑動:  
  使用 Scrollview 的 paging 效果，透過左右滑動，一次只顯示一個熱門電影，增加App與使用者互動機會

- Clean Design:  
  相關字體大小直接使用 SwiftUI font，區分 largeTitle、headline、sunheadlind、footnote 以最簡單的方式，來分類資訊重要程度

- 加載時顯示 Loading 動畫:  
  網路請求時，會依據 ViewModel isLoading 參數來決定是否要顯示動畫，讓使用者知道正在取得資料當中

## 使用技術

- Dependency Injection:  
  ViewModel 依賴協議而不是實例，要求實體化自身時，需要透過外部注入，除了降低耦合度，也可輕鬆替換不同的網路服務或 URLRequest 建立

- Design Pattern:  

  Observer Pattern  
  使用 Combine 實現，ViewModel 採用 ObservableObject 協議，並使用 @Published 屬性包裝，允許 View 自動訂閱和響應 ViewModel 中數據的變化
    
  Factory Pattern  
  MovieRequestFactory 封裝了創建各種電影相關 URLRequest 的複雜邏輯，如 createUpcoming()、createPopular() 等方法，並提供一致的接口來創建不同類型的請求
   
  Singleton Pattern  
  NetworkService ，創建一個全局唯一的實例，私有化的初始化方法 private init 確保只能通過 shared 屬性訪問該實例，有效管理網絡請求並避免重複創建資源

- Combine:  
  利用 Combine 框架進行 Reactive Programming，NetworkService 使用 AnyPublisher 處理異步網絡請求，ViewModel 中使用 Publishers.CombineLatest 合併多個請求結果，通過 sink 方法訂閱 Publisher，實現數據流的處理和畫面更新，簡化異步操作的處理，提高程式碼的易讀性   

## LLM 輔助

**為了加速開發，在開發過程中，進行了以下內容**

- 產生 API Struct 資料型別
- 設定 SwiftUI View 樣式
- Combine 使用方式
- Code Review


