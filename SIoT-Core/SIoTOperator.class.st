"
I am a class to implement and manage devices, commands and tasks
"
Class {
	#name : #SIoTOperator,
	#superclass : #Object,
	#instVars : [
		'devices'
	],
	#category : #'SIoT-Core'
}

{ #category : #'as yet unclassified' }
SIoTOperator >> createTask [
]

{ #category : #'as yet unclassified' }
SIoTOperator >> deleteTask [
]

{ #category : #accessing }
SIoTOperator >> devices [

	^ devices
]

{ #category : #accessing }
SIoTOperator >> devices: anObject [

	devices := anObject
]

{ #category : #'as yet unclassified' }
SIoTOperator >> initialize [
	devices :=  SIoTSmartDevicesImporter new importDevicesFrom: 'http://localhost/plugins/SmartIoT/devices.json'.
]

{ #category : #'as yet unclassified' }
SIoTOperator >> listTasks [
]

{ #category : #'as yet unclassified' }
SIoTOperator >> selectCommands [
	
]

{ #category : #'as yet unclassified' }
SIoTOperator >> selectDevices [

	
]
