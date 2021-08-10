Class {
	#name : #SIoTDeviceListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'deviceList',
		'detail'
	],
	#category : #'SIoT-Interface'
}

{ #category : #initialization }
SIoTDeviceListPresenter class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: #deviceList;
		  add: #detail;
		  yourself
]

{ #category : #specs }
SIoTDeviceListPresenter class >> defaultSpec [

	^ self defaultLayout
]

{ #category : #examples }
SIoTDeviceListPresenter class >> open [
	<example>
	
	^ self new
		openWithSpec
]

{ #category : #initialization }
SIoTDeviceListPresenter >> cleanList [

	SIoTDevices cleanDevices.
	self updatePresenter
]

{ #category : #initialization }
SIoTDeviceListPresenter >> configure [

	| dialog windowPresenter |
	dialog := SIoTConfigurationPresenter newApplication: self application.
	SIoTConfiguration configuration isNotEmpty ifTrue: [ 
	dialog hostText text: SIoTConfiguration configuration last host.
	dialog keyText text: SIoTConfiguration configuration last key].
	windowPresenter := dialog openModalWithSpec.
	windowPresenter isOk ifFalse: [ ^ self ].
	SIoTConfiguration addConfiguration: (SIoTConfiguration new
			 host: dialog hostText text;
			 key: dialog keyText text).
	self updatePresenter
]

{ #category : #initialization }
SIoTDeviceListPresenter >> initializePresenters [

	deviceList := self newTable
						"addColumn:
			            (SpStringTableColumn title: 'Select' evaluated: #select);"
		            addColumn:
			            (SpStringTableColumn title: 'Name' evaluated: #name);
		            addColumn:
			            (SpStringTableColumn title: 'Alias' evaluated: #alias);
		            addColumn:
			            (SpStringTableColumn title: 'Type' evaluated: #type);
		            yourself.
	detail := self instantiate: SIoTDevicesPresenter.
	detail enabled: false.
	deviceList whenSelectionChangedDo: [ :selectedItemMode | 
		selectedItemMode isEmpty ifFalse: [ 
			detail setModel: selectedItemMode selectedItem ] ].
	self updatePresenter
]

{ #category : #initialization }
SIoTDeviceListPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'SIoT';
		initialExtent: 600 @ 400;
		toolbar: (self newToolbar 
			addItem: (self newToolbarButton
			label: 'Scan devices';
			icon: (self application iconNamed: #glamorousRefresh);
			action: [ self scanDevices ];
			yourself);
			addItem: (self newToolbarButton
			label: 'Configure';
			icon: (self application iconNamed: #smallConfiguration);
			action: [ self configure ];
			yourself);
			addItem: (self newToolbarButton
			label: 'Clean list';
			icon: (self application iconNamed: #glamorousLargeGrayCircleEmphasized);
			action: [ self cleanList ];
			yourself);
			
		yourself)
]

{ #category : #initialization }
SIoTDeviceListPresenter >> scanDevices [

	| jeedomDevices  | 
	
	SIoTConfiguration configuration isNotEmpty ifTrue: [ 	
	jeedomDevices := SIoTSmartDevicesImporterJeedom new 
		importDevicesFrom: SIoTConfiguration configuration last host
		apiKey: SIoTConfiguration configuration last key.
	jeedomDevices do: [ :device | 
		SIoTDevices addDevice: device
		  ] ].
	self updatePresenter
]

{ #category : #initialization }
SIoTDeviceListPresenter >> scanDevicesOld [

	| dialog windowPresenter |
	dialog := SIoTDevicesPresenter newApplication: self application.
	windowPresenter := dialog openModalWithSpec.
	windowPresenter isOk ifFalse: [ ^ self ].
	SIoTDevices addDevice: (SIoTDevices new
			 name: dialog nameText text;
			 alias: dialog aliasText text;
			 type: dialog typeText text;
			 selected: dialog selectedText text).
	self updatePresenter
]

{ #category : #initialization }
SIoTDeviceListPresenter >> updatePresenter [

	deviceList items: SIoTDevices devices 
]
