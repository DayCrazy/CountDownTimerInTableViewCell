//
//  CoutDownViewController.h
//  CountDownTableView
//
//  Created by 李丹阳 on 2017/2/15.
//  Copyright © 2017年 李丹阳. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^callBackDataBlo)(NSArray*);

@interface CoutDownViewController : UIViewController

@property (nonatomic,copy)callBackDataBlo block;

@property (nonatomic, strong)NSMutableArray* dataArray;


@end
