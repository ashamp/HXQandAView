//
//  HXQandAView.m
//  HXQandAView
//
//  Created by MacBook on 15/8/26.
//  Copyright (c) 2015年 MacBook. All rights reserved.
//

#import "HXQandAView.h"
#import <Masonry.h>
#import <BlocksKit+UIKit.h>

@implementation HXQandACellViewData

- (instancetype)initWithQuestion:(NSString *)question
                          anwser:(NSString *)anwser
{
    self = [super init];
    if (self) {
        self.question = question;
        self.anwser = anwser;
    }
    return self;
}

@end





@interface HXQandACellView ()
@property (nonatomic, strong)HXQandACellViewData *data;
@property (nonatomic, copy)HXQandACellViewOpenBlock openClickBlock;
@property (nonatomic, strong)MASConstraint *bottomContraint;
@property (nonatomic, strong)UIView *containerView;
@property (nonatomic, strong)UIView *questionView;
@property (nonatomic, strong)UIView *anwserView;
@property (nonatomic, strong)UIImageView *arrowImageView;
@end

@implementation HXQandACellView

- (instancetype)initWithViewData:(HXQandACellViewData *)data openClickBlock:(HXQandACellViewOpenBlock)openClickBlock
{
    self = [super init];
    if (self) {
        self.data = data;
        self.openClickBlock = openClickBlock;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    self.clipsToBounds = YES;
    
    self.open = NO;
    
    //容器
    UIView *containerView = [UIView new];
    [self addSubview:containerView];
    
    //问题
    UIView *questionView = [UIView new];
    [containerView addSubview:questionView];
    [questionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(containerView);
        make.height.equalTo(@40);
    }];
    
    UILabel *questionLabel = [UILabel new];
    [questionView addSubview:questionLabel];
    [questionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(questionView).offset(16);
        make.centerY.equalTo(questionView);
    }];
    
    //箭头
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Triangle"]];
    self.arrowImageView = arrowImageView;
    [questionView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(questionView);
        make.right.equalTo(questionView).offset(-16);
        make.size.mas_equalTo(arrowImageView.image.size);
    }];
    
    //打开按钮
    UIButton *openButton = [UIButton new];
    [questionView addSubview:openButton];
    [openButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(questionView);
    }];
    
    //回答
    UIView *answerView = [UIView new];
    [containerView addSubview:answerView];
    
    UILabel *answerLabel = [UILabel new];
    [answerView addSubview:answerLabel];
    [answerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(answerView).insets(UIEdgeInsetsMake(16, 16, 16, 16));
    }];
    
    [answerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(questionView.mas_bottom);
        make.left.right.equalTo(containerView);
        make.bottom.equalTo(answerLabel).offset(16);
    }];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        self.bottomContraint = make.bottom.equalTo(questionView);
    }];
    
    UIView *bottomLineView = [UIView new];
    bottomLineView.backgroundColor = [UIColor lightGrayColor];
    [containerView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(containerView);
        make.height.equalTo(@1);
    }];
    
    [openButton bk_addEventHandler:^(id sender) {
        if (self.openClickBlock) {
            self.openClickBlock(self);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    self.containerView = containerView;
    self.questionView = questionView;
    self.anwserView = answerView;
    
    //定制
    answerLabel.numberOfLines = 0;
    answerView.alpha = 0.1;
    answerLabel.textColor = [UIColor grayColor];
    
    //数据绑定
    questionLabel.text = self.data.question;
    answerLabel.text = self.data.anwser;
    
    self.sugestedBottom = containerView.mas_bottom;
    
    //调试
    //    questionLabel.backgroundColor = [UIColor randomColor];
    //    answerLabel.backgroundColor = [UIColor randomColor];
    
}

- (void)setOpen:(BOOL)open{
    
    if (open!=_open) {
        [self.bottomContraint uninstall];
        
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            self.bottomContraint = make.bottom.equalTo(self.open? self.questionView : self.anwserView);
        }];
        
        if (open) {
            [UIView animateWithDuration:0.4 animations:^{
                self.anwserView.alpha = 1;
            }];
            self.arrowImageView.transform = CGAffineTransformMakeRotation(180 *M_PI / 180.0);
        }
        else{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(0);
            self.anwserView.alpha = 0.1;
        }
        _open = open;
    }
    
}

@end





@interface HXQandAView ()
@property (nonatomic, strong)NSArray *dataSource;
@end

@implementation HXQandAView

- (instancetype)initWithDataSource:(NSArray *)dataSource
{
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    UIView *contentView = [UIView new];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    
    NSMutableArray *cellViews = [NSMutableArray new];
    HXQandACellViewOpenBlock openBlock = ^(HXQandACellView *cellView){
        
        BOOL shouldOpen = !cellView.open;
        
        [cellViews enumerateObjectsUsingBlock:^(HXQandACellView *cellView, NSUInteger idx, BOOL *stop) {
            cellView.open = NO;
        }];
        
        cellView.open = shouldOpen;
        
    };
    
    
    for (HXQandACellViewData *viewData in self.dataSource) {
        HXQandACellView *QACellView = [[HXQandACellView alloc] initWithViewData:viewData openClickBlock:openBlock];
        [cellViews addObject:QACellView];
    }
    
    
    UIView *lastCellView;
    for (HXQandACellView *cellView in cellViews) {
        if (lastCellView) {
            [contentView addSubview:cellView];
            [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(lastCellView.mas_bottom);
                make.left.right.equalTo(contentView);
                make.bottom.equalTo(cellView.sugestedBottom);
            }];
        }
        else{
            [contentView addSubview:cellView];
            [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(contentView);
                make.bottom.equalTo(cellView.sugestedBottom);
                
            }];
        }
        lastCellView = cellView;
    }
    [lastCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentView);
    }];
    
    
    HXQandACellView *cellView = [cellViews firstObject];
    cellView.open = YES;
    
    self.sugestedBottom = lastCellView.mas_bottom;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
