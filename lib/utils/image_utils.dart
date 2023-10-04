class ImageUtils {
    
    /// 商品圖片下載位址
    static String get commodityImageUrl => 'https://storage.googleapis.com/qpp_blockchain_test/Item/';
    
    /// 用戶圖片下載位址
    static String get userImageUrl => 'https://storage.googleapis.com/qpp_blockchain_test/Profile/';
}

  /// 圖片樣式
    enum ImageStyle {
        /// 頭像
        avatar,
        /// 背景圖
        backgroundImage
    }

    extension ImageStyleExtension on ImageStyle {
      int get value {
        switch (this) {
          case ImageStyle.avatar:
          return 1;
          case ImageStyle.backgroundImage:
          return 2;
        }
      }
    }