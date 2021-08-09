"
I am a class that read a list of commands of a Smart Device, returns a list of options and let you run the commands

- import the devices from Jeedom platform and create Smart Devices objects in Pharo. It will return a ordered collection of devices:  

jeedomDevices := SIoTSmartDevicesImporterJeedom new importDevicesFrom: 'localhost' apiKey:'YOUR_APIKEY'.

- print the commands of device:

smartDevice := (jeedomDevices at: 2).
runCommand := SIoTRunCommandJeedom new onDevice: smartDevice.
runCommand commands.

- run the command of device. It will call the Jeedom API and run the command inside Jeedom:

runCommand onDevice: smartDevice; command: 'TurnOn'; run.
runCommand onDevice: smartDevice; command: 'TurnOff'; run.
runCommand onDevice: smartDevice; command: 'TEMPERATURE'; run.
runCommand onDevice: smartDevice; command: 'SetTemperature' parameters: '50'; run.
runCommand onDevice: smartDevice; command: 'BRIGHTNESS'; run.
runCommand onDevice: smartDevice; command: 'SetBrightness' parameters: '100'; run.
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

	parameters ifNotNil: [ arguments at: ((commandInfo at: 'subType')asString) put: parameters asString ].
			
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
