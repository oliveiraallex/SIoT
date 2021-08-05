"
I am a class for instantiating smart device objects

light01 := SIoTSmartDevices new.

light01 
id: 1;
apiKey: 'IflYuUGKUuBODnZQaLebLqeTk4jhLPti';
host: '127.0.0.1';
path: 'core/api/jeeApi.php';
name: 'smart bulb kitchen bf31e04af72da7aad1uvdi';
alias: 'Light Kitchen';
type: 'light'. 

command01 := {
	('id' -> '13').
	('name' -> 'turnOn').
	('alias' -> 'Turn On').
	('command' -> '13').
	('type' -> 'GET')} asDictionary. 


command02 := {
	('id' -> '14').
	('name' -> 'turnOff').
	('alias' -> 'Turn Off').
	('command' -> '14').
	('type' -> 'GET')} asDictionary. 
	
commands := OrderedCollection with: command01 with: command02.

light01 commands: commands.

command := SIoTRunCommandJeedom new. 
command onDevice: light01.
command commands. 
command onDevice: light01; command: 'turnOff'.

command commandLine.
command run.
"
Class {
	#name : #SIoTSmartDevices,
	#superclass : #Object,
	#instVars : [
		'host',
		'path',
		'id',
		'apiKey',
		'name',
		'type',
		'alias',
		'commands'
	],
	#category : #'SIoT-Devices'
}

{ #category : #accessing }
SIoTSmartDevices >> alias [

	^ alias
]

{ #category : #accessing }
SIoTSmartDevices >> alias: anObject [

	alias := anObject
]

{ #category : #accessing }
SIoTSmartDevices >> apiKey [

	^ apiKey
]

{ #category : #accessing }
SIoTSmartDevices >> apiKey: anObject [

	apiKey := anObject
]

{ #category : #accessing }
SIoTSmartDevices >> commands [

	^ commands
]

{ #category : #accessing }
SIoTSmartDevices >> commands: anObject [

	commands := anObject
]

{ #category : #accessing }
SIoTSmartDevices >> host [

	^ host
]

{ #category : #accessing }
SIoTSmartDevices >> host: anObject [

	host := anObject
]

{ #category : #accessing }
SIoTSmartDevices >> id [

	^ id
]

{ #category : #accessing }
SIoTSmartDevices >> id: anObject [

	id := anObject
]

{ #category : #accessing }
SIoTSmartDevices >> name [

	^ name
]

{ #category : #accessing }
SIoTSmartDevices >> name: anObject [

	name := anObject
]

{ #category : #accessing }
SIoTSmartDevices >> path [

	^ path
]

{ #category : #accessing }
SIoTSmartDevices >> path: anObject [

	path := anObject
]

{ #category : #accessing }
SIoTSmartDevices >> type [

	^ type
]

{ #category : #accessing }
SIoTSmartDevices >> type: anObject [

	type := anObject
]
