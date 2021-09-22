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
	
	"aString := 'mm5ne3a5ajowv36fcfgl1631918323616GET
			e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
			
			/v1.0/token?grant_type=1'. "
	
	signature := (HMAC on: SHA256)
		key: accessSecret asByteArray;
		digestMessage: aString asByteArray.
	self halt.	
	^ signature hex

"clientId: mm5ne3a5ajowv36fcfgl
timestamp: 1631916482846
nonce:  
string: 'GET
e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855

/v1.0/token?grant_type=1'
secret: f4df13667c1c4f06876214bcab3061df

function calcSign(clientId,timestamp,nonce,signStr,secret){
    var str = clientId + timestamp + nonce + signStr;

	 str: 	mm5ne3a5ajowv36fcfgl1631918323616GET
			e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
			
			/v1.0/token?grant_type=1
			
    var hash = CryptoJS.HmacSHA256(str, secret);

	 hash:  
	
    var hashInBase64 = hash.toString();
	 cd25b85a9d9243c653e328d8b1b210eba8cf20a79dec12ab0f7ba42a7bcb9e86
    var signUp = hashInBase64.toUpperCase();
	 CD25B85A9D9243C653E328D8B1B210EBA8CF20A79DEC12AB0F7BA42A7BCB9E86
    return signUp;


"
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
SIoTTuyaCommunicator >> formatToJSONObject: aDictionary [

	aDictionary ifEmpty: [ ^ ''  ].
	aDictionary keysAndValuesDo: [ :aKey :aValue | 
		Transcript 
			show: aKey printString; space;
			show: aValue printString; cr ]
]

{ #category : #'private - requesting' }
SIoTTuyaCommunicator >> getSigned: path headers: aDictionary [
	
	^ self getSigned: path headers: aDictionary body: ''
]

{ #category : #'private - requesting' }
SIoTTuyaCommunicator >> getSigned: path headers: aDictionary body: aDictionary2 [
	
	
	| webClient headerFormated get signedString signedString2 sha256 signature cr nonce|
	
	
	headerFormated := self formatToJSONObject: aDictionary2.
	
	sha256 := self calculateSHA256: headerFormated.
	
	"self stringToSign:  1 HTTPMethod: 'GET'."
	cr := (Character lf) asString. 
	nonce := ''.
	"timestamp := '1632307722361'."
	
	signedString := 'GET',cr,sha256,cr,headerFormated,cr,path.
	
		
	signedString2 := accessID , timestamp , nonce , signedString.
	
	
	
	signature := (HMAC on: SHA256)
		key: accessSecret  asByteArray;
		digestMessage: signedString2 asByteArray.
	easySignToken :=  (signature hex)asUppercase.
	
	
	aDictionary at: 'sign' put: easySignToken.
	"aDictionary at: 't' put: timestamp."
	

	
	
	
	
	webClient := ZnClient new
		url: url,path;
		headerAddAll: aDictionary.
	get := webClient get.
	
	^ get
	


]

{ #category : #'as yet unclassified' }
SIoTTuyaCommunicator >> getUnixTimestamp [
	"Return Unix Timestamp (miliseconds since Jan 01 1970 UTC)"  
	^ timestamp := (Time primUTCMillisecondsClock - 2177452800000) asString
]

{ #category : #'as yet unclassified' }
SIoTTuyaCommunicator >> initialize [ 
	url := 'https://openapi.tuyaeu.com'.
	communicator := SIoTCommunication new.
	communicator 
]

{ #category : #'private - requesting' }
SIoTTuyaCommunicator >> signRequestPath: path headers: aDictionary [
	| webClient queryString signature get apiKey |
	
	self halt. 
	
	
	
	
	aDictionary at: 'timestamp' put: self timestamp.
	queryString := self convertQueryAsString: aDictionary.
	signature := self signQuery: queryString.
	webClient := ZnClient new
		url: path;
		headerAddAll: {('X-MBX-APIKEY' -> apiKey)} asDictionary;
		queryAddAll: aDictionary;
		queryAddAll: {(#signature -> signature)} asDictionary.
	SIoTLog logAdd: 'GET ',path,queryString.
	get := [NeoJSONReader fromString: webClient get] ifError: [ :error | SIoTLog logAdd: 'ERROR ', error asString ].
	



]

{ #category : #'as yet unclassified' }
SIoTTuyaCommunicator >> signTokens [

	accessID.
	accessSecret. 
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
