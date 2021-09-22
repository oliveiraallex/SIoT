Class {
	#name : #SIoTLog,
	#superclass : #Object,
	#category : #'SIoT2-Core'
}

{ #category : #adding }
SIoTLog class >> logAdd: aString [
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
