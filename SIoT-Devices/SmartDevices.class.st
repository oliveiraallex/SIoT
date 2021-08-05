"
I am a class for instantiating smart device objects

light01 := SmartDevices new.

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

command := RunCommandJeedom new. 
command onDevice: light01.
command commands. 
command onDevice: light01; command: 'turnOff'.

command commandLine.
command run.
"
Class {
	#name : #SmartDevices,
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
SmartDevices >> alias [

	^ alias
]

{ #category : #accessing }
SmartDevices >> alias: anObject [

	alias := anObject
]

{ #category : #accessing }
SmartDevices >> apiKey [

	^ apiKey
]

{ #category : #accessing }
SmartDevices >> apiKey: anObject [

	apiKey := anObject
]

{ #category : #accessing }
SmartDevices >> commands [

	^ commands
]

{ #category : #accessing }
SmartDevices >> commands: anObject [

	commands := anObject
]

{ #category : #accessing }
SmartDevices >> host [

	^ host
]

{ #category : #accessing }
SmartDevices >> host: anObject [

	host := anObject
]

{ #category : #accessing }
SmartDevices >> id [

	^ id
]

{ #category : #accessing }
SmartDevices >> id: anObject [

	id := anObject
]

{ #category : #accessing }
SmartDevices >> name [

	^ name
]

{ #category : #accessing }
SmartDevices >> name: anObject [

	name := anObject
]

{ #category : #accessing }
SmartDevices >> path [

	^ path
]

{ #category : #accessing }
SmartDevices >> path: anObject [

	path := anObject
]

{ #category : #accessing }
SmartDevices >> type [

	^ type
]

{ #category : #accessing }
SmartDevices >> type: anObject [

	type := anObject
]
