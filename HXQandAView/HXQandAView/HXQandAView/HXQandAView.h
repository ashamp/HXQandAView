//
//  HXQandAView.h
//  HXQandAView
//
//  Created by MacBook on 15/8/26.
//  Copyright (c) 2015年 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HXQandACellViewData : NSObject

@property (nonatomic, copy)NSString *question;
@property (nonatomic, copy)NSString *anwser;

- (instancetype)initWithQuestion:(NSString *)question anwser:(NSString *)anwser;

@end





@class HXQandACellView;
@class MASViewAttribute;

typedef void(^HXQandACellViewOpenBlock)(HXQandACellView *);

@interface HXQandACellView : UIView

@property (nonatomic, assign)BOOL open;

@property (nonatomic, strong)MASViewAttribute *sugestedBottom;

- (instancetype)initWithViewData:(HXQandACellViewData *)data openClickBlock:(HXQandACellViewOpenBlock)openClickBlock;

@end





@interface HXQandAView : UIView

@property (nonatomic, strong)MASViewAttribute *sugestedBottom;

- (instancetype)initWithDataSource:(NSArray *)dataSource;

@end
