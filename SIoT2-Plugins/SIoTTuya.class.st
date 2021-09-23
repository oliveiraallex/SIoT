Class {
	#name : #SIoTTuya,
	#superclass : #SIoTTuyaQueries,
	#category : #'SIoT2-Plugins'
}

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
