Class {
	#name : #SIoTCommunication,
	#superclass : #Object,
	#category : #'SIoT2-Core'
}

{ #category : #'private - requesting' }
SIoTCommunication >> convertQueryAsString: aDictionary [ 
	| webClient requestLine |
	webClient := ZnClient new queryAddAll: aDictionary.
	requestLine := webClient request requestLine uri asString .
	^ requestLine copyReplaceAll: '/?'  with: ''
	
]

{ #category : #'private - requesting' }
SIoTCommunication >> get: path [
	^ self get: path parameters: {} asDictionary
]

{ #category : #'private - requesting' }
SIoTCommunication >> get: path parameters: aDictionary [
	| webClient get | 
	webClient := ZnClient new. 
	webClient url: path.
	webClient queryAddAll: aDictionary.
	get := [NeoJSONReader fromString: webClient get asString] ifError: [ :error | SIoTLogger logAdd: 'ERROR ', error asString ].
	^ get
]
