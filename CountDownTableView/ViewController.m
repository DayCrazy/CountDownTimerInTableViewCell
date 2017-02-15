//
//  ViewController.m
//  CountDownTableView
//
//  Created by 李丹阳 on 2017/2/15.
//  Copyright © 2017年 李丹阳. All rights reserved.
//

#import "ViewController.h"

#import "CoutDownViewController.h"

@interface ViewController ()

@property (nonatomic, strong)NSMutableArray* dataArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSMutableArray*)dataArray{
    
    if (_dataArray == nil) {
        
        _dataArray = [[NSMutableArray alloc]init];
    }
    
    return  _dataArray;
}

- (void)initTableView{
    
    UIButton* pushButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 20)];
    [pushButton setTitle:@"进入倒计时" forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:pushButton];
    
    [pushButton addTarget:self action:@selector(pushButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pushButtonAction:(UIButton*)sender{
    
    CoutDownViewController* coutDownVC = [[CoutDownViewController alloc]init];
    
    
    __weak ViewController* weakSelf = self;
    
    [self.navigationController pushViewController:coutDownVC animated:YES];
    
    coutDownVC.block = ^(NSArray* data){
        
        weakSelf.dataArray = [data mutableCopy];
    };
    
    coutDownVC.dataArray = _dataArray;
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
