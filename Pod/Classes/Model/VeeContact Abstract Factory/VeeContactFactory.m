#import "VeeContactFactory.h"
#import "VeeABRecordsImporter.h"
#import "VeeABRecord.h"
#import "VeeContact.h"

@interface VeeContactFactory()

@end

@implementation VeeContactFactory

+(NSArray<id<VeeContactProt>>*)veeContactProtsFromAddressBook:(ABAddressBookRef)addressBook
{
    VeeABRecordsImporter* abRepositoryImporter = [VeeABRecordsImporter new];
    NSArray<VeeABRecord*>* veeABRecords = [abRepositoryImporter importVeeABRecordsFromAddressBook:addressBook];
    NSMutableArray* veeContacts = [NSMutableArray new];
    NSCharacterSet *notAllowedChars = [[NSCharacterSet characterSetWithCharactersInString:@"+0123456789"] invertedSet];
    for (VeeABRecord* veeABRecord in veeABRecords){
        
        for (NSString *phoneNumber in veeABRecord.phoneNumbers){
            
            NSString *resultString = [[phoneNumber componentsSeparatedByCharactersInSet:notAllowedChars] componentsJoinedByString:@""];
            
            NSError *error = nil;  // ^(?:\+971|00971|971|0971|0)(?:50|51|52|55|56)\d{7}$
            NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"^(?:\\+971|0(0971)?)[5][0-9]{8}$" options:0 error:&error];  //
             NSTextCheckingResult *match = [regularExpression firstMatchInString:resultString options:0 range:NSMakeRange(0, [resultString length])];
            
            if (match) {
                veeABRecord.phoneNumber = resultString;
                id<VeeContactProt> veeContact = [[VeeContact alloc] initWithVeeABRecord:veeABRecord];
                [veeContacts addObject:veeContact];
            }
        }
//        id<VeeContactProt> veeContact = [[VeeContact alloc] initWithVeeABRecord:veeABRecord];
//        [veeContacts addObject:veeContact];
    }
    return [NSArray arrayWithArray:veeContacts];
}


@end
