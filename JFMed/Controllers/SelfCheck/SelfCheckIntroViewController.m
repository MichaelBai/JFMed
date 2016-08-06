//
//  SelfCheckIntroViewController.m
//  JFMed
//
//  Created by Michael on 8/3/16.
//  Copyright © 2016 MichaelBai. All rights reserved.
//

#import "SelfCheckIntroViewController.h"
#import "SelfCheckViewController.h"

@interface SelfCheckIntroViewController ()

@property (nonatomic, assign) NSInteger curState;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) UIButton *seeAgainBtn;
@property (nonatomic, strong) UIView *introView;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) UILabel *hintLabel;

@end

@implementation SelfCheckIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"脊柱自查";
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    [self setupScrollView];
    [self changeState:0];
}

- (void)setupScrollView
{
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-299)/2, 22, 299, 319)];
    [_scrollView addSubview:_imgView];
    
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.frame = CGRectMake((SCREEN_WIDTH-180)/2, 475, 180, 44);
    [_scrollView addSubview:_nextBtn];
    [_nextBtn setBackgroundImage:[CommonUtility stretchImageNamed:@"button_theme"] forState:UIControlStateNormal];
    [_nextBtn setTitle:@"知道了，下一步" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.titleLabel.font = FONT_(16);
    [_nextBtn addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    
    _seeAgainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _seeAgainBtn.frame = CGRectMake(SCREEN_WIDTH/2-140-10, 475, 140, 44);
    [_scrollView addSubview:_seeAgainBtn];
    [_seeAgainBtn setBackgroundImage:[CommonUtility stretchImageNamed:@"button_theme_border"] forState:UIControlStateNormal];
    [_seeAgainBtn setTitle:@"再看一遍" forState:UIControlStateNormal];
    [_seeAgainBtn setTitleColor:COLOR_THEME forState:UIControlStateNormal];
    _seeAgainBtn.titleLabel.font = FONT_(16);
    [_seeAgainBtn addTarget:self action:@selector(seeAgain:) forControlEvents:UIControlEventTouchUpInside];
    _seeAgainBtn.hidden = YES;
    
    _introView = [[UIView alloc] initWithFrame:CGRectMake(10, 330, SCREEN_WIDTH-20, 0)];
    [_scrollView addSubview:_introView];
    _introView.layer.cornerRadius = 5;
    _introView.layer.masksToBounds = YES;
    _introView.backgroundColor = COLOR_BACKGROUND;
    
    UIImageView *introIcon = [[UIImageView alloc] initWithFrame:CGRectMake(16, 17, 14, 14)];
    [_introView addSubview:introIcon];
    introIcon.image = [UIImage imageNamed:@"notice"];
    
    _introLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 15, SCREEN_WIDTH-20-32, 0)];
    [_introView addSubview:_introLabel];
    _introLabel.numberOfLines = 0;
    _introLabel.textColor = COLOR_NAV;
    
    _hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(26, 0, SCREEN_WIDTH-26*2, 16)];
    [_scrollView addSubview:_hintLabel];
    _hintLabel.textColor = COLOR_NOTICE;
    _hintLabel.font = FONT_(15);
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 500);
}

