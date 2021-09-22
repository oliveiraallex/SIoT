Class {
	#name : #SIoTTuyaQueries,
	#superclass : #SIoTTuyaCommunicator,
	#category : #'SIoT2-Plugins'
}

{ #category : #'as yet unclassified' }
SIoTTuyaQueries >> getDeviceInformationQuery: aStringDeviceID [
	^ self getSignedServices: '/v1.0/devices/',aStringDeviceID
		headers:
			{('client_id' -> accessID asString).
			('sign' -> easySignToken asString).
			('t' -> self getUnixTimestamp asString).
			('sign_method' -> 'HMAC-SHA256')} asDictionary 
]

{ #category : #'as yet unclassified' }
SIoTTuyaQueries >> getDevicesQuery [
	^ self getSignedServices: '/v1.0/iot-01/associated-users/devices'
		headers:
			{('client_id' -> accessID asString).
			('sign' -> easySignToken asString).
			('t' -> self getUnixTimestamp asString).
			('sign_method' -> 'HMAC-SHA256')} asDictionary 
]

{ #category : #'as yet unclassified' }
SIoTTuyaQueries >> getTokensQuery [
	^ self getSignedTokens: '/v1.0/token?grant_type=1'
		headers:
			{('client_id' -> accessID asString).
			('sign' -> easySignToken asString).
			('t' -> self getUnixTimestamp asString).
			('sign_method' -> 'HMAC-SHA256')} asDictionary 
]
