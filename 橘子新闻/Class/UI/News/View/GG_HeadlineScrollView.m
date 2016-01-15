//
//  HeadlineScrollView.m
//  橘子新闻
//
//  Created by GG on 16/1/13.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import "GG_HeadlineScrollView.h"
#import "GG_NewsHeadModel.h"

#define kDetailLabelH 30

@implementation GG_HeadlineScrollView

- (instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)itemsArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self layoutView:frame WithArray:itemsArray];
    }
    return self;
}

#pragma mark 布局试图
- (void)layoutView:(CGRect)frame WithArray:(NSArray *)itemsArray{
    
    for (int index = 0; index<itemsArray.count; index++) {
        
        GG_NewsHeadModel *model = itemsArray[index];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(index*kScreenWidth, 0, kScreenWidth, CGRectGetHeight(frame)-kDetailLabelH)];
        NSString *path = [[NSBundle mainBundle] pathForResource:model.image ofType:nil];
        imageView.image = [UIImage imageWithContentsOfFile:path];
        [self addSubview:imageView];
        
        
        UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.left+10, CGRectGetHeight(frame)-kDetailLabelH, kScreenWidth, kDetailLabelH)];
        detailLabel.text = model.title;
        [self addSubview:detailLabel];
        
        
    }
    
    
}

@end