- (void)changeState:(NSInteger)state
{
    _curState = state;
    switch (state) {
        case 0:
        {
            _imgView.image = [UIImage imageNamed:@"self_check_01"];
            NSString *introString = @"      请检查者双腿并拢，挺直膝盖，将身体慢慢向前弯下大概90度，垂悬双臂，如示意图。";
            _introLabel.attributedText = [CommonUtility getAttributedStringWithString:introString lineSpace:10 font:FONT_(15) alignment:NSTextAlignmentLeft];
            _introLabel.height = [introString boundingRectWithFont:FONT_(15) lineSpacing:10 andSize:CGSizeMake(SCREEN_WIDTH-20-32, CGFLOAT_MAX)].height;
            _introView.height = _introLabel.height + 30;
            _introView.top = 330;
            _hintLabel.top = _introView.bottom + 15;
            _hintLabel.text = @"提示：仅供参考，不能取代医生的专业建议。";
            _hintLabel.hidden = NO;
            
            [_nextBtn setTitle:@"站好了，下一步" forState:UIControlStateNormal];
            _nextBtn.left = (SCREEN_WIDTH-180)/2;
            _nextBtn.width = 180;
            _seeAgainBtn.hidden = YES;
        }
            break;
        case 1:
        {
            _imgView.image = [UIImage imageNamed:@"self_check_02"];
            NSString *introString = @"      请您站在检查者背后，在您的视线里她(他)将会如图所示。";
            _introLabel.attributedText = [CommonUtility getAttributedStringWithString:introString lineSpace:10 font:FONT_(15) alignment:NSTextAlignmentLeft];
            _introLabel.height = [introString boundingRectWithFont:FONT_(15) lineSpacing:10 andSize:CGSizeMake(SCREEN_WIDTH-20-32, CGFLOAT_MAX)].height;
            _introView.height = _introLabel.height + 30;
            _hintLabel.top = _introView.bottom + 15;
            _hintLabel.text = @"提示：仅供参考，不能取代医生的专业建议。";
            
            [_nextBtn setTitle:@"知道了，下一步" forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            _imgView.image = [UIImage imageNamed:@"self_check_03"];
            NSString *introString = @"      调整手机，让绿线与双腿缝隙重合。";
            _introLabel.attributedText = [CommonUtility getAttributedStringWithString:introString lineSpace:10 font:FONT_(15) alignment:NSTextAlignmentLeft];
            _introLabel.height = [introString boundingRectWithFont:FONT_(15) lineSpacing:10 andSize:CGSizeMake(SCREEN_WIDTH-20-32, CGFLOAT_MAX)].height;
            if (_introLabel.height / 16 < 2) {
                _introLabel.height = 16;
                _introLabel.text = introString;
                _introLabel.font = FONT_(15);
            }
            _introView.height = _introLabel.height + 30;
            
            _introView.top += 30;
            _hintLabel.hidden = YES;
        }
            break;
        case 3:
        {
            _imgView.image = [UIImage imageNamed:@"self_check_04"];
            NSString *introString = @"      转动黄色拖柄，使黄线与背部轮廓贴合。";
            _introLabel.attributedText = [CommonUtility getAttributedStringWithString:introString lineSpace:10 font:FONT_(15) alignment:NSTextAlignmentLeft];
            _introLabel.height = [introString boundingRectWithFont:FONT_(15) lineSpacing:10 andSize:CGSizeMake(SCREEN_WIDTH-20-32, CGFLOAT_MAX)].height;
            if (_introLabel.height / 16 < 2) {
                _introLabel.height = 16;
                _introLabel.text = introString;
                _introLabel.font = FONT_(15);
            }
            _introView.height = _introLabel.height + 30;
        }
            break;
        case 4:
        {
            _imgView.image = [UIImage imageNamed:@"self_check_05"];
            NSString *introString = @"      点击拍照按钮，并同时自动保存照片到我的「自查目录」里。";
            _introLabel.attributedText = [CommonUtility getAttributedStringWithString:introString lineSpace:10 font:FONT_(15) alignment:NSTextAlignmentLeft];
            _introLabel.height = [introString boundingRectWithFont:FONT_(15) lineSpacing:10 andSize:CGSizeMake(SCREEN_WIDTH-20-32, CGFLOAT_MAX)].height;
            _introView.height = _introLabel.height + 30;
            
            [_nextBtn setTitle:@"去试试" forState:UIControlStateNormal];
            _nextBtn.left = SCREEN_WIDTH/2+10;
            _nextBtn.width = 140;
            
            _seeAgainBtn.hidden = NO;
        }
            break;
        default:
            break;
    }
}

- (void)next:(UIButton *)sender
{
    switch (_curState) {
        case 0:
            [self changeState:1];
            break;
        case 1:
            [self changeState:2];
            break;
        case 2:
            [self changeState:3];
            break;
        case 3:
            [self changeState:4];
            break;
        case 4:
        {
            SelfCheckViewController *checkVC = [SelfCheckViewController new];
            [self.navigationController pushViewController:checkVC animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)seeAgain:(UIButton *)sender
{
    [self changeState:0];
}

@end
