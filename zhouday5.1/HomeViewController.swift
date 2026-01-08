import UIKit

// 定义常量结构体用于存储重用标识符等
private struct Storyboard {
    static let CellIdentifier = "InterestCell"
    static let CellPadding: CGFloat = 30.0 // Cell 间的间距
    static let CellWidthRatio: CGFloat = 0.7 // Cell 宽度占屏幕宽度的比例
}

class HomeViewController: UIViewController {

    // MARK: - Properties
    
    // 数据源：存储所有 Interest 对象
    private var interests = Interest.createInterests()
    
    // 懒加载：UICollectionViewFlowLayout 用于定义布局和滚动行为
    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // 设置为水平滚动
        layout.minimumLineSpacing = Storyboard.CellPadding // 设置行（卡片间）间距
        return layout
    }()
    
    // 懒加载：UICollectionView 负责内容的显示和滚动
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        cv.backgroundColor = .clear // 背景透明
        cv.showsHorizontalScrollIndicator = false // 隐藏水平滚动条
        cv.dataSource = self // 设置数据源为当前 VC
        cv.delegate = self   // 设置代理为当前 VC
        // 纯代码注册 Cell，使用我们在 InterestCollectionViewCell 中定义的标识符
        cv.register(InterestCollectionViewCell.self, forCellWithReuseIdentifier: Storyboard.CellIdentifier)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView() // 配置视图
    }
    
    // 确保 CollectionView 布局在视图尺寸变化时更新
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // 重新计算并设置 CollectionView 的 Item 尺寸，实现居中效果
        configureCollectionViewLayoutItemSize()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .darkGray // 设置 VC 背景色
        view.addSubview(collectionView) // 添加 CollectionView 到主视图
        
        // 激活 CollectionView 约束：使其充满 VC 的 view
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Layout Customization
    
    // 计算并设置每个 Cell 的尺寸，确保 Cell 居中对齐
    private func configureCollectionViewLayoutItemSize() {
        let inset = (view.bounds.width - view.bounds.width * Storyboard.CellWidthRatio) / 2.0
        let itemWidth = view.bounds.width * Storyboard.CellWidthRatio // Item 宽度
        let itemHeight = view.bounds.height * 0.8 // Item 高度（占 VC 高度的 80%）

        flowLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        
        // 设置 CollectionView 的内容内边距，使第一个和最后一个 Cell 能居中显示
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    // MARK: - Scroll View Delegate (核心：实现卡片居中吸附效果)
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.flowLayout // 获取布局
        let cellPadding = Storyboard.CellPadding // 卡片间距
        let cellWidth = layout.itemSize.width // 卡片宽度
        
        // 计算每个卡片中心点到下一个卡片中心点的距离（步长）
        let snapStep = cellWidth + cellPadding
        
        // 预估停止点（当前滚动到的位置）
        let currentOffset = scrollView.contentOffset.x
        let targetOffset = targetContentOffset.pointee.x
        
        // 1. 计算目标停止位置（targetOffset）距离 CollectionView 边缘（left edge）的偏移量
        var newTargetOffset = targetOffset
        
        // 2. 将当前和目标偏移量转换为 '步数' (即滚动了多少张卡片)
        var p = (targetOffset + cellPadding) / snapStep
        
        // 3. 根据滚动手速（velocity.x）来判断应该向上取整还是向下取整，以实现吸附效果
        if velocity.x < 0 {
            // 向左滚动，向小数位向下取整 (floor)
            p = floor(p)
        } else if velocity.x > 0 {
            // 向右滚动，向小数位向上取整 (ceil)
            p = ceil(p)
        } else {
            // 没有手速，计算哪个卡片中心离目标停止位置最近（四舍五入）
            p = round(p)
        }
        
        // 4. 计算新的精确的目标偏移量（吸附到卡片中心）
        newTargetOffset = p * snapStep - cellPadding
        
        // 5. 更新目标停止点
        targetContentOffset.pointee.x = newTargetOffset
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    // 告诉 CollectionView 有多少个 Item (卡片)
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    // 配置每个 Item (卡片) 的内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 1. 从重用池中获取 Cell 实例
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! InterestCollectionViewCell
        
        // 2. 将对应索引的数据模型赋值给 Cell 的 interest 属性，触发 didSet 绑定数据
        cell.interest = interests[indexPath.row]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    // 这个协议在这个项目中主要用于实现滚动代理方法（上面的 scrollViewWillEndDragging）
}
