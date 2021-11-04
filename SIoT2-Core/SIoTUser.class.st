Class {
	#name : #SIoTUser,
	#superclass : #Object,
	#instVars : [
		'accessID',
		'accessSecret',
		'platform',
		'devicesID',
		'processes',
		'logger'
	],
	#category : #'SIoT2-Core'
}

{ #category : #accessing }
SIoTUser >> accessID [

	^ accessID
]

{ #category : #accessing }
SIoTUser >> accessID: anObject [

	accessID := anObject
]

{ #category : #accessing }
SIoTUser >> accessSecret [

	^ accessSecret
]

{ #category : #accessing }
SIoTUser >> accessSecret: anObject [

	accessSecret := anObject
]

{ #category : #accessing }
SIoTUser >> devicesID [

	^ devicesID
]

{ #category : #accessing }
SIoTUser >> devicesID: anObject [

	devicesID := anObject
]

{ #category : #'as yet unclassified' }
SIoTUser >> formatDataCsv: aString [ 

	^ (aString at:'current') asString,',',(aString at:'power') asString,',',(aString at:'voltage')asString
]

{ #category : #'as yet unclassified' }
SIoTUser >> formatDataPoints: aString deviceID: aString2 [

	| deviceCategory tempData formatedData |

	platform devices do: [ :item | ((item at: 'id') = aString2) ifTrue: [deviceCategory := item at: 'category' ] ].

	formatedData := Dictionary new.
	
	(deviceCategory = 'zndb') ifTrue: [ 
		tempData := (aString at: 2)	at: 'value'.
		tempData := NeoJSONReader fromString: tempData.
		formatedData add: #current -> (tempData at: 'electricCurrent').
		formatedData add: #power -> ((tempData at: 'power')*1000).
		formatedData add: #voltage -> (tempData at: 'voltage').
		^ formatedData ].
	
	(deviceCategory = 'cz') ifTrue: [ 
		formatedData add: #current -> (((aString at: 4)	at: 'value')/1000.0).
		formatedData add: #power -> (((aString at: 5)	at: 'value')/10.0).
		formatedData add: #voltage -> (((aString at: 6)	at: 'value')/10.0).
		^ formatedData ]. 
]

{ #category : #'as yet unclassified' }
SIoTUser >> initialize [

	processes := Dictionary new.
	logger := SIoTLogger new.
]

{ #category : #'as yet unclassified' }
SIoTUser >> logDataPoints: aString deviceID: aStringDeviceID [
	
	| dataPoints dataCsv | 

	dataPoints := self formatDataPoints: aString deviceID: aStringDeviceID.

	dataCsv := self formatDataCsv: dataPoints.

	logger logAdd: dataCsv fileName: aStringDeviceID
]

{ #category : #accessing }
SIoTUser >> platform [

	^ platform
]

{ #category : #accessing }
SIoTUser >> platform: anObject [

	platform := anObject new.
	platform accessID: accessID accessSecret: accessSecret
]

{ #category : #accessing }
SIoTUser >> processes [

	^ processes
]

{ #category : #accessing }
SIoTUser >> processes: anObject [

	processes := anObject
]

{ #category : #'as yet unclassified' }
SIoTUser >> singleTrack: aString [
	|  dataPoints|
	
	^ [  		
	dataPoints := platform getDeviceDataPoints: aString.
	(dataPoints = 'token invalid') ifTrue: [ 
			platform refreshTokens. 
			dataPoints := platform getDeviceDataPoints: aString. ].

	self logDataPoints: dataPoints deviceID: aString.
	Transcript show: dataPoints asString ; cr.
	1 second wait.
	] on: Error do: [:ignore | ^ nil ]
]

{ #category : #'as yet unclassified' }
SIoTUser >> startMonitorDeviceID: aString [
	
	| processCreated |

	processCreated := processes includesKey: aString.
	processCreated ifTrue: [ self stopMonitorDeviceID: aString ].

	processes add: aString -> ([ [ self singleTrack: aString]  repeat. ] forkNamed: 'SIoT Monitor: ',(self devicesID keyAtValue: aString)).
]

{ #category : #'as yet unclassified' }
SIoTUser >> stopMonitorDeviceID: aString [

	(processes at: aString) terminate
]

{ #category : #accessing }
SIoTUser >> udpateDevicesData [
	platform updateDevicesList. 
	devicesID := platform getDevicesID. 
]

{ #category : #accessing }
SIoTUser >> updatePlatformData [

	platform refreshTokens.
]
