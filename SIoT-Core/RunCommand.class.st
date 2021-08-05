Class {
	#name : #RunCommand,
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
RunCommand >> command [

	^ command
]

{ #category : #accessing }
RunCommand >> command: aString [

	command := aString 
]

{ #category : #accessing }
RunCommand >> command: aString parameters: anObject [

	parameters := anObject
]

{ #category : #accessing }
RunCommand >> commandLine [

	^ commandLine
]

{ #category : #accessing }
RunCommand >> commandLine: anObject [

	^ commandLine := anObject
]

{ #category : #accessing }
RunCommand >> commands [

	^ commands
]

{ #category : #accessing }
RunCommand >> commands: anObject [

	commands := anObject
]

{ #category : #accessing }
RunCommand >> device [

	^ device
]

{ #category : #accessing }
RunCommand >> device: anObject [

	device := anObject
	
]

{ #category : #control }
RunCommand >> extractCommands [
	commands := OrderedCollection new.  
	device commands do: [ :a | 
		commands add: ( a at: 'name' ) ]
	
]

{ #category : #accessing }
RunCommand >> onDevice: anObject [

	device := anObject.
	self extractCommands.
	
]

{ #category : #accessing }
RunCommand >> parameters [

	^ parameters
]

{ #category : #accessing }
RunCommand >> run [
	self subclassResponsibility
]
