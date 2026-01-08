import UIKit

// 定义单元格重用标识符
private struct Storyboard {
    static let CellIdentifier = "InterestCell"
}

class InterestCollectionViewCell: UICollectionViewCell {
    
    // MARK: - 1. 纯代码 UI 组件定义 (使用 lazy var 延迟加载)
    
    private lazy var featuredImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill // 确保图片填充整个视图，可能会裁剪
        imageView.clipsToBounds = true             // 裁剪超出视图边界的部分
        imageView.layer.cornerRadius = 10          // 添加圆角效果
        imageView.translatesAutoresizingMaskIntoConstraints = false // 禁用自动尺寸转换，使用 Auto Layout
        return imageView
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.2) // 浅黑色半透明遮罩
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold) // 设置字体大小和粗细
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0 // 0 表示允许多行
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var membersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - 2. 数据绑定属性
    var interest: Interest? {
        didSet { // 属性观察器：每当 interest 被设置新值时，执行以下代码
            if let interest = interest {
                // 绑定图片
                featuredImageView.image = interest.featuredImage
                
                // 绑定文本
                titleLabel.text = interest.title
                descriptionLabel.text = interest.description
                
                // 绑定数量并格式化为字符串
                membersLabel.text = "\(interest.numberOfMembers) Members"
                postsLabel.text = "\(interest.numberOfPosts) Posts"
            }
        }
    }
    
    // MARK: - 3. 初始化方法
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout() // 在纯代码初始化时调用布局方法
    }
    
    // 必须实现的 Storyboard 初始化器（纯代码项目中通常不使用）
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 4. 纯代码布局 (使用 Auto Layout 约束)
    private func setupLayout() {
        
        // 1. 将所有子视图添加到 contentView（CollectionViewCell 的内容区域）
        contentView.addSubview(featuredImageView)
        contentView.addSubview(overlayView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(membersLabel)
        contentView.addSubview(postsLabel)
        
        let padding: CGFloat = 20 // 边缘内边距
        let spacing: CGFloat = 8  // 元素间距
        
        // 2. 激活约束
        NSLayoutConstraint.activate([
            // 图片视图和遮罩视图约束：充满整个 Cell
            featuredImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            featuredImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            featuredImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            featuredImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            overlayView.topAnchor.constraint(equalTo: contentView.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // 1. 描述 Label (最底部定位)
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            
            // 2. 标题 Label (在描述 Label 上方)
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -spacing),
            
            // 3. 帖子数量 Label (在标题 Label 上方，靠右侧)
            postsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            postsLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -spacing),
            
            // 4. 成员数量 Label (在标题 Label 上方，靠左侧)
            membersLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            membersLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -spacing)
        ])
    }
}
