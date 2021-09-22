Class {
	#name : #SIoTTuyaQueries,
	#superclass : #SIoTTuyaCommunicator,
	#category : #'SIoT2-Plugins'
}

{ #category : #'as yet unclassified' }
SIoTTuyaQueries >> getTokensQuery [
	^ self getSigned: '/v1.0/token?grant_type=1'
		headers:
			{('client_id' -> accessID asString).
			('sign' -> easySignToken asString).
			('t' -> self getUnixTimestamp asString).
			('sign_method' -> 'HMAC-SHA256')} asDictionary 
]
