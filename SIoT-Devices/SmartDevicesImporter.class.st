"
I am a class to import devices from a external source. 
I return a collection of Smart Devices.

SmartDevicesImporter new importDevicesFrom: 'http://localhost/plugins/SmartIoT/devices.json'.


"
Class {
	#name : #SmartDevicesImporter,
	#superclass : #Object,
	#instVars : [
		'externalHTTPPath'
	],
	#category : #'SIoT-Devices'
}

{ #category : #'as yet unclassified' }
SmartDevicesImporter >> createDevices [
	"Return a collection of smart devices imported from external source"
	| devicesList devicesExternal smartDevices|
	devicesExternal := self readDevicesList.
	devicesList := devicesExternal at: 'devices'.
	smartDevices := OrderedCollection new. 

	devicesList do: [ :device | 	
		smartDevices add:(
		SmartDevices new
			apiKey: (devicesExternal at: 'apiKey');
			host: (devicesExternal at: 'host');
			path: (devicesExternal at: 'path');
			id: (device at: 'id');
			name: (device at: 'name');
			alias: (device at: 'alias');
			type: (device at: 'type');
			commands:  (device at: 'commands')).
	].
	^ smartDevices
]

{ #category : #accessing }
SmartDevicesImporter >> externalHTTPPath [

	^ externalHTTPPath
]

{ #category : #accessing }
SmartDevicesImporter >> externalHTTPPath: anObject [

	externalHTTPPath := anObject
]

{ #category : #accessing }
SmartDevicesImporter >> importDevicesFrom: aHTTPPath [

	externalHTTPPath := aHTTPPath.
	^ self createDevices.
]

{ #category : #'as yet unclassified' }
SmartDevicesImporter >> jsonExample [
	^ '{
  "host": "127.0.0.1",
  "path": "core/api/jeeApi.php",
  "apiKey": "IflYuUGKUuBODnZQaLebLqeTk4jhLPti",
  "devices": [
    {
      "id": "1",
      "name": "smart bulb living room bf31e04af72da7aad1uvdi",
      "alias": "Light Living Room",
      "type": "light",
      "commands": [
        {
          "type": "GET",
          "alias": "Turn On",
          "id": "15",
          "name": "turnOn",
          "command": "15"
        },
        {
          "type": "GET",
          "alias": "Turn Off",
          "id": "16",
          "name": "turnOff",
          "command": "16"
        }
      ]
    },
    {
      "id": "2",
      "name": "smart bulb kitchen bf31e04af72da7aad1uvdi",
      "alias": "Light Kitchen",
      "type": "light",
      "commands": [
        {
          "type": "GET",
          "alias": "Turn On",
          "id": "13",
          "name": "turnOn",
          "command": "13"
        },
        {
          "type": "GET",
          "alias": "Turn Off",
          "id": "14",
          "name": "turnOff",
          "command": "14"
        }
      ]
    }
  ]
}'
]

{ #category : #accessing }
SmartDevicesImporter >> readDevicesList [
	"Read a JSON file and return an object"
	| webClient externalJson |
	webClient := ZnClient new.

	externalHTTPPath
		ifNil: [ externalJson := self jsonExample ]
		ifNotNil: [ externalJson := webClient url: externalHTTPPath; get ].

	^ (NeoJSONReader on: externalJson readStream)
		  listClass: Array;
		  next
]
