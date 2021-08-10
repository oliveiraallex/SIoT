Class {
	#name : #SIoTConfiguration,
	#superclass : #Object,
	#instVars : [
		'host',
		'key'
	],
	#classInstVars : [
		'configuration'
	],
	#category : #'SIoT-Interface'
}

{ #category : #adding }
SIoTConfiguration class >> addConfiguration: aConfiguration [
	
	self configuration add: aConfiguration
]

{ #category : #adding }
SIoTConfiguration class >> configuration [

	^ configuration ifNil: [ configuration := OrderedCollection new ]
]

{ #category : #accessing }
SIoTConfiguration >> host [

	^ host
]

{ #category : #accessing }
SIoTConfiguration >> host: anObject [

	host := anObject
]

{ #category : #accessing }
SIoTConfiguration >> key [

	^ key
]

{ #category : #accessing }
SIoTConfiguration >> key: anObject [

	key := anObject
]
