//  Interest.swift
//  (数据模型文件)

import UIKit // 导入 UIKit 框架，因为我们要使用 UIImage

class Interest // 定义数据模型类 Interest
{
    // MARK: - Public API (公共属性)
    var title: String = ""             // 卡片的标题
    var description: String = ""       // 卡片的描述文本
    var numberOfMembers: Int = 0       // 成员数量
    var numberOfPosts: Int = 0         // 帖子数量
    
    // featuredImage 存储的是加载完成的 UIImage 对象
    var featuredImage: UIImage!        // 卡片的背景图片（强制解包，要求必须有图片）
    
    init(title: String, description: String, featuredImage: UIImage!) // 构造器（初始化方法）
    {
        self.title = title
        self.description = description
        self.featuredImage = featuredImage
        
        // 赋予初始的假值（用于数据演示）
        numberOfMembers = 1
        numberOfPosts = 1
    }
    
    // MARK: - Private
    // dummy data (用于演示的假数据)
    static func createInterests() -> [Interest] // 静态方法，返回一个 Interest 数组
    {
        return [
            // 每行创建一个 Interest 实例，并传入对应的标题、描述和图片名称
            // UIImage(named: "hello")! 会在 Assets2.xcassets 中查找名为 "hello" 的图片
            Interest(title: "Hello there, i miss u.", description: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "hello")!),
            Interest(title: "🐳🐳🐳🐳🐳", description: "We love romantic stories. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "dudu")!),
            Interest(title: "Training like this, #bodyline", description: "Create beautiful apps. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "bodyline")!),
            Interest(title: "I'm hungry, indeed.", description: "Cars and aircrafts and boats and sky. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "wave")!),
            Interest(title: "Dark Varder, #emoji", description: "Meet life with full presence. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "darkvarder")!),
            Interest(title: "I have no idea, bitch", description: "Get up to date with breaking-news. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "hhhhh")!),
        ]
    }
}
