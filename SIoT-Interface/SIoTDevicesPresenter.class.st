Class {
	#name : #SIoTDevicesPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'buttonNormal',
		'buttonOnText',
		'buttonOffText',
		'deviceText'
	],
	#category : #'SIoT-Interface'
}

{ #category : #initialization }
SIoTDevicesPresenter class >> defaultLayout [

	^ SpGridLayout new
		  beRowNotHomogeneous;
		  beColumnNotHomogeneous;
		  column: 3 withConstraints: #beExpand;
		  add: #deviceText at: 1 @ 1;  
		  add: #buttonOnText at: 1 @ 2;  add: #buttonOffText at: 2 @ 2; 
		  yourself
]

{ #category : #specs }
SIoTDevicesPresenter class >> defaultSpec [

	^ self defaultLayout
]

{ #category : #examples }
SIoTDevicesPresenter class >> open [
	<example>
	
	^ self new
		openWithSpec
]

{ #category : #initialization }
SIoTDevicesPresenter >> initializeDialogWindow: aDialogPresenter [

	aDialogPresenter centered.
	aDialogPresenter
		addButton: 'Cancel' do: [ :presenter | presenter close ];
		addButton: 'Save Device' do: [ :presenter | 
			presenter
				beOk;
				close ]
]

{ #category : #initialization }
SIoTDevicesPresenter >> initializePresenters [

	buttonOnText := self newButton.
	buttonOffText := self newButton.
	deviceText := self newText
]

{ #category : #initialization }
SIoTDevicesPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Smart Devices';
		initialExtent: 400 @ 250
]

{ #category : #initialization }
SIoTDevicesPresenter >> setModel: aSmartDevice [ 
	| runCommand |
	runCommand := SIoTRunCommandJeedom new onDevice: aSmartDevice.
	runCommand commands.
	deviceText text: aSmartDevice name. 
	buttonOnText label: 'Turn On' ; action: [runCommand onDevice: aSmartDevice; command: 'TurnOn'; run].
	buttonOffText label: 'Turn Off' ; action: [runCommand onDevice: aSmartDevice; command: 'TurnOff'; run].
]
