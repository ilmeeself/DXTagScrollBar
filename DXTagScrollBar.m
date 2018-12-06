//
//  MFTagScrollBar.m
//  xxx
//
//  Created by ilmeeself on 2018/3/17.
//  Copyright © 2018年 ilmeeself. All rights reserved.
//

#import "DXTagScrollBar.h"

//
#define GLOBLE_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define GLOBLE_WIDTH [[UIScreen mainScreen] bounds].size.width
#define UIRGBColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//
#define alertTagNum -99
#define NullTagNum -100

@implementation DXTagScrollBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = frame;
        UIView *lineViewOne = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GLOBLE_WIDTH, 0.5)];
        lineViewOne.backgroundColor = UIRGBColor(204, 204, 204, 1);
        [self addSubview:lineViewOne];
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0.5 , GLOBLE_WIDTH, 49)];
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.scrollView.scrollEnabled = YES;
        self.scrollView.scrollsToTop = NO;
        self.scrollView.pagingEnabled = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        self.tagDataArray = [NSMutableArray array];
        self.selectedTagIdNow = -1;
        [self createTagView:self.tagDataArray withSelectedTagIdNow:self.selectedTagIdNow];
        
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, GLOBLE_WIDTH, 0.5)];
        lineView.backgroundColor = UIRGBColor(204, 204, 204, 1);
        [self addSubview:lineView];
    }
    return self;
}


/**
 将selectedTagIdNow放到最前
 */
- (NSMutableArray *)dealWithSelectedTagIdNow:(NSMutableArray *)tagDataArray withSelectedTagIdNow:(NSInteger)selectedTagIdNow{
    for (int i = 0; i < tagDataArray.count; i++) {
        NSNumber *tagNumStr = tagDataArray[i][@"tag_id"];
        if ([tagNumStr integerValue] == selectedTagIdNow) {
            NSDictionary *dictSelected = [NSDictionary dictionaryWithDictionary:tagDataArray[i]];
            [tagDataArray removeObject:dictSelected];
            [tagDataArray insertObject:dictSelected atIndex:1];
            break;
        }
    }
    return tagDataArray;
}

- (void)createTagView:(NSMutableArray *)tagDataArray withSelectedTagIdNow:(NSInteger)selectedTagIdNow{
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }

    self.tagDataArray = [NSMutableArray arrayWithArray:[self dealWithSelectedTagIdNow:tagDataArray withSelectedTagIdNow:selectedTagIdNow]];
    NSLog(@"%@",self.tagDataArray);
    
    CGFloat offsetX = 8;
    int gap = 8;
    //create btn
    for (int i = 0; i < self.tagDataArray.count; i++) {
        NSString *tagName = [NSString stringWithFormat:@"%@",self.tagDataArray[i][@"tag_name"]];
        NSNumber *tagId = self.tagDataArray[i][@"tag_id"];
        
        UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGSize size = [self sizeWithText:tagName withFont:[UIFont systemFontOfSize:12.0]];
        tagBtn.tag = [tagId integerValue];
        tagBtn.frame = CGRectMake(offsetX, 10, size.width+20, 30);//模拟,应该使用约束
        
        if (tagBtn.tag == selectedTagIdNow) {
            tagBtn.backgroundColor = UIRGBColor(171, 205, 3, 1);
            [tagBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            tagBtn.selected = YES;
        }
        else{
            if (tagBtn.tag == alertTagNum) {
                tagBtn.backgroundColor = UIRGBColor(255, 151, 142, 1);
                [tagBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                tagBtn.selected = NO;
            }else{
                tagBtn.backgroundColor = UIRGBColor(240, 240, 240, 1);
                [tagBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                tagBtn.selected = NO;
            }
        }
        [tagBtn setTitle:tagName forState:UIControlStateNormal];
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        tagBtn.layer.cornerRadius = 14;
        [tagBtn addTarget:self action:@selector(clickedTagBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:tagBtn];
        offsetX=size.width+20+gap+offsetX;
    }
    
    self.contentSizeX = offsetX+gap;
    self.scrollView.contentSize = CGSizeMake(self.contentSizeX, 0);
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void)clickedTagBtnEvent:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(dealWithClickMFTagScrollBarEvent:)]) {
        if (!sender.isSelected) {
            [self.delegate dealWithClickMFTagScrollBarEvent:sender.tag];
        }else{
            [self.delegate dealWithClickMFTagScrollBarEvent:NullTagNum];
        }
    }
    
    NSInteger selectedTag = sender.tag;
    [self createTagView:self.tagDataArray withSelectedTagIdNow:selectedTag];
}

- (CGSize)sizeWithText:(NSString *)text withFont:(UIFont *)font{
    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
    return size;
}
@end
