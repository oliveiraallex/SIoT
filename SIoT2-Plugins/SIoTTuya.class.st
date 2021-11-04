Class {
	#name : #SIoTTuya,
	#superclass : #SIoTTuyaQueries,
	#instVars : [
		'user',
		'devices'
	],
	#category : #'SIoT2-Plugins'
}

{ #category : #accessing }
SIoTTuya >> devices [

	^ devices
]

{ #category : #accessing }
SIoTTuya >> devices: anObject [

	devices := anObject
]

{ #category : #'as yet unclassified' }
SIoTTuya >> getDeviceDataPoints: aStringDeviceID [
	
	| result objectFromJSON |
	result := self getDeviceDataPointsQuery: aStringDeviceID.
	objectFromJSON := NeoJSONReader fromString: result.
	(objectFromJSON includesKey: #success) 
		ifTrue: [ ((objectFromJSON at:'success') = true) 
			ifTrue: [ ^ objectFromJSON at:'result'
			]
			ifFalse: [ ^ objectFromJSON at:'msg' ]
		]
		ifFalse: [ ^ 'error' ]
]

{ #category : #'as yet unclassified' }
SIoTTuya >> getDeviceFactoryInformation: aStringDeviceID [
	
	| result objectFromJSON |
	result := self getDeviceFactoryInformationQuery: aStringDeviceID.
	objectFromJSON := NeoJSONReader fromString: result.
	(objectFromJSON includesKey: #success) 
		ifTrue: [ ((objectFromJSON at:'success') = true) 
			ifTrue: [ ^ (objectFromJSON at:'result')at:1
			]
			ifFalse: [ ^ objectFromJSON at:'msg' ]
		]
		ifFalse: [ ^ 'error' ]
]

{ #category : #'as yet unclassified' }
SIoTTuya >> getDeviceFunctions: aStringDeviceID [
	
	| result objectFromJSON |
	result := self getDeviceFunctionsQuery: aStringDeviceID.
	objectFromJSON := NeoJSONReader fromString: result.
	(objectFromJSON includesKey: #success) 
		ifTrue: [ ((objectFromJSON at:'success') = true) 
			ifTrue: [ ^ (objectFromJSON at:'result')at: 'functions'
			]
			ifFalse: [ ^ objectFromJSON at:'msg' ]
		]
		ifFalse: [ ^ 'error' ]
]

{ #category : #'as yet unclassified' }
SIoTTuya >> getDeviceInformation: aStringDeviceID [
	
	| result objectFromJSON |
	result := self getDeviceInformationQuery: aStringDeviceID.
	objectFromJSON := NeoJSONReader fromString: result.
	(objectFromJSON includesKey: #success) 
		ifTrue: [ ((objectFromJSON at:'success') = true) 
			ifTrue: [ ^ objectFromJSON at:'result'
			]
			ifFalse: [ ^ objectFromJSON at:'msg' ]
		]
		ifFalse: [ ^ 'error' ]
]

{ #category : #'as yet unclassified' }
SIoTTuya >> getDeviceLog: aStringDeviceID type: aString from: startTimestamp to: endtTimestamp [ 
	
	| result objectFromJSON logs hasMoreLogs nextRowKey|
	result := self getDeviceLogQuery: aStringDeviceID type: aString from: startTimestamp to: endtTimestamp nextRowKey: ''. 
	objectFromJSON := NeoJSONReader fromString: result.
	(objectFromJSON includesKey: #success) 
		ifTrue: [ ((objectFromJSON at:'success') = true) 
			ifTrue: [  
				hasMoreLogs := (objectFromJSON at:'result')at: 'has_next'.
				logs := ((objectFromJSON at:'result')at: 'logs') asOrderedCollection.

				[hasMoreLogs] whileTrue: [
					nextRowKey := (objectFromJSON at:'result')at: 'next_row_key'.
					result := self getDeviceLogQuery: aStringDeviceID type: aString from: startTimestamp to: endtTimestamp nextRowKey: nextRowKey. 
					objectFromJSON := NeoJSONReader fromString: result.
					logs addAll: ((objectFromJSON at:'result')at: 'logs').
					hasMoreLogs := (objectFromJSON at:'result')at: 'has_next'.
				].
				^ logs				
			]
			ifFalse: [ ^ objectFromJSON at:'msg' ]
		]
		ifFalse: [ ^ 'error' ]
		
	"type: (1 online, 2 offline, 3 device activation, 4 device reset, 5 instructions Issue, 6 firmware upgrade, 7 data point report, 8 device semaphore, 9 device restart, 10 timing information)" 
]

{ #category : #'as yet unclassified' }
SIoTTuya >> getDevices [
	
	| result objectFromJSON |
	result := self getDevicesQuery.
	objectFromJSON := NeoJSONReader fromString: result.
	(objectFromJSON includesKey: #success) 
		ifTrue: [ ((objectFromJSON at:'success') = true) 
			ifTrue: [ ^ objectFromJSON at:'result'
			]
			ifFalse: [ ^ objectFromJSON at:'msg' ]
		]
		ifFalse: [ ^ 'error' ]
]

{ #category : #'as yet unclassified' }
SIoTTuya >> getDevicesID [

	| devices devicesID |
	devices := self getDevices.
	(devices includesKey: #devices)
		ifTrue: [ 
			devicesID := Dictionary new.
			(devices at: 'devices') do: [ :a | 
				devicesID add: (a at: 'name') -> (a at: 'id') ].
			^ devicesID ]
		ifFalse: [ ^ devices ]
]

{ #category : #'as yet unclassified' }
SIoTTuya >> getTokens [
	
	| result objectFromJSON |
	result := self getTokensQuery.
	objectFromJSON := NeoJSONReader fromString: result.
	(objectFromJSON includesKey: #success) 
		ifTrue: [ ((objectFromJSON at:'success') = true) 
			ifTrue: [ easyAccessToken := (objectFromJSON at: 'result') at: 'access_token'.
				easyRefreshToken := (objectFromJSON at: 'result') at: 'refresh_token'.
				uid := (objectFromJSON at: 'result') at: 'uid'. 
				^ objectFromJSON at:'result'
			]
			ifFalse: [ ^ objectFromJSON at:'msg' ]
		]
		ifFalse: [ ^ 'error' ]
]

{ #category : #'as yet unclassified' }
SIoTTuya >> refreshTokens [

	timestamp := nil.
	uid := nil.
	easyAccessToken := nil.
	easyRefreshToken := nil.
	easySignToken := nil.
	self getTokens
]

{ #category : #initialization }
SIoTTuya >> updateDevicesList [
	devices := self getDevices at: 'devices'
]

{ #category : #accessing }
SIoTTuya >> user [

	^ user
]

{ #category : #accessing }
SIoTTuya >> user: anObject [

	user := anObject.
	accessID := user accessID.
	accessSecret := user accessSecret
]
