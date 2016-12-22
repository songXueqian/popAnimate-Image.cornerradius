//
//  ViewController.m
//  Pop
//
//  Created by 宋学谦 on 2016/12/5.
//  Copyright © 2016年 SongXueqian. All rights reserved.
//

#import "ViewController.h"
#import <pop/pop.h>
#import "HJCornerRadius.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *upImage;
@property (weak, nonatomic) IBOutlet UIImageView *downImage;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pop)];
    [self.upImage addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pop2)];
    [self.downImage addGestureRecognizer:tap2];
    
    
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pop3)];
    [self.label addGestureRecognizer:tap3];
    
    
    
    UIImageView *roidImage = [[UIImageView alloc] initWithFrame:CGRectMake(200, 400, 100, 100)];
    roidImage.image = [UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:roidImage];
    
    roidImage.aliCornerRadius = 50;


    
}

- (void)pop{
    

    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    //  毛玻璃view 视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    effectView.frame = self.view.bounds;
    [self.view addSubview:effectView];
    //设置模糊透明度
//    effectView.alpha = 1.f;
    
    //弹性动画
    POPSpringAnimation* framePOP = [POPSpringAnimation animationWithPropertyNamed:kPOPViewAlpha];
    
    
    
    
    //速度 越大则动画结束越快
    framePOP.springSpeed = 0.01f;
    
    //弹力 越大震动幅度越大
    framePOP.springBounciness = 100.f;
    
    

    
//    kPOPViewFrame
//    framePOP.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];

    
//    kPOPViewBackgroundColor
//    framePOP.toValue = [UIColor cyanColor];
    
//    kPOPViewAlpha
//    framePOP.fromValue = @(1);
    framePOP.toValue = @(0.7);
    
//    framePOP.dynamicsTension = 0.f; //拉力  接下来这三个都跟物理力学模拟相关 数值调整起来也很费时 没事不建议使用哈
//    framePOP.dynamicsFriction = 0.f; //摩擦 同上
//    framePOP.dynamicsMass = 0.f ;     //质量 同上
    
    //注意:POPSpringAnimation是没有duration字段的，其动画持续时间由以上几个参数决定
    
    [framePOP setCompletionBlock:^(POPAnimation * anim , BOOL finsih) {
        
        if (finsih) {
            
            NSLog(@"view.frame = %@",NSStringFromCGRect(self.view.frame));


        }
        
    }];
    
    [effectView pop_addAnimation:framePOP forKey:@"go1"];
    
}

- (void)pop2{
    
    //减缓动画
    POPDecayAnimation* decay = [POPDecayAnimation animationWithPropertyNamed:kPOPViewFrame];
   
    
    decay.velocity = [NSValue valueWithCGRect:CGRectMake(200, 300, 100, 100)];
    
//    decay.deceleration = 0.5f;  //衰减系数(越小则衰减得越快)
    //注意:POPDecayAnimation也是没有duration字段的，其动画持续时间由velocity与deceleration决定
    
    [self.view pop_addAnimation:decay forKey:@"go2"];
}


- (void)pop3{
    //基本动画

    POPBasicAnimation* basicAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    
    basicAnimation.toValue = [NSNumber numberWithFloat:CGRectGetHeight(self.view.frame)/2];
    
    
    
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    //延迟3秒开始
    basicAnimation.beginTime =  CACurrentMediaTime() + 3.0f;
    basicAnimation.duration = 3.f;
    
    [basicAnimation setCompletionBlock:^(POPAnimation * ani, BOOL fin) {
        
        if (fin) {
            
            NSLog(@"view.frame = %@",NSStringFromCGRect(self.view.frame));
            
            
        }
    }];
    
    [self.view.layer pop_addAnimation:basicAnimation forKey:@"go3"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
