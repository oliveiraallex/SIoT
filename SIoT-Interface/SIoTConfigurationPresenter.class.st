Class {
	#name : #SIoTConfigurationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'hostText',
		'keyText'
	],
	#category : #'SIoT-Interface'
}

{ #category : #specs }
SIoTConfigurationPresenter class >> defaultLayout [

	^ SpGridLayout new
		  beRowNotHomogeneous;
		  beColumnNotHomogeneous;
		  column: 2 withConstraints: #beExpand;
		  add: 'Host' at: 1 @ 1;  add: #hostText at: 2 @ 1;
		  add: 'Jeedom Key' at: 1 @ 2;  add: #keyText at: 2 @ 2;
		  yourself
]

{ #category : #specs }
SIoTConfigurationPresenter class >> defaultSpec [

	^ self defaultLayout
]

{ #category : #specs }
SIoTConfigurationPresenter class >> open [
	<example>
	
	^ self new
		openWithSpec
]

{ #category : #accessing }
SIoTConfigurationPresenter >> hostText [

	^ hostText
]

{ #category : #accessing }
SIoTConfigurationPresenter >> hostText: anObject [

	hostText := anObject
]

{ #category : #initialization }
SIoTConfigurationPresenter >> initializePresenters [
	
	hostText := self newTextInput.
	keyText := self newTextInput.
]

{ #category : #initialization }
SIoTConfigurationPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Configuration';
		initialExtent: 400 @ 250
]

{ #category : #accessing }
SIoTConfigurationPresenter >> keyText [

	^ keyText
]

{ #category : #accessing }
SIoTConfigurationPresenter >> keyText: anObject [

	keyText := anObject
]

{ #category : #initialization }
SIoTConfigurationPresenter >> setModel: aSmartDevice [

	hostText boolean: aSmartDevice host. 
	keyText text: aSmartDevice key.
]
