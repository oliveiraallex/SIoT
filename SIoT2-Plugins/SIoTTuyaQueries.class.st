Class {
	#name : #SIoTTuyaQueries,
	#superclass : #SIoTTuyaCommunicator,
	#category : #'SIoT2-Plugins'
}

{ #category : #'as yet unclassified' }
SIoTTuyaQueries >> getDeviceDataPointsQuery: aStringDeviceID [
	^ self getSignedServices: '/v1.0/devices/',aStringDeviceID,'/status'
		headers:
			{('client_id' -> accessID asString).
			('sign' -> easySignToken asString).
			('t' -> self getUnixTimestamp asString).
			('sign_method' -> 'HMAC-SHA256')} asDictionary 
]

{ #category : #'as yet unclassified' }
SIoTTuyaQueries >> getDeviceFactoryInformationQuery: aStringDeviceID [
	^ self getSignedServices: '/v1.0/devices/factory-infos?device_ids=',aStringDeviceID
		headers:
			{('client_id' -> accessID asString).
			('sign' -> easySignToken asString).
			('t' -> self getUnixTimestamp asString).
			('sign_method' -> 'HMAC-SHA256')} asDictionary 
]

{ #category : #'as yet unclassified' }
SIoTTuyaQueries >> getDeviceFunctionsQuery: aStringDeviceID [
	^ self getSignedServices: '/v1.0/devices/',aStringDeviceID,'/functions'
		headers:
			{('client_id' -> accessID asString).
			('sign' -> easySignToken asString).
			('t' -> self getUnixTimestamp asString).
			('sign_method' -> 'HMAC-SHA256')} asDictionary 
]

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
SIoTTuyaQueries >> getDeviceLogQuery: aStringDeviceID type: aString from: startTimestamp to: endtTimestamp size: anInteger nextRowKey: aStringKey [
	^ self getSignedServices: '/v1.0/devices/',aStringDeviceID,'/logs?',
		'codes=&end_time=',endtTimestamp,'&last_row_key=','&size=',anInteger asString,'&start_row_key=',aStringKey,'&start_time=',startTimestamp,'&type=',aString
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
