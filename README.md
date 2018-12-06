# DXTagScrollBar
iOS(OC)--标签水平滚动控件

#import "DXTagScrollBar.h"

- (void)testTagScrollBar{
    DXTagScrollBar *tagScrollBar = [[DXTagScrollBar alloc]initWithFrame:CGRectMake(0, 50, GLOBLE_WIDTH, 50)];
//    tagScrollBar.delegate = self;
    [self.view addSubview:tagScrollBar];
    NSMutableArray *GoodTagDataArray = [NSMutableArray arrayWithArray:@[
                                                                        @{@"tag_id":[NSNumber numberWithInteger:alertTagNum],@"tag_name":@"已设提醒"},
                                                                        @{@"tag_id":@1,@"tag_name":@"name1"},
                                                                 @{@"tag_id":@2,@"tag_name":@"name2222"},
                                                                 @{@"tag_id":@3,@"tag_name":@"name3"},
                                                                 @{@"tag_id":@4,@"tag_name":@"name444444444444"},
                                                                 @{@"tag_id":@5,@"tag_name":@"name5555"},
                                                                 @{@"tag_id":@6,@"tag_name":@"name6666666"},
                                                                 @{@"tag_id":@7,@"tag_name":@"name7"},
                                                                 @{@"tag_id":@8,@"tag_name":@"name88888888888888888"},
                                                                 @{@"tag_id":@9,@"tag_name":@"name9999"}
                                                                 ]];
    //更新tagbar
    [tagScrollBar createTagView:GoodTagDataArray withSelectedTagIdNow:1];
}

[self testTagScrollBar];
