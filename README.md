# MovieTrailer iOS App

## 概述


## 主要功能

**電影列表**：
  - 近期熱門
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

要使用 MovieTrailer ，請按照以下步驟操作

1. 開啟Xcode，選擇上方選單 Integrate -> Clone -> 貼上專案URL  
2. 上方選單 Product -> Run，即可在模擬器或連接的 iOS 設備上運行應用程式

## 專案架構

本專案使用 MVVM 架構，實現數據模型,商業邏輯與UI分離至不同層，以下以專案資料夾分類說明，可直接與專案對照，架構如下：

- ViewModel: 
  MovieListViewModel:電影列表，取得近期熱門與即將上映資料
  MovieIntroViewModel:電影介紹，取得電影資訊、影片、圖片、相關電影
  
- Model:
  Movie:共同資料型別
  XXXResponse:即將上映、近期入門、電影資訊、影片、圖片、相關電影資料型別
  
- View:
  MovieListContentView:電影列表，依序由PopularView, UpcomingView組成
  MovieIntroContentView:電影介紹，依序由YouTubePlayerView, OverviewView, PosterView, SimilarView組成

- Service:
  NetworkService:網路請求，錯誤時回傳自定義錯誤型別NetworkError
  MovieRequestFactory:產出指定API URLRequest
  RequestProducer:製造URLRequest過程

## 關於程式碼

**為了提高程式碼的易讀性、維護性、擴展，進行了以下內容**

- 自定義錯誤處理:  
  在 NetworkService 中使用 Enum 定義了自定義的錯誤類型 NetworkError，涵蓋了各種可能的錯誤情況，提供更明確和有意義的錯誤訊息，方便錯誤處理和測試

- 遵循 API 的命名:  
  在定義 Struct 時，將屬性的命名與 API 欄位保持一致，提高程式碼的可讀性，可以輕鬆地將程式碼與 API 文件對照

- XXXContentView:
  代表主要功能頁面，使用 SwiftUI 的 View Composition 特性，將頁面拆分為多個獨立的 View，每個 View 自行去渲染屬於自己的畫面

- Combine 處理多支 API:
  viewModel 使用了 CombineLatest 來處理多個 API 請求，並在所有請求完成時，一次發送所有結果

- 網路請求回傳型別使用泛型:
  NetworkService 類別遵循了 NetworkProtocol 協議，並提供了一個泛型的 fetch ，只需要知道方法的輸入輸出，回傳型別由外部指定，增加使用彈性

- 輕鬆建立 URLRequest:
  MovieRequestFactory專注產生指定 API URLRequest，使用時不需要關心是如何將參數轉換為 URLRequest 的過程

- 型別擴充:
  Struct Movie 多了 backdropURL 和 posterURL ，方便取得相關URL，無需在每次使用網址時還要額外組成URL與轉型

**為了提高使用者體驗，進行了以下內容**

- 加載時顯示 Loading 動畫:
  網路請求時，會依據 viewModel isLoading 參數來決定是否要顯示動畫，讓使用者知道正在取得資料當中
  
- 不使用原有YouTube進度條控制元件:
  YouTubePlayerView裡特別設定 controls = 0，特別把控制元件移除，使用自身UI元件來調整播放進度，增加使用體驗

- 熱門電影左右滑動:
  使用 Scrollview 的 paging 效果，透過左右滑動一次只顯示一個熱門電影，增加App互動機會和沈浸式瀏覽體驗

- Clean Design:
  相關字體大小直接使用 SwiftUI font，使用 largeTitle、headline、sunheadlind、footnote 以最簡單的方式，來分類資訊重要程度

## 還可以在專案中認識到

- Dependency Injection:
  viewModel 中皆不需要知道networkService和movieRequest的實體，只需知道是分別遵循了 NetworkProtocol 與 MovieRequestProtocol

- RequestProducer：
  這類別提供了產生 URLRequest 物件方法，可在呼叫網路請求前透過它來建立，並且可以通過實作 RequestProducerProtocol 來進行自定義和擴展
  
- YouTubeiOSPlayerHelper:
  方便在 iOS 應用程式中嵌入和播放 YouTube 影片的 Framework，省去與WKWebView溝通，直接帶入影片 ID 就可以設定播放、暫停、快轉等等相關設定
  
- MovieRequestFactory:
  創建 URLRequest 都調用 produceRequest ，而不是依賴自身處理，未來如需使用不同方式 produceRequest，只需傳入簽訂 RequestProducerProtocol 的類別
  MovieRequestFactory初始化方法中，提供了默認值參數，同時也允許使用者在需要時傳遞自定義的值

## LLM 輔助

**為了加速開發，在開發過程中，進行了以下內容**

- 產生 API Struct 資料型別
- 設定 SwiftUI View 樣式
- Combine 使用方式
- Code Review


