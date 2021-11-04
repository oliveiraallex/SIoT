Class {
	#name : #SIoTLogger,
	#superclass : #Object,
	#instVars : [
		'buffer'
	],
	#category : #'SIoT2-Core'
}

{ #category : #adding }
SIoTLogger class >> logAdd: aString [
	| logFile timestamp |
	logFile := 'SIoTLog.txt' asFileReference.
	timestamp := Date current yyyymmdd asString , ' ', Time current asString.
	logFile
		writeStreamDo: [ :s | 
			s setToEnd.
			s 	nextPutAll: timestamp;
				tab;
				nextPutAll: aString asString;
				cr;lf;
				flush ]
]

{ #category : #'as yet unclassified' }
SIoTLogger >> getUnixTimestamp [
	"Return Unix Timestamp (miliseconds since Jan 01 1970 UTC)"  
	^ (Time primUTCSecondsClock - 2177452800) asString
]

{ #category : #adding }
SIoTLogger >> logAdd: aString fileName: aStringDeviceID [
	| timestamp lastTimestamp string lf cr bufferArray missedTimestamp|
	
	cr := Character cr asString.
	lf := Character lf asString.
	timestamp := self getUnixTimestamp.
	
	string := timestamp,',',aString,cr,lf.

	buffer 
		ifNil: [ buffer := string ] 
		ifNotNil: [ 
			lastTimestamp := ((buffer substrings: ',') at: 1). 
			((timestamp asInteger - lastTimestamp asInteger) > 1)
				ifTrue: [ bufferArray := buffer substrings: ','.
					missedTimestamp := ((timestamp asInteger - 1 )asString),',',(bufferArray at: 2),',',(bufferArray at: 3),',',(bufferArray at: 4).
					string := missedTimestamp , string.
					buffer := nil ]
				ifFalse: [ buffer := string ].
			]. 
	
	self writeStream: string onFile: (aStringDeviceID,'.csv')
]

{ #category : #writing }
SIoTLogger >> writeStream: aString onFile: aStringFileName [
	| logFile |
	
	logFile := aStringFileName asFileReference.

	logFile
		writeStreamDo: [ :s | 
			s setToEnd.
			s nextPutAll: aString ;
			flush ]
]
