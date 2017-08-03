# MLDragChooseTableViewComponent

 使用 **MLDragChooseTableViewComponent** 可以为任意的 **UITableViewCell** 添加类似Android的长按拖拽选择效果。

## 基本功能

* 在 **UITableViewCell** 处于非编辑状态下时长按，可以拖动该Cell在 **UITableView** 中进行移动并选择其他的Cell作为目标。
* 可自定拖动和被选择的Cell的选择样式颜色。
* 拖动Cell时支持上下滚动 **UITableView**。
* 提供代理协议以获取拖动过程中发生的状态。

## 开放API

* **MLDragChooseTableViewComponent.h**
```objc
@interface MLDragChooseTableViewComponent : NSObject

-(instancetype)initWithHostTableView:(UITableView*) tableview;

@property (nonatomic) CGColorRef dragCellColor;
@property (nonatomic) CGColorRef chooseCellColor;
@property (nonatomic,weak) id<MLDragChooseTableViewComponentDelegate> delegate;

-(void)addDragGestureToCell:(UITableViewCell*) cell;

@end
```



* **MLDragChooseTableViewComponentDelegate.h**
```objc
@protocol MLDragChooseTableViewComponentDelegate <NSObject>

-(void)tableViewCellDidDragOfRowAtIndexPath:(NSIndexPath*) indexPath;

-(void)tableViewCellDidEndDraggingWithSourceIndexPath:(NSIndexPath*) sourceIndexPath toDestinationIndexPath:(NSIndexPath*) destinationIndexPath;

-(void)tableViewCellDidCancelDragging;

@end
