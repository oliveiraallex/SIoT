Class {
	#name : #SIoTRunCommand,
	#superclass : #Object,
	#instVars : [
		'device',
		'commands',
		'command',
		'parameters',
		'commandLine'
	],
	#category : #'SIoT-Core'
}

{ #category : #accessing }
SIoTRunCommand >> command [

	^ command
]

{ #category : #accessing }
SIoTRunCommand >> command: aString [

	command := aString 
]

{ #category : #accessing }
SIoTRunCommand >> command: aString parameters: anObject [

	parameters := anObject
]

{ #category : #accessing }
SIoTRunCommand >> commandLine [

	^ commandLine
]

{ #category : #accessing }
SIoTRunCommand >> commandLine: anObject [

	^ commandLine := anObject
]

{ #category : #accessing }
SIoTRunCommand >> commands [

	^ commands
]

{ #category : #accessing }
SIoTRunCommand >> commands: anObject [

	commands := anObject
]

{ #category : #accessing }
SIoTRunCommand >> device [

	^ device
]

{ #category : #accessing }
SIoTRunCommand >> device: anObject [

	device := anObject
	
]

{ #category : #control }
SIoTRunCommand >> extractCommands [
	commands := OrderedCollection new.  
	device commands do: [ :a | 
		commands add: ( a at: 'name' ) ]
	
]

{ #category : #accessing }
SIoTRunCommand >> onDevice: anObject [

	device := anObject.
	self extractCommands.
	
]

{ #category : #accessing }
SIoTRunCommand >> parameters [

	^ parameters
]

{ #category : #accessing }
SIoTRunCommand >> run [
	self subclassResponsibility
]
