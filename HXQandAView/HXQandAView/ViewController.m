//
//  ViewController.m
//  HXQandAView
//
//  Created by MacBook on 15/8/26.
//  Copyright (c) 2015年 MacBook. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

#import "HXQandAView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIScrollView *scrollView = [UIScrollView new];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView *contentView = [UIView new];
    [scrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.width.equalTo(scrollView);
    }];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor yellowColor];
    [contentView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(contentView);
        make.height.equalTo(@200);
    }];
    
    
    NSMutableArray *questions = [NSMutableArray new];
    HXQandACellViewData *question;
    
    question = [[HXQandACellViewData alloc] initWithQuestion:@"Q1.如何评价鲁迅?" anwser:@"鲁迅一生在文学创作、文学批评、思想研究、文学史研究、翻译、美术理论引进、基础科学介绍和古籍校勘与研究等多个领域具有重大贡献。他对于五四运动以后的中国社会思想文化发展具有重大影响，蜚声世界文坛，尤其在韩国、日本思想文化领域有极其重要的地位和影响，被誉为“二十世纪东亚文化地图上占最大领土的作家”。"];
    [questions addObject:question];
    
    question = [[HXQandACellViewData alloc] initWithQuestion:@"Q2.鲁迅的资料?" anwser:@"鲁迅（1881年9月25日－1936年10月19日），原名周樟寿，后改名周树人，字豫山，后改豫才"];
    [questions addObject:question];
    
    question = [[HXQandACellViewData alloc] initWithQuestion:@"Q3.有哪些作品？" anwser:@"《狂人日记》《阿Q正传》《彷徨》《呐喊》"];
    [questions addObject:question];
    
    question = [[HXQandACellViewData alloc] initWithQuestion:@"Q4.生平事迹？" anwser:@"鲁迅的一生，曾经与两位女性有过婚姻或爱情关系，一是当他26岁的时候，从日本回到绍兴在母亲鲁瑞的主持下与山阴朱安女士结婚；鲁迅自与朱安结婚之后，直至病逝为止，并未与她解除这种婚姻关系（鲁迅深知一旦休妻，朱安就会遭遇死亡或者非人的遭遇，于是未离婚），鲁迅在外的日子，朱安一直照顾着鲁迅母亲的生活，从未有怨言；二是当他47岁的时候，从广州抵达上海，即与长期追随自己的番禺许广平同志同居。鲁迅病逝后，朱安女士到亡故的十余年间，和许广平同志一样，也一直作为鲁迅遗属同社会保持着正常的联系。"];
    [questions addObject:question];

    HXQandAView *qAndAView = [[HXQandAView alloc] initWithDataSource:questions];
    [contentView addSubview:qAndAView];
    [qAndAView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom).offset(16);
        make.left.right.equalTo(contentView);
        make.bottom.equalTo(qAndAView.sugestedBottom);
    }];

    UIView *bottomView = [UIView new];
    [contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(qAndAView.mas_bottom).offset(16);
        make.left.right.equalTo(contentView);
        make.height.equalTo(@500);
        make.bottom.equalTo(contentView);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
