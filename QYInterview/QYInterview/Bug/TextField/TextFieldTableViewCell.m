//
//  TextFieldTableViewCell.m
//  QYInterview
//
//  Created by cyd on 2022/2/21.
//

#import "TextFieldTableViewCell.h"


@interface TextFieldTableViewCell()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TextFieldTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSLog(@"%@",self.textField.delegate);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"string --> %@",string);
    return YES;
}
@end
