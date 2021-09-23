Class {
	#name : #SIoTTuyaCommunicator,
	#superclass : #Object,
	#instVars : [
		'accessID',
		'accessSecret',
		'timestamp',
		'url',
		'uid',
		'communicator',
		'requestBody',
		'requestHeader',
		'easyAccessToken',
		'easyRefreshToken',
		'easySignToken'
	],
	#category : #'SIoT2-Plugins'
}

{ #category : #accessing }
SIoTTuyaCommunicator >> accessID [

	^ accessID
]

{ #category : #'as yet unclassified' }
SIoTTuyaCommunicator >> accessID: aString accessSecret: aString2 [
	accessID := aString.
	accessSecret := aString2
	
]

{ #category : #accessing }
SIoTTuyaCommunicator >> accessSecret [

	^ accessSecret
]

{ #category : #'as yet unclassified' }
SIoTTuyaCommunicator >> calcSignature: aString [

	| signature |
	signature := (HMAC on: SHA256)
		             key: accessSecret asByteArray;
		             digestMessage: aString asByteArray.
	^ signature hex asUppercase
]

{ #category : #'as yet unclassified' }
SIoTTuyaCommunicator >> calculateSHA256: aString [

	^ (SHA256 new; hashStream: (ReadStream on: aString)) hex
]

{ #category : #accessing }
SIoTTuyaCommunicator >> communicator [

	^ communicator
]

{ #category : #accessing }
SIoTTuyaCommunicator >> communicator: anObject [

	communicator := anObject
]

{ #category : #accessing }
SIoTTuyaCommunicator >> easyAccessToken [

	^ easyAccessToken
]

{ #category : #accessing }
SIoTTuyaCommunicator >> easyAccessToken: anObject [

	easyAccessToken := anObject
]

{ #category : #accessing }
SIoTTuyaCommunicator >> easyRefreshToken [

	^ easyRefreshToken
]

{ #category : #accessing }
SIoTTuyaCommunicator >> easyRefreshToken: anObject [

	easyRefreshToken := anObject
]

{ #category : #accessing }
SIoTTuyaCommunicator >> easySignToken [

	^ easySignToken
]

{ #category : #accessing }
SIoTTuyaCommunicator >> easySignToken: anObject [

	easySignToken := anObject
]

{ #category : #'private - requesting' }
SIoTTuyaCommunicator >> formatCodeValueDictionary: aDictionary [
	
	| newDictionary |
	newDictionary := Dictionary new. 
	aDictionary ifEmpty: [ ^ ''  ].
	aDictionary do: [ :item | newDictionary add: (item at: 'code')->(item at: 'value') ].
	^ newDictionary
]

{ #category : #'private - requesting' }
SIoTTuyaCommunicator >> formatToJSONObject: aDictionary [

	aDictionary ifEmpty: [ ^ ''  ].
	aDictionary keysAndValuesDo: [ :aKey :aValue | 
		Transcript 
			show: aKey printString; space;
			show: aValue printString; cr ]
]

{ #category : #'private - requesting' }
SIoTTuyaCommunicator >> get: path headers: aDictionary body: aDictionary2 [

	| webClient |
	webClient := ZnClient new
		             url: path;
		             headerAddAll: aDictionary.
	^ webClient get
]

{ #category : #'private - requesting' }
SIoTTuyaCommunicator >> getSignedServices: path headers: aDictionary [
	
	^ self getSignedServices: path headers: aDictionary body: ''
]

{ #category : #'private - requesting' }
SIoTTuyaCommunicator >> getSignedServices: path headers: aDictionaryHeader body: aDictionaryBody [

	| headerFormated get stringToSign stringSigned sha256 lf nonce |
	headerFormated := self formatToJSONObject: aDictionaryBody.
	sha256 := self calculateSHA256: headerFormated.
	lf := Character lf asString.
	nonce := ''.

	stringToSign := 'GET' , lf , sha256 , lf , headerFormated , lf , path.
	stringSigned := accessID , easyAccessToken , timestamp  , nonce , stringToSign.
	aDictionaryHeader at: 'access_token' put: easyAccessToken.
	
	easySignToken := self calcSignature: stringSigned.
	aDictionaryHeader at: 'sign' put: easySignToken.

	get := self get: url , path headers: aDictionaryHeader body: aDictionaryBody.

	^ get
]

{ #category : #'private - requesting' }
SIoTTuyaCommunicator >> getSignedTokens: path headers: aDictionary [
	
	^ self getSignedTokens: path headers: aDictionary body: ''
]

{ #category : #'private - requesting' }
SIoTTuyaCommunicator >> getSignedTokens: path headers: aDictionaryHeader body: aDictionaryBody [

	| headerFormated get stringToSign stringSigned sha256 lf nonce |
	headerFormated := self formatToJSONObject: aDictionaryBody.
	sha256 := self calculateSHA256: headerFormated.
	lf := Character lf asString.
	nonce := ''.

	stringToSign := 'GET' , lf , sha256 , lf , headerFormated , lf , path.
	stringSigned := accessID , timestamp , nonce , stringToSign.
	
	
	easySignToken := self calcSignature: stringSigned.
	aDictionaryHeader at: 'sign' put: easySignToken.
	
	get := self get: url , path headers: aDictionaryHeader body: aDictionaryBody.

	^ get
]

{ #category : #'as yet unclassified' }
SIoTTuyaCommunicator >> getUnixTimestamp [
	"Return Unix Timestamp (miliseconds since Jan 01 1970 UTC)"  
	^ timestamp := (Time primUTCMillisecondsClock - 2177452800000) asString
	"^ timestamp "
]

{ #category : #'as yet unclassified' }
SIoTTuyaCommunicator >> initialize [ 
	url := 'https://openapi.tuyaeu.com'.
	communicator := SIoTCommunication new.
	communicator 
]

{ #category : #'as yet unclassified' }
SIoTTuyaCommunicator >> stringToSign: aString HTTPMethod: aString2 [

	| stringToSign sha256|
	
	sha256 := self calculateSHA256: requestBody , requestHeader.
	stringToSign := aString2 , '\n' , sha256
]

{ #category : #accessing }
SIoTTuyaCommunicator >> uid [

	^ uid
]

{ #category : #accessing }
SIoTTuyaCommunicator >> uid: anObject [

	uid := anObject
]

{ #category : #accessing }
SIoTTuyaCommunicator >> url [

	^ url
]

{ #category : #accessing }
SIoTTuyaCommunicator >> url: anObject [

	url := anObject
]
