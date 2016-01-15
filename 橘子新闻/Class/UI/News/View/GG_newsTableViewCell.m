//
//  GG_newsTableViewCell.m
//  橘子新闻
//
//  Created by GG on 16/1/13.
//  Copyright © 2016年 王立广. All rights reserved.
//

#import "GG_newsTableViewCell.h"

#define kMargin 10

#define kTitleFont [UIFont systemFontOfSize:15]
#define kTitleColor [UIColor blackColor]

#define kDetailFont  [UIFont systemFontOfSize:13]
#define kDetailColor [UIColor grayColor]

@interface GG_newsTableViewCell()


@end

@implementation GG_newsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self addMemberView];

        
    }
    return self;
}

#pragma makr 往cell添加试图
- (void)addMemberView{
    
    //缩略图
    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kMargin, kMargin, 100, 70)];
    _iconImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_iconImageView];
    
    //标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconImageView.right+kMargin, kMargin, 0, 0)];
    _titleLabel.font = kTitleFont;
    _titleLabel.textColor = kTitleColor;
    [self.contentView addSubview:_titleLabel];
    
    
    //详情
    _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconImageView.right+kMargin, _titleLabel.bottom+kMargin, 0, 0)];
    _detailLabel.font = kDetailFont;
    _detailLabel.textColor = kDetailColor;
    [self.contentView addSubview:_detailLabel];
    
    //收藏按钮
    _favoritesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _favoritesBtn.frame = CGRectMake(kScreenWidth-kMargin-40, _iconImageView.bottom-25, 40, 25);
    _favoritesBtn.backgroundColor = [UIColor clearColor];
    _favoritesBtn.layer.borderWidth = 1.5;
    _favoritesBtn.layer.cornerRadius = 3.5;
    
    _favoritesBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    _favoritesBtn.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    [_favoritesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_favoritesBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [self.contentView addSubview:_favoritesBtn];
    
    
    
    
    //万能的分割线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1.5)];
    
    lineView.backgroundColor = [UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:1];
    [self.contentView addSubview:lineView];
        
}


#pragma mark 赋值
- (void)setModel:(GG_NewsCellModel *)model{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:model.image ofType:nil];
    _iconImageView.image = [UIImage imageWithContentsOfFile:path];
    
    _titleLabel.text = model.title;
    [_titleLabel sizeToFit];
    
    
    _detailLabel.text = model.detail;
    _detailLabel.numberOfLines = 0;
    _detailLabel.textAlignment = NSTextAlignmentLeft;
    _detailLabel.frame = CGRectMake(_iconImageView.right+kMargin, _titleLabel.bottom+kMargin*1.3, 200, 0);
    [_detailLabel sizeToFit];

    
    
    
}
@end
