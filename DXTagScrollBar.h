//
//  MFTagScrollBar.h
//  xxx
//
//  Created by ilmeeself on 2018/3/17.
//  Copyright © 2018年 ilmeeself. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DXTagScrollBar;
@protocol clickedTagScrollBarTagBtnDelegate<NSObject>
- (void)dealWithClickMFTagScrollBarEvent:(NSInteger)tagIdNum;
@end

@interface DXTagScrollBar : UIView
@property(nonatomic,weak) id<clickedTagScrollBarTagBtnDelegate> delegate;
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) NSMutableArray *tagBtnArray;
@property(nonatomic,strong) NSMutableArray *tagDataArray;//@[@{@2,@""}]
@property(nonatomic) CGFloat contentSizeX;
@property(nonatomic) NSInteger selectedTagIdNow;

/**
 init
 */
- (instancetype)initWithFrame:(CGRect)frame;

/**
 createTagView

 @param tagDataArray EX:@[@{@2,@""}]
 @param selectedTagIdNow 当前选中的num
 */
- (void)createTagView:(NSMutableArray *)tagDataArray withSelectedTagIdNow:(NSInteger)selectedTagIdNow;
@end

