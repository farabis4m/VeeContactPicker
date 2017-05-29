#import "VeeContactFactory.h"
#import "VeeABRecordsImporter.h"
#import "VeeABRecord.h"
#import "VeeContact.h"

@interface VeeContactFactory()
-(VeeABRecord *)createContactForAdditionalPhoneNumber;
@end

@implementation VeeContactFactory

+(NSArray<id<VeeContactProt>>*)veeContactProtsFromAddressBook:(ABAddressBookRef)addressBook
{
    VeeABRecordsImporter* abRepositoryImporter = [VeeABRecordsImporter new];
    NSArray<VeeABRecord*>* veeABRecords = [abRepositoryImporter importVeeABRecordsFromAddressBook:addressBook];
    NSMutableArray* veeContacts = [NSMutableArray new];
    for (VeeABRecord* veeABRecord in veeABRecords){
        
        for (NSString *phoneNumber in veeABRecord.phoneNumbers){
            
            NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"+0123456789"] invertedSet];
            NSString *resultString = [[phoneNumber componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
            
            NSError *error = nil;  // ^(?:\+971|00971|971|0971|0)(?:50|51|52|55|56)\d{7}$
            NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"^(?:\\+971||971|0(0971)?)[5][0-9]{8}$" options:0 error:&error];  //
             NSTextCheckingResult *match = [regularExpression firstMatchInString:phoneNumber options:0 range:NSMakeRange(0, [phoneNumber length])];
            
            if (match) {
                veeABRecord.phoneNumber = phoneNumber;
                id<VeeContactProt> veeContact = [[VeeContact alloc] initWithVeeABRecord:veeABRecord];
                [veeContacts addObject:veeContact];
            }
        }
//        id<VeeContactProt> veeContact = [[VeeContact alloc] initWithVeeABRecord:veeABRecord];
//        [veeContacts addObject:veeContact];
    }
    return [NSArray arrayWithArray:veeContacts];
}

-(VeeABRecord *)createContactForAdditionalPhoneNumber {
}

@end
