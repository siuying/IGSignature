# IGSignature

Objective-C client of [signature gem](https://github.com/mloughran/signature). Sign API call with shared secret and timestamp using SHA256 HMAC. 

## Examples

```objective-c
token   = [[IGSignatureToken alloc] initWithKey:@"key" secret:@"secret"];
request = [[IGSignatureRequest alloc] initWithMethod:@"POST"
                                                path:@"/some/path"
                                               query:@{@"query": @"params", @"go": @"here"}];
[request sign:token];

NSMutableDictionary* queryParams = [NSMutableDictionary dictionaryWithDictionary:[request auth]];
[queryParams addEntriesFromDictionary:[request query]];
```

```queryParams``` looks like:

```
{
  @"query": @"params",
  @"go": @"here",
  @"auth_version": @"1.0",
  @"auth_key": @"key",
  @"auth_timestamp": 1234,
  @"auth_signature": @"3b237953a5ba6619875cbb2a2d43e8da9ef5824e8a2c689f6284ac85bc1ea0db"
}
```

## Copyright

Copyright (c) 2013 Francis Chong. This software is licensed under the MIT License. See LICENSE for details.