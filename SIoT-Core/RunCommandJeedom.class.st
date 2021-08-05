Class {
	#name : #RunCommandJeedom,
	#superclass : #RunCommand,
	#category : #'SIoT-Core'
}

{ #category : #accessing }
RunCommandJeedom >> command: aString [

	command := aString.
	self createCommandLine
]

{ #category : #accessing }
RunCommandJeedom >> command: aString parameters: anObject [

	command := aString.
	parameters := anObject.
	self createCommandLine
]

{ #category : #accessing }
RunCommandJeedom >> createCommandLine [
	
	| commandInfo commandRaw arguments webClient | 
	
	commandInfo := device commands detect: [ :list | (list at: 'name') = self command ].
	commandRaw := commandInfo at: 'command'.
	
	arguments :=
			{('apikey' -> device apiKey asString).
			('type' -> 'cmd').
			('id' -> commandRaw )} asDictionary.
			
	webClient := ZnClient new url: ('http://', device host , '/' ,device path) ; queryAddAll: arguments.
	^ commandLine := webClient request requestLine uri asString
]

{ #category : #accessing }
RunCommandJeedom >> run [ 
	^ self runCommandLine
]

{ #category : #accessing }
RunCommandJeedom >> runCommandLine [
	
	| webClient |
	webClient := ZnClient new. 
	webClient url: commandLine.
	^ webClient get asString
]
