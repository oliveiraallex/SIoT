"
I am a class that read a list of commands of a Smart Device, returns a list of options and let you run the commands

- import the devices from Jeedom platform and create Smart Devices objects in Pharo. It will return a ordered collection of devices:  

devices := SIoTSmartDevicesImporterJeedom new importDevicesFrom: 'localhost' apiKey:'YOUR_APIKEY'.

- print the commands of device:

command := SIoTRunCommandJeedom new onDevice: (devices at: 1); commands.

- run the command of device. It will call the Jeedom API and run the command inside Jeedom:

command onDevice: (devices at: 1); command: 'TurnOn'; run.
"
Class {
	#name : #SIoTRunCommandJeedom,
	#superclass : #SIoTRunCommand,
	#category : #'SIoT-Core'
}

{ #category : #accessing }
SIoTRunCommandJeedom >> command: aString [

	command := aString.
	self createCommandLine
]

{ #category : #accessing }
SIoTRunCommandJeedom >> command: aString parameters: anObject [

	command := aString.
	parameters := anObject.
	self createCommandLine
]

{ #category : #accessing }
SIoTRunCommandJeedom >> createCommandLine [
	
	| commandInfo commandRaw arguments webClient | 
	
	commandInfo := device commands detect: [ :list | (list at: 'logicalId') = self command ].
	commandRaw := commandInfo at: 'id'.
	
	arguments :=
			{('apikey' -> device apiKey asString).
			('type' -> 'cmd').
			('id' -> commandRaw )} asDictionary.
			
	webClient := ZnClient new url: ('http://', device host , '/' ,device path) ; queryAddAll: arguments.
	^ commandLine := webClient request requestLine uri asString
]

{ #category : #accessing }
SIoTRunCommandJeedom >> run [ 
	^ self runCommandLine
]

{ #category : #accessing }
SIoTRunCommandJeedom >> runCommandLine [
	
	| webClient |
	webClient := ZnClient new. 
	webClient url: commandLine.
	^ webClient get asString
]
