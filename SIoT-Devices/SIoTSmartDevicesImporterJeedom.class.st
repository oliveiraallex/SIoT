"
I am a class to import devices from Jeedom platform. 
I return a collection of Smart Devices.

SIoTSmartDevicesImporterJeedom new importDevicesFrom: 'localhost' apiKey:'YOUR_APIKEY'


"
Class {
	#name : #SIoTSmartDevicesImporterJeedom,
	#superclass : #SIoTSmartDevicesImporter,
	#instVars : [
		'apiKey'
	],
	#category : #'SIoT-Devices'
}

{ #category : #accessing }
SIoTSmartDevicesImporterJeedom >> apiKey [

	^ apiKey
]

{ #category : #accessing }
SIoTSmartDevicesImporterJeedom >> apiKey: anObject [

	apiKey := anObject
]

{ #category : #'as yet unclassified' }
SIoTSmartDevicesImporterJeedom >> createDevices [
	"Return a collection of smart devices imported from external source"
	| devicesList smartDevices|
	
	devicesList := OrderedCollection new. 
	smartDevices := OrderedCollection new. 
	
		
	self readDevicesList do: [ :object | 
			(object at: 'eqLogics') do: [ :device | devicesList add: device ]  ]. 	

	devicesList do: [ :device |  	
		smartDevices add:(
		SIoTSmartDevices new
			apiKey: self apiKey;
			host: host;
			"path: (devicesExternal at: 'path');"
			id: (device at: 'id');
			name: (device at: 'name');
			alias: (device at: 'eqType_name');
			type: ((device at: 'category') keyAtValue: '1') ;
			commands:  (device at: 'cmds')).
	].
	^ smartDevices
]

{ #category : #accessing }
SIoTSmartDevicesImporterJeedom >> importDevicesFrom: aStringHostNameorIP apiKey: aString [
	
	host := aStringHostNameorIP.
	apiKey := aString.
	externalHTTPPath := 'http://',aStringHostNameorIP,'/core/api/jeeApi.php?apikey=',aString,'&type=fullData'.
	
	self readDevicesList.
	^ self createDevices.
]

{ #category : #'as yet unclassified' }
SIoTSmartDevicesImporterJeedom >> jsonExample [
	^ '[{"id":"1","name":"Apartment","father_id":null,"isVisible":"1","position":null,"configuration":{"parentNumber":0,"tagColor":"#000000","tagTextColor":"#FFFFFF","mobile::summaryTextColor":"","icon":"\u003Ci class=\u0022far fa-lemon\u0022\u003E\u003C\/i\u003E"},"display":[],"image":[],"img":"","eqLogics":[{"sessionCloudTuya":null,"device":null,"id":"1","name":"smart bulb kitchen bf31e04af72da7aad1uvdi","logicalId":"bf31e04af72da7aad1uvdi","generic_type":null,"object_id":"1","eqType_name":"SmartLife","isVisible":"1","isEnable":"1","configuration":{"tuyaID":"bf31e04af72da7aad1uvdi","tuyaType":"light","tuyaName":"smart bulb kitchen","tuyaData":{"brightness":"62","color_mode":"white","online":true,"state":false,"color_temp":1000},"createtime":"2021-06-22 11:45:49","batterytime":"","updatetime":"2021-08-04 04:34:37","battery_type":"","battery_danger_threshold":"","battery_warning_threshold":""},"timeout":null,"category":{"heating":"0","security":"0","energy":"0","light":"1","opening":"0","automatism":"0","multimedia":"0","default":"0"},"display":{"parameters":[],"width":"232px","height":"232px"},"order":"1","comment":"","tags":"","status":{"lastCommunication":"2021-08-04 04:34:37","timeout":0,"warning":0,"danger":0},"cmds":[{"id":"2","logicalId":"BRIGHTNESS","generic_type":null,"eqType":"SmartLife","name":"Luminosité-Info","order":"0","type":"info","subType":"numeric","eqLogic_id":"1","isHistorized":"0","unite":"","configuration":{"minValue":0,"maxValue":100},"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"0","alert":[],"state":24},{"id":"4","logicalId":"REFRESH","generic_type":null,"eqType":"SmartLife","name":"Refresh","order":"1","type":"action","subType":"other","eqLogic_id":"1","isHistorized":"0","unite":"","configuration":[],"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"1","alert":[]},{"id":"3","logicalId":"TEMPERATURE","generic_type":"LIGHT_COLOR_TEMP","eqType":"SmartLife","name":"Blanc-Info","order":"2","type":"info","subType":"numeric","eqLogic_id":"1","isHistorized":"0","unite":"","configuration":{"minValue":0,"maxValue":100},"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"0","alert":[],"state":""},{"id":"1","logicalId":"STATE","generic_type":"LIGHT_STATE","eqType":"SmartLife","name":"Status","order":"3","type":"info","subType":"binary","eqLogic_id":"1","isHistorized":"1","unite":"","configuration":[],"template":{"dashboard":"core::light","mobile":"core::light"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"1","alert":[],"state":0},{"id":"5","logicalId":"TurnOn","generic_type":"LIGHT_ON","eqType":"SmartLife","name":"Allumer","order":"4","type":"action","subType":"other","eqLogic_id":"1","isHistorized":"0","unite":"","configuration":[],"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"1","alert":[]},{"id":"6","logicalId":"TurnOff","generic_type":"LIGHT_OFF","eqType":"SmartLife","name":"Eteindre","order":"5","type":"action","subType":"other","eqLogic_id":"1","isHistorized":"0","unite":"","configuration":[],"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"1","alert":[]},{"id":"7","logicalId":"SetBrightness","generic_type":"LIGHT_SLIDER","eqType":"SmartLife","name":"Luminosité","order":"6","type":"action","subType":"slider","eqLogic_id":"1","isHistorized":"0","unite":"","configuration":{"minValue":0,"maxValue":100},"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":"2","isVisible":"1","alert":[]},{"id":"8","logicalId":"SetTemperature","generic_type":"LIGHT_SET_COLOR_TEMP","eqType":"SmartLife","name":"Blanc","order":"7","type":"action","subType":"slider","eqLogic_id":"1","isHistorized":"0","unite":"","configuration":{"minValue":0,"maxValue":100},"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":"3","isVisible":"1","alert":[]}]},{"sessionCloudTuya":null,"device":null,"id":"2","name":"smart bulb living room  bf3327bef6799a06289uve","logicalId":"bf3327bef6799a06289uve","generic_type":null,"object_id":"1","eqType_name":"SmartLife","isVisible":"1","isEnable":"1","configuration":{"tuyaID":"bf3327bef6799a06289uve","tuyaType":"light","tuyaName":"smart bulb living room ","tuyaData":{"brightness":"104","color_mode":"white","online":true,"state":false,"color_temp":6647},"createtime":"2021-06-22 11:45:49","batterytime":"","updatetime":"2021-08-04 04:34:38","battery_type":"","battery_danger_threshold":"","battery_warning_threshold":""},"timeout":null,"category":{"heating":"0","security":"0","energy":"0","light":"1","opening":"0","automatism":"0","multimedia":"0","default":"0"},"display":{"parameters":[],"width":"232px","height":"232px"},"order":"1","comment":"","tags":"","status":{"lastCommunication":"2021-08-04 04:34:38","timeout":0,"warning":0,"danger":0},"cmds":[{"id":"10","logicalId":"BRIGHTNESS","generic_type":null,"eqType":"SmartLife","name":"Luminosité-Info","order":"0","type":"info","subType":"numeric","eqLogic_id":"2","isHistorized":"0","unite":"","configuration":{"minValue":0,"maxValue":100},"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"0","alert":[],"state":41},{"id":"12","logicalId":"REFRESH","generic_type":null,"eqType":"SmartLife","name":"Refresh","order":"1","type":"action","subType":"other","eqLogic_id":"2","isHistorized":"0","unite":"","configuration":[],"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"1","alert":[]},{"id":"11","logicalId":"TEMPERATURE","generic_type":"LIGHT_COLOR_TEMP","eqType":"SmartLife","name":"Blanc-Info","order":"2","type":"info","subType":"numeric","eqLogic_id":"2","isHistorized":"0","unite":"","configuration":{"minValue":0,"maxValue":100},"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"0","alert":[],"state":35},{"id":"9","logicalId":"STATE","generic_type":"LIGHT_STATE","eqType":"SmartLife","name":"Status","order":"3","type":"info","subType":"binary","eqLogic_id":"2","isHistorized":"1","unite":"","configuration":[],"template":{"dashboard":"core::light","mobile":"core::light"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"1","alert":[],"state":0},{"id":"13","logicalId":"TurnOn","generic_type":"LIGHT_ON","eqType":"SmartLife","name":"Allumer","order":"4","type":"action","subType":"other","eqLogic_id":"2","isHistorized":"0","unite":"","configuration":[],"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"1","alert":[]},{"id":"14","logicalId":"TurnOff","generic_type":"LIGHT_OFF","eqType":"SmartLife","name":"Eteindre","order":"5","type":"action","subType":"other","eqLogic_id":"2","isHistorized":"0","unite":"","configuration":[],"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"1","alert":[]},{"id":"15","logicalId":"SetBrightness","generic_type":"LIGHT_SLIDER","eqType":"SmartLife","name":"Luminosité","order":"6","type":"action","subType":"slider","eqLogic_id":"2","isHistorized":"0","unite":"","configuration":{"minValue":0,"maxValue":100},"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":"10","isVisible":"1","alert":[]},{"id":"16","logicalId":"SetTemperature","generic_type":"LIGHT_SET_COLOR_TEMP","eqType":"SmartLife","name":"Blanc","order":"7","type":"action","subType":"slider","eqLogic_id":"2","isHistorized":"0","unite":"","configuration":{"minValue":0,"maxValue":100},"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":"11","isVisible":"1","alert":[]}]},{"sessionCloudTuya":null,"device":null,"id":"7","name":"Lighting Master Room bf29861dfd74f7c163awdg","logicalId":"bf29861dfd74f7c163awdg","generic_type":null,"object_id":"1","eqType_name":"SmartLife","isVisible":"1","isEnable":"1","configuration":{"tuyaID":"bf29861dfd74f7c163awdg","tuyaType":"light","tuyaName":"Lighting Master Room","tuyaData":{"brightness":"118","color_mode":"colour","online":true,"state":false,"color_temp":"23"},"createtime":"2021-08-04 01:54:11","updatetime":"2021-08-04 04:35:38"},"timeout":null,"category":{"heating":"0","security":"0","energy":"0","light":"1","opening":"0","automatism":"0","multimedia":"0","default":"0"},"display":{"width":"232px","height":"224px"},"order":"1","comment":null,"tags":null,"status":{"lastCommunication":"2021-08-04 04:35:38","timeout":0,"warning":0,"danger":0},"cmds":[{"id":"21","logicalId":"BRIGHTNESS","generic_type":null,"eqType":"SmartLife","name":"Luminosité-Info","order":"0","type":"info","subType":"numeric","eqLogic_id":"7","isHistorized":"0","unite":"","configuration":{"minValue":0,"maxValue":100},"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"0","alert":[],"state":46},{"id":"23","logicalId":"REFRESH","generic_type":null,"eqType":"SmartLife","name":"Refresh","order":"1","type":"action","subType":"other","eqLogic_id":"7","isHistorized":"0","unite":"","configuration":[],"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"1","alert":[]},{"id":"22","logicalId":"TEMPERATURE","generic_type":"LIGHT_COLOR_TEMP","eqType":"SmartLife","name":"Blanc-Info","order":"2","type":"info","subType":"numeric","eqLogic_id":"7","isHistorized":"0","unite":"","configuration":{"minValue":0,"maxValue":100},"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"0","alert":[],"state":23},{"id":"20","logicalId":"STATE","generic_type":"LIGHT_STATE","eqType":"SmartLife","name":"Status","order":"3","type":"info","subType":"binary","eqLogic_id":"7","isHistorized":"1","unite":"","configuration":[],"template":{"dashboard":"core::light","mobile":"core::light"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"1","alert":[],"state":0},{"id":"24","logicalId":"TurnOn","generic_type":"LIGHT_ON","eqType":"SmartLife","name":"Allumer","order":"4","type":"action","subType":"other","eqLogic_id":"7","isHistorized":"0","unite":"","configuration":[],"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"1","alert":[]},{"id":"25","logicalId":"TurnOff","generic_type":"LIGHT_OFF","eqType":"SmartLife","name":"Eteindre","order":"5","type":"action","subType":"other","eqLogic_id":"7","isHistorized":"0","unite":"","configuration":[],"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"1","alert":[]},{"id":"26","logicalId":"SetBrightness","generic_type":"LIGHT_SLIDER","eqType":"SmartLife","name":"Luminosité","order":"6","type":"action","subType":"slider","eqLogic_id":"7","isHistorized":"0","unite":"","configuration":{"minValue":0,"maxValue":100},"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":"21","isVisible":"1","alert":[]},{"id":"27","logicalId":"SetTemperature","generic_type":"LIGHT_SET_COLOR_TEMP","eqType":"SmartLife","name":"Blanc","order":"7","type":"action","subType":"slider","eqLogic_id":"7","isHistorized":"0","unite":"","configuration":{"minValue":0,"maxValue":100},"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":"22","isVisible":"1","alert":[]},{"id":"28","logicalId":"SetColor","generic_type":"LIGHT_SET_COLOR","eqType":"SmartLife","name":"Couleur","order":"8","type":"action","subType":"color","eqLogic_id":"7","isHistorized":"0","unite":"","configuration":{"lastCmdValue":"#d20f0f"},"template":{"dashboard":"core::default","mobile":"core::default"},"display":{"showStatsOnmobile":0,"showStatsOndashboard":0,"invertBinary":"0"},"value":null,"isVisible":"1","alert":[]}]}]}]
'
]

{ #category : #accessing }
SIoTSmartDevicesImporterJeedom >> readDevicesList [
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
