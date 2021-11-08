Class {
	#name : #BaselineOfSIoT,
	#superclass : #BaselineOf,
	#category : #BaselineOfSIoT
}

{ #category : #accessing }
BaselineOfSIoT >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'SIoT-Core';
				package: 'SIoT-Devices';
				package: 'SIoT-Interface';
				package: 'SIoT2-Core';
				package: 'SIoT2-Plugins' ].
	spec
		baseline: 'NeoJSON'
		with: [ spec repository: 'github://svenvc/NeoJSON/repository' ]
]

{ #category : #accessing }
BaselineOfSIoT >> projectClass [
	^ MetacelloCypressBaselineProject
]
