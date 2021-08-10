Class {
	#name : #SIoTApp,
	#superclass : #SpApplication,
	#category : #'SIoT-Interface'
}

{ #category : #'instance creation' }
SIoTApp class >> open [ 
	SIoTDeviceListPresenter new openWithSpec
]
